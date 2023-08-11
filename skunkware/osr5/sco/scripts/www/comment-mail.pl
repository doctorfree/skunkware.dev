#!/usr/local/bin/perl -- -*-perl-*-
# @(#) comment-mail.perl 1.1 96/03/16

# ------------------------------------------------------------
# Form-mail.pl, by Reuven M. Lerner (reuven@the-tech.mit.edu).
#
# Last updated: March 14, 1994
#
# Form-mail provides a mechanism by which users of a World-
# Wide Web browser may submit comments to the webmasters
# (or anyone else) at a site.  It should be compatible with
# any CGI-compatible HTTP server.
# 
# Please read the README file that came with this distribution
# for further details.
# ------------------------------------------------------------
# 94/04/02 john@armory.com   Generalized a bit.
# 96/02/09 john@armory.com   Fixed to deal with trailing / in PATH_INFO
# 96/02/10 john@armory.com   Deal with trailing newline in hostname;
#                            added processing of subject field.
# 96/03/16 john@armory.com   Print a few more env vars if available.

# ------------------------------------------------------------
# This package is Copyright 1994 by The Tech. 

# Form-mail is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.

# Form-mail is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Form-mail; see the file COPYING.  If not, write to the Free
# Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
# ------------------------------------------------------------

# Define fairly-constants

# This should match the mail program on your system.
#$mailprog = '/usr/lib/mail/execmail';
$mailprog = '/usr/lib/sendmail';
$host = `hostname`;
$host =~ s/\n//g;	# get rid of trailing newline if any 
# PATH_INFO will be set to /recip=username
$pinfo = substr($ENV{'PATH_INFO'},7);
# Get rid of trailing / if PATH_INFO was set to /recip=username/
if (substr($pinfo,(length $pinfo) - 1,1) eq '/') {
    $pinfo = substr($pinfo,0,(length $pinfo) - 1);
}
$recipient = $pinfo . '@' . $host;

# Print out a content-type for HTTP/1.0 compatibility
print "Content-type: text/html\n\n";

# Print a title and initial heading
print "<Head><Title>Comment Reply</Title></Head>\n";

# Get the input
read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});

# Split the name-value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs)
{
    ($name, $value) = split(/=/, $pair);

    # Un-Webify plus signs and %-encoding
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    # Stop people from using subshells to execute commands
    # Not a big deal when using sendmail, but very important
    # when using UCB mail (aka mailx).
    # $value =~ s/~!/ ~!/g; 

    # Uncomment for debugging purposes
    # print "Setting $name to $value<P>";

    $FORM{$name} = $value;
}

# If the comments are blank, then give a "blank form" response
&blank_response unless $FORM{'comments'};
&name_response unless $FORM{'name'};
if ($pinfo !~ /^[-a-zA-Z0-9_.=]+$/) {
    &recip_response
}

# Now send mail to $recipient

open (MAIL, "|$mailprog $recipient") || die "Can't open $mailprog!\n";
print MAIL "Reply-to: $FORM{'email'} ($FORM{'name'})\n";
print MAIL "From: www@" . $host . "\n";
print MAIL "Subject: WWW comments" . ( $FORM{'subject'} ne '' ?
" re: " . $FORM{'subject'} : " (Forms submission)" ) . "\n\n";
print MAIL "$FORM{'name'} ($FORM{'email'}) sent the following\n";
print MAIL "comment about your WWW page:\n\n";
if ($FORM{'url'}) {
    print MAIL  "----------------------------------------------------------\n";
    print MAIL "URL: $FORM{'url'}\n";
}
print MAIL  "----------------------------------------------------------\n";
print MAIL "$FORM{'comments'}";
print MAIL "\n----------------------------------------------------------\n";
print MAIL "Server protocol: $ENV{'SERVER_PROTOCOL'}\n";
if ($ENV{'REMOTE_HOST'}) {
    print MAIL "Remote host: $ENV{'REMOTE_HOST'}\n";
}
print MAIL "Remote IP address: $ENV{'REMOTE_ADDR'}\n";
if ($ENV{'HTTP_REFERER'}) {
    print MAIL "Referer: $ENV{'HTTP_REFERER'}\n";
}
if ($ENV{'HTTP_USER_AGENT'}) {
    print MAIL "Referer: $ENV{'HTTP_USER_AGENT'}\n";
}
close (MAIL);

print "<Body><h1>Your comments have been sent.  Thank you!</H1>\n";

sub blank_response
{
    print "Your comment submission appears to be blank, and thus was not sent.";
    print "  Please re-enter and submit.\n";
    exit;
}

sub name_response
{
    print "Your comment did not include a name, and thus was not sent.";
    print "  Please re-enter and submit.\n";
    exit;
}

sub recip_response
{
    print "The recipient ($pinfo) specified on this form is not a user on";
    print "the local machine, so this form was not processed.\n";
    exit;
}
