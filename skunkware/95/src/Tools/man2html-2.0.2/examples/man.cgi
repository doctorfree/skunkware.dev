#!/usr/bin/perl
# man.cgi (doesn't use forms)
#
# Program contributed by Maurice Cinquini <mauricec@tplrd.tpl.oz.au>.
#

$man_prog = '/usr/ucb/man';

print "Content-type: text/html\n\n<ISINDEX>\n";

if ($#ARGV < 0) {
    print "<TITLE>UNIX MAN PAGES</TITLE>\n",
          "Use the keyword search field to select a manual page.\n";
    exit;
}

$args = join(' ',@ARGV);
open(STDIN, "$man_prog $args|");
@ARGV = (
    '-sun',
    '-seealso',
    '-title', "man $args",
    '-cgiurl', 'man.cgi?$section\L$subsection\E+$title'
);

require "perlWWW/man2html";
exit;

