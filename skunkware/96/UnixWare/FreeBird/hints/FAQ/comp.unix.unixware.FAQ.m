Newsgroups: comp.unix.unixware.misc,comp.answers,news.answers
Subject: UnixWare Frequently Asked Questions (The Email system)
Supersedes: <Dp4n29.1BF@tamarix.demon.co.uk>
Followup-To: comp.unix.unixware.misc
Expires: Tues, 15 May 1996 00:00:00 GMT
Summary: Answers to questions frequently asked about SCO's UnixWare product
Approved: news-answers-request@MIT.EDU

Archive-name: unix-faq/unixware/email
Posting-Frequency: monthly
Last-modified: Apr 14 1996
Version: 2.09

UnixWare Frequently Asked Questions List ( The Email system )

For more information about the files which compose the total UnixWare
FAQ, see the "FAQ Overview" file posted regularly on the Internet newsgroup
comp.unix.unixware.misc.
                                          
INTRODUCTION

The purpose of this document is to give answers to frequently asked questions
on Email configuration in UnixWare 1.x and 2.x for the "mailsurr" subsystem.

This document applies to both UnixWare 1.x and 2.x, please
look for version specific notes within this document stating 
applicability of individual subsections.

This document in this revision does not cover sendmail.

This document may be obtained by anonymous ftp from the freebird
archive at
    ftp.abs.net:/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.m
    netlab1.usu.edu:/pub/mirror/freebird/hints/FAQ/comp.unix.unixware.FAQ.m
    ftp.osiris.com:/pub/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.m
If you are setting up Email please check Question M2 first which
documents known problems in the Email system.

Its maintainer is Andrew Josey (andrew@tamarix.demon.co.uk). 
Suggestions and contributions welcome.

Small print: This file is freely copyable. Many proper names of
companies and software mentioned in these files are trademarks
of their respective owners.  All views are those of the
individual contributors and not of their employers.

TABLE OF CONTENTS

M1) What is the default Mailer on UnixWare ?
M2) Are there any mail related bug fixes for UnixWare 2 ?
M3) Is there any documentation describing the mail subsystem?
M4) I've seen mention of the createSurr command and autoconfiguration
    of the mail subsystem - what is this and what does it do?
M5) Where are the configuration files used by the mail subsystem?
M6) How do I set the domain name used in the From: line?
M7) What other configuration parameters can I set in the 
    /etc/mail/mailcnfg file?
M8) How does mail get delivered and how does the /etc/mail/mailsurr file work?
M9) How can I setup mail aliasing?
M10) How are uucp and smtp handled by the mailsurr file?
M10.1) How do I setup uucp over TCP between two UnixWare machines?
M11) I want to setup uucp outbound over a modem, how do I setup
     the uucp files?
M12) I'm using UW1.x and the From: line for inbound smtp
     mail is in bang format when I want it in domain address format, what
     should I change?
M13) How do I setup mail logging?
M14) How do I setup Smart Routing - using pathrouter ?
M15) What do I need to do to Set Up an Internet/Uucp Mail Gateway on UnixWare2?
    M15.1) Setup mail alias lookups via DNS, NIS or MHS (/etc/mail/lookupLibs)
    M15.2) Set the mail domain information in /etc/mail/mailcnfg
    M15.3) Setup any header rewrite rules (/etc/mail/rewrite)
    M15.4) Customizing /etc/mail/mailsurr (/usr/lib/mail/mailsurr.proto)
    M15.5) Setting up delivery lines to mail-servers, list-processors etc
    M15.6) Activating mail logging 
    M15.7) Setting up suitable defaults for mailx users
    M15.8) If you have local users, then add other mail-user agents 
    M15.9) Update /etc/profile
    M15.10) Setting up smart routing between uucp and internet zones
    M15.11) Add a rule to mailsurr.proto to catch mail to unknown local users.
    M15.12) Setup uucp over the connection server for  uucp over
    M15.13) Setup mail alias files
    M15.14) Install an alternate incoming smtpd 
    M15.15) Install the TCP/SPX wrappers so as to monitor who is connecting.
    M15.16) An example /usr/lib/mail/mailsurr.proto for this configuration
M16) I have UW2 and my inbound smtpd keeps dying. Is there a fix?
M17) I have UW2 - smtpd now runs as a daemon - is there a way to run
     it from inetd? Running from inetd makes it more reliable and also
     can be wrapped.
M18) I have UW2  and my outbound smtp  does incorrect routing to MX
     record sites and also continually bounces mail when sending
     to an unknown user when it should only bounce once - is there a fix?
M19) I'm having trouble routing email from my local machine to the net.
     I'm connected to a local internet provider and can run Mosaic etc 
     but can't send email. What do i need to do to make this work?
M20) Mail sent to my domain mydom.com does not arrive locally on the
     machine. It gets here but the local mailsystem does not recognise it
     as local.
     M20.1) How can I set other mail domains besides my real domain
            to be treated as local?
M21) I'm using UnixWare2 and when mail arrives locally the Return-Path:
     header has the format @myprovider:remotedomain!user or @domain:user or
     @domain:user@domain.  Is there someway to put this into normal 
     domain address format?
M22) Large mail alias lists don't seem to work on UnixWare 2. Is this
     a known problem?
M23) smtp mail to hosts which only have MX records and no valid A 
     records never gets there? This is with the 2.0 developer release.
M24) How do I make the mailsystem send mail for local addresses off
     to another host if they are not found locally without setting up
     aliases?
M25) How can I get mailx/dtmail to add fullname information to 
     the From: line?
M26) How can I set the From: line  (hiding the internal hosts to a 
     mail domain)?
M27) I want to setup a cluster of machines, with a single mail
     gateway machine.
M28) How can i make bounced email go to the postmaster if the user
     address is invalid?
M29) How can i debug mail delivery?
M30) How can i debug the /etc/mail/rewrite rules?
M31) How can I use the rewrite rules to rewrite a To: header
     of the format uunet!domain!user to user@domain?
M32) I have  tcp installed yet i only want to do transfers over 
     uucp. How do i make the mailsurr file exclude the smtpqer delivery lines?
M33) I'm sending to a SCO system over uucp which only understands 
     RFC822. The UnixWare mailsystem inserts an extra From line which 
     upsets the SCO mailer.
M34) Where are outgoing messages stored for smtp?
M35) Mail is bouncing back with problems about an invalid 
     From header line, what should I do?
M36) After changing the system owner to another user and 
     deleting the original user, mail is still being sent to the original 
     system owner for example when a new package is installed, 
     and errors stating "unable to send to " appear after adding a package.
M37) Why when I send local mail does my PPP link get established, for
     example when I pkgadd or pkgrm a package?
M38) Is it possible to change the sender address with 
mailsurr's translation facilities?  The man page indicates 
that only the recipient address can be changed.  
Am I going to have to move to sendmail?
M39) How do I setup a POP3 server on UnixWare ?
M40) I'm using UnixWare 1.x and  I can't find the createSurr command, 
     what should i do?
M41) How do I setup my mail to be autoanswered?
M42) How do I setup my mail to be forwarded?
M43) How do I setup a mail-server?
M44) How do I  setup a mailing list - such as Listproc ?
M45) How do I  make sendmail the default mailer?
M46) Mail of the address format @mylocal.domain:user@mylocal.domain is not
     delivered locally, how can I fix this?
M47) dtmail won't restart after my machine was switched off.
M48) Inbound mail is addressed to <@site.demon.co.uk:user@domain.co.uk>
     and does not get delivered to the local user.
M49) I'm using PPP but don't have the interface up when the system
    creates the mailsurr file, and thus it does not detect my IP
    link - what can I do?
M50) How can I set mailalias in the form : user@site  maps to local user?
M51) What is the /etc/mail/smtpcnfg file in tf2100/UW2.1?
M52) How should I setup Mail via PPP?
M53) How can I setup mail to handle virtual hosts's mail?
M54) I need to print all incoming mail as well as send it to local users.
----------------------------------------------------------------
Subject: M1) What is the default Mailer on UnixWare?

The default mailer on UnixWare is based on SVR4 mail and was originally
developed at AT&T Bell Labs.  This mailer uses a regular-expression 
based parser (/etc/mail/mailsurr) to deliver mail - this is similar in 
format to sendmail but is not sendmail.
It supports SMTP, UUCP mail, mailing list directories, 
mail aliases and an MHS gateway.

Sendmail is also included on the system and can be used instead
of the mailsurr subsystem  but is not the officially
supported mailer (see question M45 for how to make sendmail
the default mailer).


Subject: M2) Are there any mail related bug fixes for UnixWare2 ?

If you have UnixWare 2.01/2.02/2.03 you should install tf2100.tar.
If you have UnixWare 2.1 you DO NOT need to install tf2100.tar.

This fixes various difficulties with smtpd dying, and smtp
not being able to deliver to certain MX record combinations.

Symptoms:
smtp core dumps and times out connections.
RCPT TO: line is not fully qualified - Not compatible with MS mail.
smtp.pid does not get reset properly on system reboot.
smtpd dies without notice or gets into a tight loop.
Popper does not send body of mail to pop3 clients.
       
IT IS HIGHLY RECOMMENDED THAT YOU APPLY TF2100.tar
IF YOU PLAN ON CONNECTING YOUR MACHINE TO THE 
INTERNET AND USING MAILSURR

My recommended solution for 2.01/2.02/2.03 is as follows: If you
use the MHS gateway use tf2101.tar, if you only use smtp/uucp
use tf2100.tar and then you might also consider using smap/smapd as a
replacement smtpd running out of inetd (see section M17)

There is one problemette with tf2100. Its outbound smtp
holds open a tcp DNS connection. An alternate smtp daemon
is available to fix this on ftp.abs.net:/unixware/freebird/hints/Mail
mailupd.smtp. This updated smtp daemon will also work on UW2.1.


Tf2101.tar (applicable to 2.01/2.02 - this fix is included in 2.03) 
is available  on ftp.sco.com:/UW20 
fixing numerous problems with the MHS gateway. The two biggest 
problems it fixes are:

1. Users cannot reply to sender due to incorrect Sender lines
2. Attachments cannot be sent.


Subject: M3) Is there any documentation describing the mail subsystem?

If you are using UnixWare 2, please check
the on-line Dynatext documentation ; two sections are available in
postscript form from the freebird archive in the files:
	hints/Mail/mailserver_admin.UW2.ps.Z
	hints/Mail/setup_mail.UW2.ps.Z

For information on accessing the Freebird archive
see the UnixWare resource section of the  "FAQ Overview".

Subject: M4) I've seen mention of the createSurr command and autoconfiguration
of the mail subsystem - what is this and what does it do?

Firstly you should setup your DNS and uucp links,  if any, and then 
run the /usr/lib/mail/surrcmd/createSurr autoconfiguration command ; this 
takes a look at your configuration and tries to generate an appropriate 
configuration file (/etc/mail/mailsurr) for your system.  For example
if you have TCP/IP installed and uucp configured then a mail configuration
that attempts delivery over both those transports is produced; if this
is not what you intended for example you only want to send email over
uucp even though you have tcp/ip then read on.


** UnixWare 2 note: On UnixWare 2 the createSurr command is run
   automatically on each reboot in /etc/rc2.d/S81smtp, thus any changes
   you wish to make permanent must always be applied to the mailsurr.proto
   file in /usr/lib/mail rather than the /etc/mail/mailsurr file. Of course
   another option would be for you to comment the line out in S81smtp.
   The first thing you might want to try prior to any other changes is
   to run the new GUI admin tool for Mail Setup, in Admin_Tools/Mail_Setup,
   select extended and save the selection.

The next section describes in some detail how createSurr works.

The mail autoconfiguration routine invoked by 
/usr/lib/mail/surrcmd/createSurr consults the perl script  (note that
UnixWare includes a cut down version of perl 4.036 in /usr/gnu/bin)
/usr/lib/mail/surrcmd/configCheck to probe the system configuration, followed
by /usr/lib/mail/surrcmd/configMail to update the /etc/mail/mailsurr file.

In detail the sequence is as follows:

	createSurr
		calls-> configCheck
				opens-> /etc/mail/mailflgs
					/etc/mail/mailcnfg
					/etc/mail/smfcnfg
					/etc/resolv.conf
					/etc/uucp/Systems
					/etc/confnet.d/inet/interface
				updates-> /etc/mail/mailflgs
		calls-> configMail
				opens-> /etc/mail/mailflgs
					/etc/mail/mailsurr.proto
				updates-> /etc/mail/mailsurr

Subject: M5) What are the configuration files used by the mail subsystem?

The configuration files are stored in /etc/mail and in /usr/lib/mail.

The key files in /etc/mail are:
	mailcnfg	mailsurr	rewrite 	lookupLibs

The key files in /usr/lib/mail are:
	mailsurr.proto lookupLibs.proto

The /etc/mail/mailcnfg file:

This file  is used to initialise the mail configuration;
in UnixWare 2 the GUI Mail_setup tool edits this file.
The fields DOMAIN and SMARTERHOST are of particular importance.

DOMAIN  - string used to supply the domain name for the From: line

SMARTERHOST - can be set to a machine that has better routing information
in case the local machine does not understand the address. Its
possible and desirable for some workstations to route all mail
to the SMARTERHOST; if you are connecting to the internet you probably
want to set SMARTERHOST to the name of your ISP.

The /etc/mail/mailsurr file:

This file contains a set of rules for routing and transport of mail.
This is further described later in this document.

The /etc/mail/rewrite file:

This is new in UnixWare 2 and allows mail header rewriting (see 
rewrite(4) and the Dynatext documents referred to in section M3) .

The /etc/mail/rewrite contains functions to rewrite mail headers for
local (called in the local() function) and remote delivery (called in
the main() function). 

An example  of changing the From: lines to hide internal
hosts is given in question M15  section 3.

The /etc/mail/lookupLibs files:

This is new in UnixWare 2 and is a file containing the names of the
shared libraries to be opened when the mailalias command (which is
run by mail when parsing the mailsurr file). This determines where
aliases should be found. Its possible using this for alias lookup to
use the DNS and NIS. 
This file is autoconfigured.

The /usr/lib/mail/mailsurr.proto file:

This contains the default mailsurr rules for different configurations.
This file is used to create the file /etc/mail/mailsurr. Permanent
changes to /etc/mail/mailsurr should be made by editing this file.
This is further described later in this document.

The /usr/lib/mail/lookupLibs.proto file:

This is new in UnixWare 2.
This contains the default mailalias lookup rules. This file is used
to create the file /etc/mail/lookupLibs. Permanent changes to that
file should be made by editing this file.
This is further described later in this document.

The /etc/mail/smtpcnfg file:

This is new in tf2100 and UnixWare 2.1.
The contains initialisation information for the behaviour of smtp.
See M50 for details of the default values in this file.

Subject: M6) How do I set the domain name used in the From: line?

In UnixWare2 the Mail_setup GUI tool can be used to set the domain
address. This edits a file called /etc/mail/mailcnfg and adds
a line, for example to set the domain to "mydomain.com"

DOMAIN=mydomain.com

Subject: M7) What other configuration parameters can I set in the 
/etc/mail/mailcnfg file?


CLUSTER - can be used to name a group of machines. The string supplied
is used instead of the domain name when mail supplies the
remote from line. (with the /etc/mail/rewrite file included
in UnixWare 2 - i no longer use this field but add a rewrite
function instead)

FAILSAFE - can be used to denote a machine to which delivery should
be made in case local delivery fails - useful when using
mail in a networked environment

DEL_EMPTY_FILE - if value set to no empty mailfiles are not deleted by
mail or mailx

ADD_DATE - if set to true, i.e ADD_DATE=true, the mailer will add a Date:
line if one does not already exit

ADD_FROM - if set to true, i.e ADD_FROM=true, the mailer will add a From:
line if one does not already exit

If you're using UnixWare 1.x and you use uucp transfer you may also 
want to set the REMOTEFROM field which be used to set an alternate From 
line (note, not From: ).  which will be used rather than the cluster name e.g.

REMOTEFROM=real.addr.domain

(In UnixWare 2  REMOTEFROM is not supported, similar functionality
can be had by using the add_from_header function from /etc/mail/rewrite)


Subject: M8) How does mail get delivered and how does the /etc/mail/mailsurr 
             file work?

Incoming mail over smtp is received over TCP/IP on port 25.
In UnixWare 1.x the inetd server listens on port 25 and invokes 
in.smtpd to receive the mail.  In UnixWare 2.x an smtpd daemon process listens
on port 25 to receive mail

Once mail is received by the smtp receiver it is passed to
the rmail process which then uses the regular expression based
parser (/etc/mail/mailsurr) to decide how to do deliver the mail.

Incoming mail over uucp is queued in /var/spool/uucp/sitename and then
uux scans that directory and passes the mail off to the 
rmail process for delivery.

Outgoing mail is handed to rmail which based on the address and
the mailsurr rules in place  delivers the mail accordingly.


The file /etc/mail/mailsurr contains a set of rules for routing and 
transport of mail.

This file is automatically created by the command
/usr/lib/mail/surrcmd/createSurr by scanning the system configuration
and a template mailsurr prototype file in /usr/lib/mail/mailsurr.proto.

To make permanent changes to this file edit the mailsurr.proto file
and then rerun the createSurr command.

The mail autoconfiguration routine invoked by /usr/lib/mail/surrcmd/createSurr 
consults the perl script /usr/lib/mail/surrcmd/configCheck to probe the system 
configuration. 

After scanning the system the file /etc/mail/mailflgs 
contains flags for the configuration options autoconfigured. Examination of the
mailsurr.proto shows the same flags with conditional mailsurr entries.

The possible flags in /etc/mail/mailflgs are SMTR, MHS, DNS, UUCP and IP:

SMTR if SMARTERHOST is set in /etc/mail/mailcnfg

MHS is set if %g is set in /etc/mail/mailcnfg (MHS gateway )
This may be set off if MHSINTERVAL is set to 0 in /etc/mail/smfcnfg

DNS is set if there is a resolver set in /etc/resolv.conf
UUCP is set if there are entries in /etc/uucp/Systems
IP is set if it determines there is a valid device in
/etc/confnet.d/inet/interface
           

The createSurr command the invokes /usr/lib/mail/surrcmd/configMail to
produce the updated /etc/mail/mailsurr file.

Looking at the file created (see mailsurr(4) for full details).
Each entry in the /etc/mail/mailsurr file consists of three fields.

'sender'	  'recipient'	'command'

The sender and recipient fields are regular expressions.  If
these first two fields match those of the mail message being
processed, the associated command is run.

Some sample mailsurr entries follow - don't worry if you don't
understand these, for a full explanation you can refer to the 
UnixWare man page for mailsurr(4).

# mail-server, mailing lists and information distribution handling section
'.+'    'mail-server'   '<      /opt/lib/mserv/listener'
'.+'    'listproc'   	'<S=0;      /home/listserv/catmail -r -f'

#    Send mail for `laser' to	attached laser printer
#    Make certain that failures are reported via return mail.
'.+' 'laser'	 '< S=0;F=*; lp	-dlaser'

#    For remote mail via uucp
'.+' '([^!@]+)!(.+)'	 '< /usr/bin/uux - \\1!rmail (\\2)'


Examples of mailsurr/mailsurr.proto/mailcnfg files for a uucp/internet 
gateway  and client workstation in cluster configurations for both
UnixWare 1.x and UnixWare 2 are available from the Freebird archive
in the directory hints:
	Mail/README
	Mail/mailsurr
	Mail/mailcnfg
	Mail/client.mailcnfg
	Mail/client.mailsurr
	Mail/client.mailcnfg.uw2
	Mail/client.mailsurr.uw2
	Mail/mailcnfg.uw2
	Mail/mailsurr.proto.uw2
	
Subject: M9) How can I setup mail aliasing?

UnixWare mail has a convenient method of alias processing, and the
mailer calls a utility called mailalias. 

The mailalias utility if it cannot find a user locally or a mailbox 
(UnixWare mail delivers to mailfiles as well as users - so
you can just places a mailbox into /var/mail without setting
up a user account) looks for a list 
of alias files in the configuration file /etc/mail/namefiles.

Note that mailsurr does not use any of the sendmail aliasing
files (i.e. /usr/ucblib/aliases).

The default files are /etc/mail/lists and /etc/mail/names. In our
local installation we've added added a couple of local files, 
/etc/mail/groups for internal groups, /etc/mail/localiases for 
internal distribution and /etc/mail/fullnames 
which has alternate  long names; so this file looks like:

# --- example /etc/mail/namefiles -----
/etc/mail/lists
/etc/mail/names
# Local add-ons
/etc/mail/groups
/etc/mail/localiases
/etc/mail/fullnames
# -----end example ----

/etc/mail/groups could be:

# ---- example /etc/mail/groups -----
#	All the local groups within Sitename.This is the definitive copy used by
#	all the mail interfaces (it's totally transparent to them all).
#

managers	john fred wendy june
staff		joan michelle rita \
		sarah brendan
all		managers staff
# --- end example --

/etc/mail/localiases could be:

# ----- example /etc/mail/localiases ----
#	localiases:
#		These are purely local, readily changeable aliases for mapping
#	user@site.domain to internal host!user
#
# This file is for the gateway

john		argus!john
fred		argus!fred
wendy		woolco!wendy
june		sun4!june
rita		olim380!rita
sarah		olim380!sarah
brendan		sun4!brendan
# -- end example --

/etc/mail/fullnames could be:

# --- example /etc/mail/fullnames ---
j.williams	john
john.williams	john
f.jones		fred
fred.jones	fred
w.jones		wendy
wendy.jones	wendy
r.arnold	rita
rita.arnold	rita
# common misspellings can also be included
sara		sarah
brendon		brendan
# --- end example ----


Subject: M10) How are uucp and smtp handled by the mailsurr file?

Delivery by uucp is driven off the /etc/uucp files. If you wish to
do some smart routing see the later section on pathrouter..

Use of smtp can we be done either using DNS lookup or not.
Typically for internal hosts in a cluster, we set smarterhost
(in /etc/mail/mailcnfg) to our internet gateway, and then
that host does the DNS lookup.

To choose smtp delivery before uucp swap the two lines below (example for 
UnixWare 1.x).  If you want to use DNS lookup remove the "-N" from the smtpqer
line.

#UnixWare 1.x example uucp delivery first, followed by smtp
'.+'	'!([^!]+)!(.+)'		'< B=1024; uux -a %R -p -- \\1!rmail' '(\\2)'
'.+'	'!([^!]+)!(.+)'		'< B=4096; smtpqer -N %R \\1' '\\2'


** UnixWare 2 note: The mailsurr lines in UnixWare 2  default to use 
domain addressing rather than ! notation. They appear different but the
ordering may be changed.

# UnixWare 2 example: The mail transports go here.
# smtp delivery first followed by uucp
# If DNS is not used, use "smtpqer -N". If DNS is used, remove the "-N".
#
'.+'    '([^@,:]+)@(.+)'        '< B=4096; /usr/lib/mail/surrcmd/smtpqer -f %R -s %X' '\\1@\\2'
'.+'    '(@[^@,:]+[,:].+)'      '< B=4096; /usr/lib/mail/surrcmd/smtpqer -f %R -s %X' '\\1'
'.+'    '([^@,:]+)@(.+)%D'      '< H=add_from_header;B=1024; uux -a %R -p -- \\2 !rmail' '(\\1)'
'.+'    '@([^@,:]+)%D[,:](.+)'  '< H=add_from_header;B=1024; uux -a %R -p -- \\1 !rmail' '(\\2)' 

Tip: If you are using dialup uucp you may want to change the uux command
invoked to add the "-r" flag so that mail will be queued for delivery,
rather than attempting delivery at the time the mail is sent. The mail
can then be sent when the uucp system polls the site which is more
efficient. An example of a uucp delivery line with the -r flag added
follows:

# invoke uux with -r flag to queue mail for delivery
'.+'    '([^@,:]+)@(.+)%D'      '< H=add_from_header;B=1024; uux -a %R -p -- \\2 !rmail' '(\\1)'
'.+'    '@([^@,:]+)%D[,:](.+)'  '< H=add_from_header;B=1024; uux -r -a %R -p -- \\1 !rmail' '(\\2)' 

Since your mailsurr file was created by the createSurr command then remember
to make the changes permanent by editing the file
/usr/lib/mail/mailsurr.proto (the template prototype file).

Subject: M10.1) How do I setup uucp over TCP between two UnixWare machines?

Step 1. Edit /etc/uucp/Devices and uncomment the following line

CS  - - - CS   

This then uses the connection server to make connections.


Step 2. Edit /etc/uucp/Systems , add a line for each system you
want to talk to, for example to system raven

raven     Any CS - -,listen:10103 

This entry makes "uucico" run over the TCP network.  
It causes the Connection Server to connect to the "10103" service 
through the "listen" service. The "10103" service invokes uucico.

Step 3. Edit /etc/uucp/Permissions, to allow remote systems 
connecting over the connection server to send and request files (note
that remote systems also need an entry in /etc/uucp/Systems).

LOGNAME=nuucp SENDFILES=yes REQUEST=yes



M11) I want to setup uucp outbound over a modem, how do I setup
the uucp files?

In UnixWare2 you can do this using the Dialup_setup GUI tool.

Alternately I carry a floppy with the following files from /etc/uucp
that I install when I want to setup my laptop to call outbound:

	Config	Devices	Devices.tcp Dialers Systems

This configuration is for a Hayes compatible modem, and is known
to work with Supra modems, Multitech ZDX modems and US Robotics.
These files can be obtained from the freebird archive in the file

	hints/Mail/uucp.quick.tar.Z

Subject: M12) I'm using UW1.x and the From: line for inbound smtp
mail is in bang format when I want it in domain address format, what
should I change?

Change to /etc/inet/inetd.conf [ Applies only to UnixWare 1.x]

In UnixWare 1.x smtp is run as an inetd service each time a request comes
in. If you're running UnixWare 1.x you most probably want to make
the change below:

One problem you can get if you deliver over smtp is that the mail 
subsystem rewrites the From: line from
internet format to uucp format.  To change this edit the
smtp line in /etc/inet/inetd.conf (on the receiving host) and add 
the -r flag to tell smtpq not to rewrite the addresses.

smtp    stream  tcp     nowait  smtp    /usr/lib/mail/surrcmd/in.smtpd  in.smtpd -H novell.co.uk -r

(in the above example we fixed the Helo string to be novell.co.uk, you
probably want to change this or you can omit it altogether).

Remember to restart inetd, or send it a HUP signal to re-read the config file.

# ps -ef|grep inetd
root   268   262  0   Dec 01 ?        3:25 /usr/sbin/inetd 
andrew 17546 17313  6 14:43:58 pts/5    0:00 grep inetd 

# kill -HUP 268

** UnixWare 2.x note; In UnixWare 2 smtpd is run as a daemon rather than being
started by the inetd process, so the above does not apply. The only
option supported in UW2 is -d debug_level.  It has been reported that when
upgrading from UnixWare 1.x to UnixWare 2, that some of the old daemons
are not removed, so you may want to hand check your /etc/inet/inetd.conf
file and comment out any in.smtpd entries carried over - remembering
to restart inetd afterwards.

Subject: M13) How do I setup mail logging?

The following mailsurr entries log successful and failed deliveries in
/var/mail/:log and /var/mail:errors respectively.  In UnixWare 1.x these
are files, in UnixWare 2 these are directories.

# Log mail delivery
#
'.+'	'.+'	'> W=1;B=*; maillog -o /var/mail/:log' '-O %O %R %n %H %l --'
'.+'	'.+'	'Errors W=1;B=*; maillog -o /var/mail/:errors' '-O %O %R %n %H %l --'

If you are using UnixWare 1.x and enable these be sure to setup a cron to 
periodically trim them (not necessary for UnixWare 2 since it
logs to one file for each day of the week, truncating any existing
files at the start of each day -see below).

To turn on logging for incoming and outgoing mail, execute the 
following command:

#/usr/lib/mail/surrcmd/createSurr -l on

In UnixWare 2 you can also select the appropriate part of the GUI setup
to turn logging on.

** UnixWare 2 Note:  The log files are different between UnixWare 1.x and
UnixWare 2. Logs are now kept in directories with a different log being
stored each day in a file denoted by the day name, ie. Monday,....Sunday
for the 7 days. If you prefer the old style format of logging to
just a single file , its very simple just to replace the logging tool
with either your own or the one from UnixWare 1.x. (from the Freebird
archive ...freebird/hints/Mail/maillog.alt).

Logs for smtp delivery are kept in /var/spool/smptq/LOG* in UnixWare 1.x

To determine problems with outgoing mail, check the /var/spool/smtpq/LOG file.
Each time a mail message is sent, a log of the delivery command is appended 
to this log file.  A cron entry located in /var/spool/cron/crontabs/smtp 
recycles daily backup copies of the mail message deliveries on a 7 day 
cycle.  This is useful for debugging mail problems.  

Some simple logging sample scripts suitable for UnixWare 1.x are contained 
on the Freebird archive in mailloggers.shar, these simply show how to 
tail relevant logfiles.

In UnixWare 2 daily logs for smtp delivery are now kept in the directory
/var/spool/mailq/Logs.

A useful file to monitor uucp activity is:

#!/bin/sh
# works on both UnixWare 1.x and UnixWare 2
tail -f /var/uucp/.Admin/xferstats

To see todays uucp log for a given system

uulog -f system

To see the days logs for all systems, type 

uulog

To tail the smtp logs for UnixWare 2, you need a script:

#!/bin/sh
# You'll need to chmod the files in the Logs directory
# or run this with privilege

DAY=`date +%A`
tail -f /var/spool/mailq/Logs/$DAY

Subject: M14) How do I setup Smart Routing - using pathrouter ?

If you wish to setup a machine to act as a smart mail gateway capable
of routing, then some smart routing software is needed.  A utility
suitable for use with UnixWare is pathrouter.

** UnixWare 2 note: 

The good news is that pathrouter is now part of the 
standard release and can be found in /usr/lib/mail/surrcmd/pathrouter. 
There is even a man page, and it gets a mention in the Dynatext.

UnixWare 1.x pathrouter is available from the freebird archive :
	freebird/hints/Mail/pathrouter.tar.Z

Pathrouter is essentially the routing part of smail2.5, with some
modification for batch routing and auto detection of hostname and domain
name. It's driven by a routing database in /etc/uucp/paths (which can
be built manually or you could use the freely available pathalias utility).
	
Pathrouter can be used to lookup route information for uucp and 
domain addresses.

The following  is an example of the delivery commands from the
file /etc/mail/mailsurr for such a configuration which can gateway
between the internet and uucp zones. 

This example for UnixWare 1.x, see later for example mailsurr.proto
for UnixWare 2.

####
#### Part 3
####
#### Delivery commands should go here. All addresses going
#### remote should begin with a single "!".
####

# Check for binary mail. Uncomment this if you want to use it.
# Smtp can not handle binary mail so use this line.
#
'.+'	'!([^!]+)!.+'		'< F=*;C=0; ckbinarsys -t %C -s \\1'

# Perform routing via /etc/uucp/paths database
'.+'    '.*[!@].*'              'Translate T=1;B=*; R=|pathrouter -p' '%n'

# For remote mail via uucp and smtp. Uucp is first because
# it is more universal and handles binary mail properly.
# 

'.+'	'!([^!]+)!(.+)'		'< B=1024; uux -a %R -p -- \\1!rmail' '(\\2)'

#
# If DNS is not used, use "smtpqer -N". If DNS is used, remove the "-N".
#
#'.+'	'!([^!]+)!(.+)'		'< B=4096; smtpqer -N %R \\1' '\\2'
'.+'	'!([^!]+)!(.+)'		'< B=4096; smtpqer %R \\1' '\\2'



The /etc/uucp/paths file is the routing database for the pathrouter command 
(see paths(4), and pathrouter(1M)) .  Each line of the file provides 
routing information to either a host or to a domain (designated by a 
leading ".").  Each line should have either two or three tab characters 
(ascii 0x9) as separated fields.  The format of each line in the 
paths file is:

	key  route   [cost]


Note that the cost field is a delivery weighting field 
which is not used by the mail subsystem (smail would use it).


An example paths (/etc/uucp/paths) file for a gateway machine.

The following paths file is an example of setup for a gateway machine.
This example prefixes the destination routes with an exclamation
mark (!) to reduce the number of translations done by the rmail(1).

This example is used to rewrite the domain addresses france.fr;
and any uk domain address (matched by the .uk rule) to be routed 
via the uel machine.

The usg.com domain address is converted to !usg!%s in order to utilise
the uucp transport rather than smtp. 

france.fr       !uel!france.fr!%s       0
uel     !uel!%s 0
usg     !usg!%s 0
windsor !uel!windsor!%s 0
.uk     !uel!%s 0
.usg.com        !usg!%s 0


Prefixing a name by a dot as in ".usg.com" can be used to match
domains, and so this rule would match site1.usg.com to be routed
thru usg!.


Note that this example does not have "smart-host" defined, and so
any addresses that are not matched by pathrouter are left unchanged. In this
example it is assumed that the DNS lookup will resolve the
address and perform delivery over smtp.

If you don't have DNS lookup, or you decide to route unknown
addresses to the nearest backbone then add an entry

smart-host	!backbone!%s	0

An example we use here to send mail to a particular route follows; this
for various internal routing to an internal gateway within the company,
and allows mail to be addressed as user@fpk, user@fpk.mycomp.com or
user@mycomp.com with all mail going to the one gateway.

fpk     !nj-ums.fpk.mycomp.com!%s       0
fpk.mycomp.com  !nj-ums.fpk.mycomp.com!%s       0    
mycomp.com	!nj-ums.fpk.mycomp.com!%s	0


This is then combined with a delivery line within mailsurr.proto
to send this over smtp:

'.+'    '!(nj-ums.fpk.mycomp.com)!(.+)' '< B=4096; /usr/lib/mail/surrcmd/smtpqer -f %R -s \\1' '\\2'          


* UnixWare 2 note:

You may encounter some differences between the pathrouter available
on the ftp sites and that included in UnixWare2.
In particular the 2.0 version does not take entries in 
/etc/uucp/paths of the form 

ukb.novell.com	%s	0

to be for local delivery which it should.
The above example should match "user@ukb.novell.com" to be a local
user and translate is to just "user" - you can work around
this by add a mailsurr translation rule 

	'.+'    '([^@]+)@(ukb.novell.com)'            'Translate R=\\1'



Subject: M15) What do I need to do to Set Up an Internet/Uucp Mail Gateway 
              on UnixWare 2?

The following section details the steps taken to setup up an email
gateway on UnixWare 2 - the email gateway is connected to the internet
and also has direct uucp connections over tcp and serial lines.


Subject: M15.1) Setup mail alias lookups via DNS, NIS or MHS 
                (/etc/mail/lookupLibs)

Do you want mailalias to use  DNS, NIS or MHS to lookup for aliases?
If you don't then by disabling the feature (by commenting out
lines in usr/lib/mail/lookupLibs.proto) you can speed mailalias
lookup.

In /usr/lib/mail is the file lookupLibs.proto; by default this contains:

/usr/lib/mail/libalias/file.so
/usr/lib/mail/libalias/passwd.so
<DNS>   /usr/lib/mail/libalias/dns.so
<NIS>   /usr/lib/mail/libalias/nis.so
<MHS>   /usr/lib/mail/libalias/extract.so    


When createSurr is run to auto-discover the machine configuration
and create a suitable mailsurr file, it will auto include the
lines for the features it discovers, for example DNS being
configured auto includes the line beginning <DNS>

You can insert a comment into this file to disable the line, or
you can delete the line; for example to disable DNS, NIS and MHS
mailalias lookup  on this machine;

/usr/lib/mail/libalias/file.so
/usr/lib/mail/libalias/passwd.so
<DNS>   #/usr/lib/mail/libalias/dns.so
<NIS>   #/usr/lib/mail/libalias/nis.so
<MHS>   #/usr/lib/mail/libalias/extract.so    


Alternately you can replace mailalias with the UW1.x version of mailalias
which then only uses the aliases as defined in /etc/mail/namefiles.
(This also works around a bug in 2.01 mailalias where long alias lists
are truncated -alternately installing one of the mail fix updates in
question M2 will also fix this problem). Since I'm not
using any aliases in the DNS/NIS presently I install the UW1.x version as 
/usr/lib/mail/surrcmd/mailalias.alt and edit the line in
mailsurr.proto accordingly.

The changes are as follows:

# Run all (apparently) local names through the mail alias processor.
# This version uses mailalias.alt which is the 1.x version
#
'.+'	'.+'			'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/mailalias.alt -P%L! -P%U! -P%L\%D! -P%U\%D! -S@%U\%D -S@%L\%D -S@%L -S@%U -r -p' '%n'

A copy of the UW1.x version of mailalias is available on the Freebird
archive.

Subject: M15.2) Set the mail domain information in /etc/mail/mailcnfg

You can establish many of the mail configuration parameters  by using
the Admin_Tools/Mail_Setup GUI Tool. One of the things this does is
to enter parameters into the file /etc/mail/mailcnfg - a file that does
not exist by default.

A typical file is as follows:


ADD_DATE=1
ADD_FROM=1
ADD_RECEIVED=1
DOMAIN=novell.co.uk
SMARTERHOST=usl.com
ADD_MESSAGE_ID=1
FORCE_7BIT_HEADERS=1
FORCE_7BIT_MIME=1
ADD_TO=1
FORCE_MIME=1

Important parameters here are:

SMARTERHOST - where to send mail in the event that you are
unable to resolve or have no uucp route to a host. Typically this
is your IP provider or another friendly site.

DOMAIN - is the mail domain for the From: line in mail. Typically
mail will have the form From: user@nodename.domain. The next section
in this document shows a mail rewrite rule which rewrites
the From: lines so as to make all mail  seem to have come from 
just the domain name.


Subject: M15.3) Setup any header rewrite rules (/etc/mail/rewrite)

Using the default setup with DOMAIN=novell.co.uk, mail will appear
as if it comes from the machinename.novell.co.uk. Many installations
prefer to make it appear as if they have just one email address, their
domain name.

The /etc/mail/rewrite file contains functions to rewrite mail headers for
local and remote delivery. The following is a rewrite function
to search for occurrences of node.novell.co.uk and replace them with
just novell.co.uk.


function check_headers()
{
var hdr;
# loop through ALL headers
for (hdr from headers_pattern("From:"))
   # if we match a header that has something like foo.xyz.com in it
   if (hdr ~ "[a-zA-Z]\\.novell\\.co\\.uk")
     # then substitute the shorter version in its place
     hdr=gsubstitute(hdr, "[a-zA-Z0-9.]+\\.novell\\.co\\.\\uk", "novell.co.uk");
}         

So this function should be added to the file /etc/mail/rewrite.
There are two pre-defined special functions within this file - main()
and local().

You need to add  this to the function main() which is executed before
any rules in the /etc/mail/mailsurr file are executed. 

Other functions may be executed from mailsurr via Rewrite rules or 
H= invocations  on delivery lines. 

The function local() is executed for local delivery.

An example function to be executed by a H= invocationm is add_from_header.
This is a modified version we use for uucp connections
(this works for us below)

# function add_from_header
#
# Add a >From line.

function add_from_header()
{
    # Create the From header.
    var retpath, elementArray, newHeader;
    retpath = returnpath();
    if(strstr(retpath, "!") != 0)
	{
	# uucp incoming case
	#retpath = substitute(retpath, "^(.+)!([^!]+)$", "\\1:\\2");
	elementArray = split(retpath, ":");
  	elementArray[0] = substitute(elementArray[0], "^@", "");
	newHeader = elementArray[1] @ " " @ fromdate(time()) @ " remote from " @ elementArray[0];
	}
    else if(strstr(retpath, "@") == 0)
	{
	# local delivery so add this machine's domain
	newHeader = retpath @ " " @ fromdate(time()) @ " remote from " @ usefuldomain();
	}
    else
	{
	# over smtp?
	retpath = gsubstitute(retpath, ":@", "!");
	retpath = substitute(retpath, "^@", "");
	if(strstr(retpath, ":") == 0)
	    {
	    retpath = substitute(retpath, "([^!@]+)@([^@]+)$", "\\2:\\1");
	    }
	else
	    {
	    retpath = substitute(retpath, "([^:]*)[:]([^!@]+)@([^@]+)$", "\\1!\\3:\\2");
	    }

	elementArray = split(retpath, ":");
  	elementArray[0] = substitute(elementArray[0], "^@", "");
	newHeader = elementArray[1] @ " " @ fromdate(time()) @ " remote from " @ elementArray[0];
	}

    prepend_header(">From", ">From", newHeader);
	
}

function usefuldomain() {
var dom = domain();
  dom = substitute(dom, "^\.", "");
  return dom;
}     


Also see section M21 for a rewrite function for changing the
Return-Path: mail header.


Subject: M15.4) Customizing /etc/mail/mailsurr (/usr/lib/mail/mailsurr.proto)


To customize the /etc/mail/mailsurr file and make the changes
permanent you need to make the changes to the file 
/usr/lib/mail/mailsurr.proto.

Some example changes are below:

To see mail to the address "novell.co.uk" as local when the nodename is
mailgate.novell.co.uk add the following entry to /etc/mail/mailcnfg

%d=novell.co.uk

Add the following line to /usr/lib/mail/surrcmd/ (just after the ACCDOM
line in Part 2 and before the mailalias line)

'.+'    '([^@]+)@%d'            'Translate R=\\1'  

To do this change in a more generic manner add a capital D to the NODOT entry
in mailsurr.proto. (The NODOT was a typo)


An alternate to adding %d into the mailcnfg is to put the explicit
line in the mailsurr.proto file; for example:


'.+'    '([^@]+)@(uel.co.uk)'            'Translate R=\\1'   # our old domain


Subject: M15.5) Setting up delivery lines to mail-servers, list-processors 
                etc (mailsurr.proto)


Entries can also be added to setup special delivery lines into
programmes such as the mail-server.

Add the entry in part 3 after the ckbinarsys line:

'.+'    'mail-server'   '<      /opt/lib/mserv/listener'


Subject: M15.6) Activating mail logging 

You won't get too far without being able to determine whats
going on. The command to switch mail logging on follows:

/usr/lib/mail/surrcmd/createSurr -l on


Subject: M15.7) Setting up suitable defaults for mailx users


Edit the file /etc/mail/mailx.rc and add some suitable site
defaults:


set autoprint askcc bang crt=20 dot showto
set metoo cmd=/opt/bin/mailPR page hold
set sendmail=/bin/rmail
set from

ignore Message-Id Received Status Content-Type Content-Length Default-Options Auto-Forwarded-From Auto-Forward-Count 


Subject: M15.8)  If you have local users, then add other mail-user agents : 
for example, mush, elm, pine etc

If you are using the version of Elm from the mail-server, system
wide defaults are contained in /opt/lib/elm/elm.rc, a sample is below
for our site.

## /opt/lib/elm/elm.rc -- system wide defaults for elm

## default hostname to override uname in From: line
## for example.
##   hostname = uel.co.uk
## If not set, the From: line defaults to the uname
## hostname = uel.co.uk
hostname = novell.co.uk
hostdomain = novell.co.uk
hostfullname = novell.co.uk

## weedout unwanted mail headers
weedout via Default-Options Auto-Forwarded-From Auto-Forward-Count X-Nvlenv-01DL-Expanded Original-Content-Type Content-Type Content-Length X-Nvlenv-01Date-Transferred X-Nvlenv-01Date-Posted References


Subject: M15.9) Update /etc/profile


        EDITOR=vi
        postmark="`grep '^'$LOGNAME':' /etc/passwd | cut -d: -f5`"
        ORGANIZATION="Novell Europe."
	export EDITOR postmask ORGANIZATION

Subject: M15.10) Setting up smart routing between uucp and internet zones

As a mail gateway that has both uucp connections and an internet
connection we need to be able to smart route between the zones.
A utility called pathrouter is provided with UnixWare 2 to enable
this.

To enable the pathrouter utility, find the lines beginning
<PATHS> in mailsurr.proto :

<PATHS> # Reroute using pathrouter.
<PATHS> #
<PATHS> '.+' '[^@]+' 'Translate R=|/usr/lib/mail/surrcmd/pathrouter %n'
<PATHS>                                                                 

And change these to:

# Reroute using pathrouter.
#
#'.+' '[^@]+' 'Translate R=|/usr/lib/mail/surrcmd/pathrouter %n'
'.+'    '.*[!@].*'              'Translate T=1;B=*; R=|pathrouter -p' '%n'


Also add a uucp delivery line (before or after the smtp delivery
lines depending on your preference)

#Added for pathrouter
'.+'    '!([^!]+)!(.+)'         '< B=1024; uux -r -a %R -p -- \\1!rmail' '(\\2)'

#before <UUCP>

One thing I also found was to comment out calls to localmail in mailsurr.proto.

Install paths routing database in /etc/uucp/paths

Subject: M15.11) Add a rule to mailsurr.proto to catch mail to unknown local users.

# mailgate setup:
# This rule included for catching email sent to an unknown local user.
# This combined with  the use of pathrouter allows unknown local mail
# to be sent to user@uknown which pathrouter expands to postmaster and the
# unknown address so an error mesg still gets sent to the originator.
'.+'	'[^!@]+'		'Translate T=1;B=*; R=|localmail -p -S @unknown' '%n'

In /etc/uucp/paths add:

unknown	!windsor!postmaster %s	0

(Note windsor is where the postmast mailbox lives)

For localdelivery to postmaster this would simply be:

unknown	postmaster %s	0

Subject: M15.12) Setup uucp over the connection server for  uucp over
the network (rather than dialup uucp)

Edit /etc/uucp/Systems.tcp, add entries:

usl Any CS - -,listen:10103
usle Any CS - -,listen:10103
waterloo Any CS - -,listen:10103
carrera Any CS - -,listen:10103
marlow Any CS - -,listen:10103  

Edit /etc/uucp/Devices; enable CS - - - CS entry

Edit /etc/uucp/Permissions


Subject: M15.13) Setup mail alias files

Typically, you will want to edit /etc/mail/namefiles and add any filenames
that you wish to contain your mailing lists. See section M9 for
examples.

Subject: M15.14) Install an alternate incoming smtpd so that incoming
mail connections can be controlled using the TCP/SPX wrappers.

(see M17 for further details)

Subject: M15.15) Install the TCP/SPX wrappers so as to monitor who is 
		connecting.

If you're paranoid (or security conscious) and want to keep logs of who is 
connecting to your machine, install the TCP/SPX wrappers. If you're
on the internet you should consider installing this package or the
netacl's from the TIS Firewall Toolkit in order to control access
to all TCP services.


Subject: M15.16) An example /usr/lib/mail/mailsurr.proto for this configuration

The example /usr/lib/mail/mailsurr.proto for this configuration
is attached, this version has much of the original entries removed
to just those needed for this configuration.



#comment ^A
####
#### Part 1
####
#### Accepts and Denies should go here
####

# Prevent all shell meta-characters
#
'.+'	'.*[`;&|^<>()].*'	'Deny No Shell Metacharacters'
'.+'	'!*#.*'			'Deny No Shell Metacharacters'


####
#### Part 2
####
#### Address translations should go here.
#### Do the appropriate mapping between various addressing schemes.
#### All remote mail should leave this section in RFC822 format
####

# Collapse bang address loops that go through two or more hops
#
'.+'	'[^!@%]+![^@%]+![^@%]+'	'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/uucollapse' '%n'

# mailgate setup:
# Strip off local routes to domain, local.domain, uname, uname.alternate
# note the %d is for alternate domain names
#'.+'     '@(%d)[:,](.+)'     'Translate R=\\2'
'.+'     '@(%DNODOT)[:,](.+)'     'Translate R=\\2'
'.+'     '@(%L%D)[:,](.+)'     'Translate R=\\2'
'.+'     '@(%U)[:,](.+)'     'Translate R=\\2'         

# Reroute using pathrouter.
#
# mailgate setup:
# Comment line out and add batched version
#'.+' '.*[!@].*' 'Translate T=1;B=*;R=|/usr/lib/mail/surrcmd/pathrouter -p %n'
#'.+'	'([^@,:]+)@(.+)'	'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/pathrouter -p' '%n'
'.+'    '.*[!@].*'              'Translate T=1;B=*; R=|pathrouter -p' '%n'

# If you have a flat name space across multiple machines, but user-names only
	
# Map domain-routed domain addresses. That is, map all names of
# the form domain1!... -> @domain1[,@domain2]*:user@domain3 
#
# mailgate setup:
# Comment this line out as pathrouter likes to do routes ala
# !sitea!full.domain!user and this rewrites that format.
#'.+'	'(.+)!([^!:]+)!([^!:]+)'	'Translate R=!\\1:\\3@\\2'
'.+'	'(.*)!([^!:]+):(.+)'	'Translate R=\\1,@\\2:\\3'
'.+'	',@(.+)'	'Translate R=@\\1'

# Map all names of the form host!user -> user@host
# The default is to give @ precedence over anything else.
# ! and @ may not be present in the same address
#
'.+'	'([^!]*)!([^!]+)'	'Translate R=\\2@\\1'

# Map all names of the form user%host (without any other @) -> user@host
#
'.+'	'([^@]*)%%([^@%]+)'	'Translate R=\\1@\\2'

# Map all names of the form host.local-domain!user -> host!user
#	(host must not have a . in it)
#
'.+'	'([^@]+)@([^.]+)'	'Translate R=\\1@\\2%D'
'.+'	'@([^.,:]+)([,:].+)'	'Translate R=@\\1%D\\2'

# Map all names of the form user@local-machine -> user
# Map all names of the form user@uname -> user
# Then loop back through from the top.
#
'.+'	'([^@]+)@%L%D'		'Translate R=\\1'
'.+'	'([^@]+)@%U%D'		'Translate R=\\1'
# mailgate setup:
# Accept mail to %DNODOT for local delivery
'.+'	'([^@]+)@%DNODOT'		'Translate R=\\1'
# Accept mail to alternate domains as local, i.e. our old address
'.+'	'([^@]+)@%d'		'Translate R=\\1'
'.+'	'([^@]+)@(uel.co.uk)'		'Translate R=\\1'

# Run all (apparently) local names through the mail alias processor.
# This version uses mailalias.alt which is the 1.x version
#
'.+'	'.+'			'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/mailalias.alt -P%L! -P%U! -P%L\%D! -P%U\%D! -S@%U\%D -S@%L\%D -S@%L -S@%U -r -p' '%n'

####
#### Part 3
####
#### Delivery commands should go here.
####

# Check for binary mail. Uncomment this if you want to use it.
#
#'.+'	'!([^!]+)!.+'		'< F=*;C=0; /usr/lib/mail/surrcmd/ckbinarsys -t %C -s \\1'

# mailgate setup:
# mail-server, mailing lists and information distribution handling section
'.+'    'mail-server'   '<      /opt/lib/mserv/listener'
'.+'    'listproc'   	'<S=0;      /home/listserv/catmail -r -f'
'.+'    'uw-developers'   	'<S=0;F=1-255;C=*;  /home/listserv/catmail -L UW-DEVELOPERS -f'


# If you have a flat name space across multiple machines, but user-names only
# exist on disjoint machines, this entry will forward any name not known
# locally off to the given host.
#
# mailgate setup: 
# Comment out these entries as they clash with use of pathrouter
# by routing the mail off to another machine
<(!ROUTEMHS||!MHS)&&SMTR&&!CLUSTER>	#'.+'	'[^@]+'			'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/localmail -p -S @%X' '%n'
<(!ROUTEMHS||!MHS)&&SMTR&&CLUSTER>	#'.+'	'[^@]+'			'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/localmail -p -S @%X:real' '%n'
<ROUTEMHS&&MHS>	#'.+'	'[^@]+'			'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/localmail -p -S @%g%D' '%n'

# mailgate setup:
# special delivery to certain hosts goes here
'.+'    '!(stubai)!(.+)' '< B=4096; /usr/lib/mail/surrcmd/smtpqer -N -f %R -s \\1' '\\2'
'.+'    '!(usl)!(.+)'           '< H=add_from_header;B=1024; uux -a %R -p -- \\1!rmail' '(\\2)'
'.+'    '!(windsor)!(.+)'           '< H=add_from_header;B=1024; uux -a %R -p -- \\1!rmail' '(\\2)'


# The mail transports go here.
#
<IP>	# If DNS is not used, use "smtpqer -N". If DNS is used, remove the "-N".
<IP>	#
<IP&&DNS&&!(SMTR&&STUP)>	'.+'	'([^@,:]+)@(.+)'	'< B=4096; /usr/lib/mail/surrcmd/smtpqer -f %R -s \\2' '\\1'
<IP&&DNS&&!(SMTR&&STUP)>	'.+'	'@([^@,:]+)[,:](.+)'	'< B=4096; /usr/lib/mail/surrcmd/smtpqer -f %R -s \\1' '\\2'

# mailgate setup:
#Added for pathrouter
'.+'    '!([^!]+)!(.+)'         '< H=add_from_header;B=1024; uux -r -a %R -p -- \\1!rmail' '(\\2)'

<UUCP>	'.+'	'([^@,:]+)@(.+)%D'	'< H=add_from_header;B=1024; uux -a %R -p -- \\2!rmail' '(\\1)'
<UUCP>	'.+'	'@([^@,:]+)%D[,:](.+)'	'< H=add_from_header;B=1024; uux -a %R -p -- \\1!rmail' '(\\2)'
<SMTR&&!STUP>	
<SMTR&&!STUP>	####
<SMTR&&!STUP>	#### Part 3b
<SMTR&&!STUP>	####
<SMTR&&!STUP>	#### Smarter-host processing
<SMTR&&!STUP>	####
<SMTR&&!STUP>	
<SMTR&&!STUP>	# If none of the above work, then ship remote mail off to a smarter host.
<SMTR&&!STUP>	# Make certain that SMARTERHOST= is defined within /etc/mail/mailcnfg.
<SMTR&&!STUP>	# If there is no smarter host, then routed mail fails here.
<SMTR&&!STUP>	#
<SMTR&&!STUP>	'.+'	'@%X.+'			'Deny Smarter host unreachable'
<CLUSTER&&SMTR&&!STUP>	'.+'	'(@.+)'			'Translate T=1; R=@%X:real,\\1'
<CLUSTER&&SMTR&&!STUP>	'.+'	'([^@].+@.+)'		'Translate T=1; R=@%X:real:\\1'
<!CLUSTER&&SMTR&&!STUP>	'.+'	'(@.+)'			'Translate T=1; R=@%X,\\1'
<!CLUSTER&&SMTR&&!STUP>	'.+'	'([^@].+@.+)'		'Translate T=1; R=@%X:\\1'


# mailgate setup:
# This rule in for catching email sent to an unknown local user.
# This combined with  the use of pathrouter allows unknown local mail
# to be sent to user@uknown which pathrouter expands to postmaster and the
# unknown address so an error mesg still gets sent to the originator.
'.+'	'[^!@]+'		'Translate T=1;B=*; R=|localmail -p -S @unknown' '%n'

####
#### Part 4
####
#### Postprocessing commands should go here.
####

# Log mail delivery
#
# mailgate setup:
# Install alternate maillogger in /usr/lib/mail/surrcmd/maillog.alt
# In this example we took the maillog prog from UW1.x and installed
# that so it logs to a single file rather than a file per day, we prefer
# it that way.
<LOG>	#'.+'	'.+'	'> W=1;B=*; /usr/lib/mail/surrcmd/maillog -o /var/mail/:log' '-O %O %R %n %H %l --'
<LOG>	#'.+'	'.+'	'Errors W=1;B=*; /usr/lib/mail/surrcmd/maillog -o /var/mail/:errors' '-O %O %R %n %H %l --'
<LOG>	'.+'	'.+'	'> W=1;B=*; /usr/lib/mail/surrcmd/maillog.alt -o /var/mail/:log' '-O %O %R %n %H %l --'
<LOG>	'.+'	'.+'	'Errors W=1;B=*; /usr/lib/mail/surrcmd/maillog.alt -o /var/mail/:errors' '-O %O %R %n %H %l --'

Subject: M16) I have UW2 and my inbound smtpd keeps dying. Is there a fix?

Either upgrade to update2.03, or apply tf2100.tar
from ftp.sco.com:/UW20

If these don't work reliably, then an alternative is to use smap/smapd
from the TIS Firewall toolkit (see the next question on running
smtpd from inetd on UW2).

Subject: M17) I have UW2 - smtpd now runs as a daemon - is there a way to run
it from inetd? Running from inetd makes it more reliable and also
can be wrapped.

You can run the smap/smapd programmes from the TIS Firewall Toolkit V1.3
as replacements for the inbound smtpd. These have been ported
to UnixWare2 /rmail subsystem - binaries can be found in the
internet/server/fwtk/smap directory on the Freebird archive.

smap is a simple incoming smtp daemon invoked from inetd.
Its job in life is to store incoming mail for processing by
smapd. It runs chroot'd in the incoming mail spool area.

smapd reads mail from the incoming spool area, and hands it
off to the real mail subsystem

The idea behind this mailer is that smap is simple and understandable
and robust, and can be run on a firewall - you can also run
it as a replacement to the stock smtpd daemon if you prefer -
and this allows you to use tcp wrappers if you wish.

The files provided on the server with smap contain a new /etc/rc2.d/S81smtp 
script that auto detects if smapd is in place and runs smapd
on system startup - this assumes you'll reconfigure
your inetd to include the smap and restart it.

If you have the base UW2.01 or UW2.02 with no mailfixes get tf2100.tar
from ftp.sco.com.

smap/smapd use syslog for logging, tail -f /var/adm/log/osmlog

To install 

	mkdir /opt/etc
	ln -s /opt /usr/local   # smap/smapd look in /usr/local/etc
				# for netperm-table their config file

	cp smap smapd netperm-table /opt/etc

	chmod +rx /opt/etc/smap*
	chmod 555 /opt/etc/netperm-table

	mkdir /var/spool/mailq/smapin
	mkdir /var/spool/mailq/smapin/bad

	chown smtp:mail /var/spool/mailq/smapin /var/spool/mailq/smapin/bad
	chmod 700 /var/spool/mailq/smapin /var/spool/mailq/smapin/bad
	sh /etc/rc2.d/S81smtp stop
	cp /etc/rc2.d/S81smtp /etc/rc2.d/.S81smtp.orig
	cp S81smtp /etc/rc2.d/S81smtp
	sh /etc/rc2.d/S81smtp start

	
Edit inetd.conf and add the appropriate lines from the inetd.conf file

# if using the tcp-wrappers you need the first line 
#smtp stream tcp nowait  root    /usr/sbin/wrapd  /opt/etc/smap
smtp stream tcp nowait  root    /opt/etc/smap  /opt/etc/smap

Restart inetd using kill -HUP {PID}

where you get {PID} from ps -ef|grep inetd


Source to smap/smapd and man pages are in 

	/pub/unixware/usle/internet/server/fwtk

on ftp.novell.de and ftp.abs.net (/unixware...)

Subject: M18) I have UW2  and my outbound smtp  does incorrect routing to MX
record sites and also continually bounces mail when sending
to an unknown user when it should only bounce once - is there a fix?

Upgrade to update2.03 or tf2100.tar. 
Or obtain a replacement outbound smtp (mailupd.smtp
to replace /usr/lib/mail/surrcmd/smtp) from the Freebird archive.


Subject: M19) I'm having trouble routing email from my local machine to the net.
I'm connected to a local internet provider and can run Mosaic etc 
but can't send email. What do i need to do to make this work?

Either (1) use them as a SMARTERHOST (for mail forwarding if
they are agreeable),  by setting
        SMARTERHOST=ipprovider.domain
in /etc/mail/mailcnfg

and  updating the /etc/mail/mailsurr mail configuration file (best to
back it up first) by the following:

        su
        /usr/lib/mail/surrcmd/createSurr

CreateSurr looks at the system configuration
and using the /usr/lib/mail/mailsurr.proto file creates a new
/etc/mail/mailsurr file , in this case it enables a section of the
mailsurr file to forward all mail to unknown sites to the site
specified by SMARTERHOST. You may want to make sure that the IP
address of the site specified by SMARTERHOST is in your /etc/hosts
files.
               
Alternately (2) if you have DNS working  backup /usr/lib/mail/mailsurr.proto
and then edit it changing the smtpqer lines to remove the -N flag,
which tells smptqer to do a DNS lookup.

And then create a new /etc/mail/mailsurr file:

        su
        /usr/lib/mail/surrcmd/createSurr
                                             
If you create the /etc/mail/mailcnfg file (btw check the manual page for details
on mailcnfg) the permissions should be  444 bin mail.
On my UnixWare 1.x machines we have the following.

SMARTERHOST=usg
ADD_DATE=true
ADD_FROM=true
REMOTEFROM=novell.co.uk

You should change SMARTERHOST and REMOTEFROM accordingly.     
                                          
If you choose to have SMARTERHOST set to a fully qualified domain name
i.e. usg.novell.com

Then toggle two lines in part 3 of the /etc/mail/mailsurr to use
smtp delivery first...

You'll have something like this in part 3 (for UnixWare 1.x),

'.+'    '!([^!]+)!(.+)'         '< B=512; uux -a %R -p -- \\1!rmail' '(\\2)'
'.+'    '!([^!]+)!(.+)'         '< B=4096; smtpqer -N %R \\1' '\\2'

Swap the two lines around. 

                             
Subject: M20)Mail sent to my domain mydom.com does not arrive locally on the
machine. It gets here but the local mailsystem does not recognise it
as local.

The Mail Setup GUI has a button to select to catch mail to the domain
for local delivery. This activates the NODOT entry in the mailsurr file.
This in fact should be  DNODOT  (edit /usr/lib/mail/mailsurr.proto and
change the occurrence of NODOT to DNODOT, re-run createSurr and this
should work correctly). 

(Note that this is fixed in update2.03 and tf2100.tar)

Subject M20.1) How can I set other mail domains besides my real domain
to be treated as local?

If you have multiple domain names that you want to
receive mail, you can add an entry to /etc/mail/mailcnfg

%d=myotherdom.com

Edit /usr/lib/mail/mailsurr.proto
to create a translation entry in  that file.  The user@domain
entry is shown below from the mailsurr.proto file:

# Map all names of the form user@local-machine -> user
# Map all names of the form user@uname -> user
# Map all names of the form user@domain
# Then loop back through from the top.
#
'.+'  '(.+)@%L'    'Translate R=\\1'
'.+'  '(.+)@%U'    'Translate R=\\1'
'.+'  '(.+)@%d'    'Translate R=\\1'   #This is the added entry for user@domain

Then run the script /usr/lib/mail/surrcmd/createSurr.

If mail is coming in via the internet you'll also need to
setup an MX record for the other domain to tell it to send mail
to this host.

Subject: M21) I'm using UnixWare2 and when mail arrives locally the Return-Path:
header has the format @myprovider:remotedomain!user or @domain:user or
@domain:user@domain.  Is there someway to put this into normal 
domain address format?


The following rewrite function edits the Return-path: header  
for locally delivered email into normal domain address format. 
Add the following functions to the file /etc/mail/rewrite.


function local()
{
	fix_return_path();
}


function fix_return_path()
{
    var hdr;
    # loop through the headers of this name
    for (hdr from headers("Return-path"))
        {
        if (hdr ~ "@([a-zA-Z0-9.]+):([a-zA-Z0-9.]+)!([a-zA-Z0-9.]+)" )
            {
	    hdr = gsubstitute(hdr, "@([a-zA-Z0-9.]+):([a-zA-Z0-9.]+)!([a-zA-Z0-9.]+)", "\\3@\\2");
	    }
        if (hdr ~ "@([a-zA-Z0-9.]+):([a-zA-Z0-9.]+)@([a-zA-Z0-9.]+)" )
            {
	    hdr = gsubstitute(hdr, "@([a-zA-Z0-9.]+):([a-zA-Z0-9.]+)@([a-zA-Z0-9.]+)", "\\2@\\3");
	    }
        if (hdr ~ "@([a-zA-Z0-9.]+):([a-zA-Z0-9.]+)" )
	    {
	    hdr = gsubstitute(hdr, "@([a-zA-Z0-9.]+):([a-zA-Z0-9.]+)", "\\2@\\1");
	    }
	}
}


Subject: M22) Large mail alias lists don't seem to work on UnixWare 2. Is this
a known problem?

This is a bug. To fix this you need to apply one of the mail updates in 
section M2.

An alternative workaround is to use the UnixWare 1.x version of mailalias.
This loses some functionality , i.e. is not driven off the
/etc/mail/lookupLibs file and only looks up aliases based
off the files referenced in /etc/mail/namefiles; but then is
thus faster.

I have installed this on my UW2 mail gateway as 
/usr/lib/mail/surrcmd/mailalias.alt

and adjusted the /usr/lib/mail/mailsurr.proto file as:

'.+'	'.+'			'Translate T=1;B=*; R=|/usr/lib/mail/surrcmd/mailalias.alt -P%L! -P%U! -P%L\%D! -P%U\%D! -S@%U\%D -S@%L\%D -S@%L -S@%U -r -p' '%n'

And then recreated the /etc/mail/mailsurr file with

/usr/lib/mail/surrcmd/createSurr -l on

A copy of the UW1.x version of mailalias is on the Freebird archive
as mailalias.bin.UW1.Z.

Subject: M23) smtp mail to hosts which only have MX records and no valid A 
records never gets there? This is with the 2.0 developer release.

This is  a bug fixed in the 2.01 version of smtpd. Update to 2.01,2.02 or 2.03
or apply tf2100.tar.


Subject: M24) How do I make the mailsystem send mail for local addresses off
to another host if they are not found locally without setting up
aliases?

Enable the following line in the mailsurr file, replacing the HOST.DOMAIN
field by the appropriate values.

# If you have a flat name space across multiple machines, but user-names only
# exist on disjoint machines, this entry will forward any name not known
# locally off to the given host.
#
#'.+'	'[^!@]+'		'Translate T=1;B=*; R=|localmail -p -S @HOST.DOMAIN' '%n'


Subject: M25) How can I get mailx/dtmail to add fullname information to 
the From: line?

UnixWare rmail/mail adds additional information to the From: line based
on the postmark environment variable. On our systems we typically
add the following to /etc/profile:

        postmark="`grep '^'$LOGNAME':' /etc/passwd | cut -d: -f5`"
        export postmark

Subject: M26) How can I set all the From: line  (hiding the internal hosts to a 
mail domain)?

This can be done either in the mail user agent , that is mailx, dtmail ,
elm or mush , which are described here , or alternately using the
rewrite rules in /etc/mail/rewrite (only in UnixWare 2 - see question
M15 section 3 for details on this feature).

==>mailx/dtmail:

In your .mailrc for mailx,dtmail

set  postmark="myname@my.domian (My Fullname)"

From the mailx man page:

             postmark=string
                   The specified string is included in the comment field of
                   the From: header of messages that you send.  The string
                   is usually set to your name.  See from and translate.
                   If the string includes an @, it will be used for the
                   entire From: header.         

==>For elm, edit /opt/lib/elm/elm.rc


## /opt/lib/elm/elm.rc -- system wide defaults for elm

## default hostname to override uname in From: line
## for example.
##   hostname = uel.co.uk
## If not set, the From: line defaults to the uname
## hostname = uel.co.uk
hostname = my.domain
hostdomain = my.domain
hostfullname = my.domain

==>For mush

in your system mushrc file

set hostname=my.domain

Subject: M27) I want to setup a cluster of machines, with a single mail
gateway machine.

(for UW1) Use the sample files client.mailcnfg and client.mailsurr to
make the internal hosts forward all mail to the gateway. And then
just configure the mail gateway to be a smarthost for mail.

On UnixWare 2 setup a client machine with the GUI so that all
mail is forwarded to a smarter host - which can be your local
email gateway. Copy the resulting /etc/mail/mailsurr and /etc/mail/mailcnfg
files - install on each machine in the cluster - and edit S81smtp so
as not to call createSurr and rewrite the /etc/mail/mailsurr file on
each reboot.


Subject: M28) How can i make bounced email go to the postmaster if the user
address is invalid?

We use the pathrouter tool and an entry in /etc/mail/mailsurr to
enable this (pathrouter is available by ftp from ftp.novell.de:/pub/
unixware/usle/hints/Mail).

We map all unknown user-names to the site unknown!username

# map unknown local users to unknown!user
'.+'    '[^!@]+'                'Translate T=1;B=*; R=|localmail -p -S @unknown' '%n'

In /etc/uucp/paths unknown is mapped to

unknown !postmaster %s  0

This way the originator and the postmaster get a bounced copy.

A simpler way just to send the message to the postmaster follows:   
'.+'    '[^!@]+'                'Translate T=1;B=*; R=postmaster'


You should add these lines to the /usr/lib/mail/mailsurr.proto file
before part 4 (postprocessing commands),
and use the command /usr/lib/mail/surrcmd/createSurr to create a new
mailsurr file (best to backup your existing mailsurr file first).
CreateSurr looks at the system configuration
and using the /usr/lib/mail/mailsurr.proto file creates a new
/etc/mail/mailsurr file .
                               
Subject: M29) How can i debug mail delivery?

There are two commands you can execute to see whats happening:

/bin/mail -d address
message
<ctrl-d>

Will show you a short list of translations and delivery commands
(and will deliver the message).

/bin/mail -T "" address

will show you in gorey detail the translations taken from the
default mailsurr file.  This can be used to determine whether a problem 
can be isolated to the address translation. 

Subject: M30) How can i debug the /etc/mail/rewrite rules?

Set the following environment variable:

MAILR_DEBUG=10
export MAILR_DEBUG

/bin/mail -d email-address
msg
<ctrl-d>

This lets you see what the rewrite rules are doing.             

Subject: M31)How can I use the rewrite rules to rewrite a To: header
of the format uunet!domain!user to user@domain?

Add a call to the function fix_to_line() in the main() function of 
/etc/mail/rewrite so this is called for remote mail delivery.

function main()
{
	...
	fix_to_line("To");
}
	
function fix_to_line(var hdrname)
{
    var hdr;
    # loop through the headers of this name
    for (hdr from headers(hdrname))
        {
        # if the header has uunet!domain!user in it
        if (hdr ~ "uunet!([a-zA-Z0-9.]+)!([a-zA-Z0-9.]+)" )
            {
            # then convert !uunet!domainr!user to user@domain
            hdr = gsubstitute(hdr, "uunet!([a-zA-Z0-9.]+)!([a-zA-Z0-9.]+)", "\\2@\\1");
            }
        }
}          



Subject: M32) I have  tcp installed yet i only want to do transfers over 
uucp. How do i make the mailsurr file exclude the smtpqer delivery lines?

Comment out the smtpqer entries in the /usr/lib/mail/mailsurr.proto and 
execute /usr/lib/mail/surrcmd/createSurr to eliminate the smtp delivery command.  

Subject: M33) I'm sending to a SCO system over uucp which only understands 
RFC822. The UnixWare mailsystem inserts an extra From line which upsets the SCO 
mailer.

(for UW1)

To have the From line stripped when sending mail via UUCP 
an I=1; would need to be prepended to  the uux delivery command lines in the 
mailsurr.proto file, otherwise the mail will bounce because of this 
postmark line. Then execute /usr/lib/mail/surrcmd/createSurr to update the
/etc/mail/mailsurr file.

Subject: M34) Where are outgoing messages stored for smtp?

(for UW1)All outgoing mail messages for SMTP are located in /var/spool/smtpq 
under the domain/host directories.

(for UW2) Mail msgs are now stored in /var/spool/mailq .

Subject: M35) Mail is bouncing back with problems about an invalid 
From header line, what should I do?

(for UnixWare 2.0x)
Please apply patch tf2100.tar. This symptom is often seen
when communicating with Microsoft Mail or cc:Mail.

(UW1 only)
Edit the mailsurr.proto file and either insert or
remove the I=1; field of the smtpqer delivery command line 
entries as shown below:

<IP&&!DNS&&!(SMTR&&STUP)>  '.+'  '([^@,:]+)@(.+)'  '< I=1;B=4096; smtpqer -N -u %R \\2' '\\1@\\2'
<IP&&!DNS&&!(SMTR&&STUP)>  '.+'  '@([^@,:]+)[,:](.+)'  '< I=1;B=4096; smtpqer -N -u %R \\1' '\\2'
<IP&&!DNS&&SMTR&&STUP>  '.+'  '([^@,:]+)@(.+)'  '< I=1;B=4096; smtpqer -N -u %R %X' '\\1@\\2'
<IP&&!DNS&&SMTR&&STUP>  '.+'  '(@[^@,:]+[,:].+)'  '< I=1;B=4096; smtpqer -N -u %R %X' '\\1'
<IP&&DNS&&!(SMTR&&STUP)>  '.+'  '([^@,:]+)@(.+)'  '< I=1;B=4096; smtpqer -u %R \\2' '\\1@\\2'
<IP&&DNS&&!(SMTR&&STUP)>  '.+'  '@([^@,:]+)[,:](.+)'  '< I=1;B=4096; smtpqer -u %R \\1' '\\2'
<IP&&DNS&&SMTR&&STUP>  '.+'  '([^@,:]+)@(.+)'  '< I=1;B=4096; smtpqer -u %R %X' '\\1@\\2'
<IP&&DNS&&SMTR&&STUP>  '.+'  '(@[^@,:]+[,:].+)'  '< I=1;B=4096; smtpqer -u %R %X' '\\1'

In cases where internet mail is coming in, and forwarded out via uucp, 
the I=1; field must be removed, otherwise the From line containing the 
user name and date will be stripped prior to sending the message off via 
uucp or uux.

NOTE:  It is advisable to remove the -B option of the smtpqer entries in the 
mailsurr.proto file to eliminate the need for batch processing.

Execute /usr/lib/mail/surrcmd/createSurr to update the /etc/mail/mailsurr 
file and re-test the mail once again.

Subject: M36) After changing the system owner to another user and 
deleting the original user, mail is still being sent to the original 
system owner for example when a new package is installed, 
and errors stating "unable to send to " appear after adding a package.
 

This is caused since the files

/var/sadm/install/admin/check and 
/var/sadm/install/admin/default contain a line 
"mail=username username2 etc.  

These files do not get updated when some users are deleted from the system.
The fix is to manually take out the names of the non existing user 
from the mail= line in /var/sadm/install/admin/check and 
default.

Subject: M37) Why when I send local mail does my PPP link get established, for
example when I pkgadd or pkgrm a package?

On UnixWare 2 this is triggered by the mailalias program.
There is a file in /etc/mail called lookupLibs (built from
/usr/lib/mail/lookupLibs.proto) that contains references to shared
libraries used to lookup aliases.  By default if you have DNS defined
in your mailflgs file, mailalias will connect to your name server to
ask it about aliases.  To work around this just comment out the <DNS> line
/usr/lib/mail/lookupLibs.proto and /etc/mail/lookupLibs. 

Subject: M38) Is it possible to change the sender address with 
mailsurr's translation facilities?  The man page indicates 
that only the recipient address can be changed.  
Am I going to have to move to sendmail?

Not necessary. Its possible but not elegant in UW 1.x, in 2.0 there
is now a file /etc/mail/rewrite which allows you to specify rewrite
rules for mail headers.  What I do for UW1.x is below:


For UW.1x I basically replace the delivery command with a script that
edits the mail header using sed and then pipes the edited message into
what would have been the delivery command (i.e. uux or smtp).

Example 1:

For example the next mailsurr line is for fixing some strange From:
lines coming from a Dos mailer which has a From: line of the format
domain(full name) user , fixing them to domain!user format. ( the example
below works just for mail from
site nwc-uk.ukb.novell.com to host windsor)

# rewrite the mail header
# s/nwc-uk.ukb.novell.com/novell/
'nwc-uk.ukb.novell.com!.*'      '!(windsor)!(.+)'               '<B=1024;S=0;F=*; /%w/headerfix -a %R -p -- \\1!rmail' '(\\2)'

The headerfix command is located in /usr/lib/mail/surrcmd/headerfix

#!/bin/sh
# headerfix script
/bin/cat -| /bin/sed -f /usr/lib/mail/surrcmd/headfix.sed|/usr/bin/uux  $*
exit 0


Where /usr/lib/mail/surrcmd/headfix.sed contained the substitution
regular expression

s/\(From: nwc-uk.ukb.novell.com\)(.*!\(.*\)[         ].*)/From: nwc-uk.ukb.novell.com!\2/


Example 2:

Another example is where we use a script to remove some of the delivery
lines , in this case all mail to usle has some mail headers stripped,
note that this machine is a mailhub internal to our cluster


'.+'	'!(usle)!(.+)'		'< B=4096; /%w/hidesmtp -u %R \\1' '\\2'


#!/bin/sh
#set -x
/bin/cat -| /bin/sed -f /usr/lib/mail/surrcmd/hidesmtp.sed|/usr/lib/mail/surrcmd/smtpqer $*


Where /usr/lib/mail/surrcmd/hidesmtp.sed is:

1d
2s/^>From/From/
/^Received: from novell.co.uk/d
/^$/,$s/^From />From /

For UnixWare 2.x we add functions to the file /etc/mail/rewrite



Subject: M39) How do I setup a POP3 server on UnixWare ?


The POP server is included in UW2 in /usr/lib/mail/surrcmd/popper,
however there's a problem with truncation of the last mail
message with that version.

Either pick up tf2100 from ftp.sco.com:/UW20

or get one of the freeware versions from ftp.abs.net|ftp.novell.co.uk
in /pub/unixware/freebird/mailtools/popper  (source and binaries
available).

To make operational, you need to do the following:

 (i) edit /etc/services, ensure there is an entry

pop3            110/tcp                         # Post Office

 (ii) edit /etc/inetd.conf, add an entry

 pop3   stream  tcp     nowait  root    /replace_with_Path_to_popper/popper             popper

 (iii) Restart inetd, by sending a kill -HUP to the inetd PID.


Subject: M40) I'm using UnixWare 1.x and  I can't find the createSurr command, 
what should i do?

[This section below is UnixWare 1.x specific for folks who did not
 install the nuc package]

The createSurr command is in the nuc package in UnixWare 1.x.
There is a package on the Freebird archive containing only
the additional mail tools provided in the nuc package, that is
createSurr (note that you'll have to add a copy of perl yourself ) - 
the package is mailproto.tar.Z - the readme file is attached below:

mailproto version 1.0

Copyright 1993-1995 Novell, All Rights Reserved.

This software is provided "as is" and without any expressed or implied
warranties, including, without limitation, the implied warranties of
merchantibility and fitness for any particular purpose. 

This version for UnixWare 1.x.

This package contains the minimal mailtools for auto configuration of
the mail subsystem - these are normally contained in the nuc package.

DO NOT INSTALL THESE IF YOU ALREADY HAVE THE NUC PACKAGE INSTALLED OR
ARE RUNNING UNIXWARE 2!
(the package checks this and will not install over the nuc package)

YOU WILL ALSO NEED TO INSTALL A COPY OF PERL.
These scripts expect to find a copy of perl in /usr/gnu/bin/perl.
If you have perl installed elsewhere edit the first line of the
perl scripts to point to the correct location.

For information on how to setup the mail subsystem see
	hints/Mail/README
	hints/Mail/Howto_setup
from the mail-server archive.

The files installed by this package are:

/usr/lib/mail/mailsurr.proto - a prototype mailsurr file 

/usr/lib/mail/surrcmd/createSurr - command to generate mailsurr file
/usr/lib/mail/surrcmd/configCheck - subsidiary command used by createSurr
/usr/lib/mail/surrcmd/configMail - subsidiary command used by createSurr
/usr/lib/mail/surrcmd/getDomain - subsidiary command used by createSurr


To install the package the simplest way follows:

1. Extract the tar archive. 

$ cd /tmp
$ su
# tar xvf mailproto.tar

2. Installing the package


	pkgadd -d `pwd`


3. Removing the package

# pkgrm  mailproto

Subject: M41) How do I setup my mail to be autoanswered?

This is done by using the vacation command.
To setup the default autoanswering message just type

	vacation

For example:

	$ vacation
	UX:vacation: INFO: Vacation notification installed
	UX:vacation: INFO: Logging will go to '/opt/lib/mserv/.maillog'
	UX:vacation: INFO: '/usr/share/lib/mail/std_vac_msg' will be used for the canned message

This will cause the system to send the following standard reply:

	Subject: AUTOANSWERED!!!

        I am on vacation. I will read (and answer if necessary)
        your e-mail message when I return.

        This message was generated automatically and you will
        receive it only once, although all messages you send
        me while I am away WILL be saved.


A list of senders is kept in the file $HOME/.maillog, and
incoming mail is kept in your normal mailbox by default,
since the UnixWare mailer keeps the forwarding information in 
/var/mail/:forward and not in the mailbox file as in earlier SVR4.0 releases.

If you would prefer to customise the reply, prepare a message in a
file and then give the filename as an option to the vacation utility,
for example:

	vacation -M message

For example:
	$ vacation -M Msg     
	Forwarding to |/usr/lib/mail/vacation2 -o %R -M Msg
	$

For example the message might contain (Note: the ``From:'' line is the address
for folks to reply to -- this should be of the form username@domain_addr, this
may not be needed if your mail subsystem puts a From: line for you, there
should be an entry ADD_FROM=true in /etc/mail/mailcnfg if using the default
mailer [/bin/mail])


	Subject: AUTOANSWERED!!!
	From: postmast@novell.co.uk (Postmaster)

	I am permanently on vacation. I will read (and answer if necessary)
	your e-mail message when and if  I return, and if I can be bothered.

	This message was generated automatically and you will
	receive it only once, although all the messages you send
	me while I am away WILL be saved.

	If your mail is really for the attention of somebody else, then why
	did n't you send it to them in the firstplace :-) Alternately try
	sysadmin@novell.co.uk :-)

	  -- The Postmaster


To  read your mail while vacation is in effect:

You can use your normal mail user agent (elm, mush, mailx or whatever),
since the UnixWare mailer keeps the forwarding information in 
/var/mail/:forward and not in the mailbox file as in earlier SVR4.0 releases.
	

To remove the vacation facility:

	/bin/mail -F ""

or
	vacation -n

For example:
	$ /bin/mail -F ""
	UX:mail: INFO: Forwarding removed
	$ 

Subject: M42) How do I setup my mail to be forwarded?


To forward all your mail to another person or another mailbox use
the following command :

To forward to a single person, e.g.

	/bin/mail -F andrew


To forward to more than one person use a quoted string:

	/bin/mail -F "andrew plord"

for example:


	$ /bin/mail -F "andrew plord"
	UX:mail: INFO: Installing forwarding to local address: andrew
	UX:mail: INFO: Installing forwarding to local address: plord
	UX:mail: INFO: Forwarding to andrew plord

It is also possible to combine a forward with the vacation programme:

for example

	
	$ vacation -M $HOME/.MSG -f andrew
	UX:vacation: INFO: Vacation notification installed
	UX:vacation: INFO: Logging will go to '/opt/lib/mserv/.maillog'
	UX:vacation: INFO: '/opt/lib/mserv/.MSG' will be used for the canned message

To confirm the forward is in effect, cat the :forward/user-id file:

	$ cat /var/mail/:forward/mserv
	Forward to andrew | C=0;S=2;F=*; /usr/lib/mail/vacation2 -o %R -M /opt/lib/mserv/.MSG

Note that you should not edit the /var/mail/:forward files directly
else they will loose the correct permissions and email delivery will
fail.


Subject: M43) How do I setup a mail-server?

The mail-server we use at novell.co.uk is the Squirrel mail-server
version 3.01 . This is written by Johan Vromans and is mainly
written in perl.


A binary version ready for use with UW1.x or UW2 is on the
Freebird archive
ftp.abs.net:/unixware/freebird/mailtools/mail-server.bin.tar.Z.

The steps to install this are as follows:

Create an account mserv, with the home directory rooted in 
/opt/lib/mserv.  We assume the mail-server archive tree is in
/home/mserv-archive, if its elsewhere make a symlink.

	useradd -s /usr/bin/ksh -d /opt/lib/mserv mserv
	(mkdir /opt/lib if it does not exist)
	cd /opt/lib
	zcat mserv.tar.Z|tar xvf -
	chown -R mserv mserv
	chown root mserv/listener

To run the mail-server, you need to install ALL the following packages:
utils/perl-4.0pl36.pkg.tar, archivers/gzip-1.2.4.pkg.tar,
utils/gnufind-3.7.pkg.tar.  All these packages are on the
novell.co.uk mail-server archive.

You also need to allow  the mserv account to use cron, 
edit  /usr/lib/cron/cron.allow and add the mserv user.

To test prior to running out of cron, login as user mserv

	./listener -noqueue

You can then type interactive requests

Once you are happy, edit the file

	mserv.hints


Place the files you want to serve in /home/mserv-archive,
run some of the indexing commands by hand

	./makeindex
	./makels
	./changes

Then enable the crons

	crontab ctab


Next stage, enable in the mailsubsystem. This can be done
by editing /usr/lib/mail/mailsurr.proto and editing the following in
section 3 of the file after the ckbinarsys entry.

# mail-server, mailing lists and information distribution handling section
'.+'    'mail-server'   '<      /opt/lib/mserv/listener'


Then run /usr/lib/mail/surrcmd/createSurr -l on. 


#	/etc/mail/extaliases


Then run /usr/lib/mail/surrcmd/createSurr -l on. 


On the system that the mail-server runs I have a mailbox called
bit-bucket, which as long as it exists in /var/mail/bit-bucket
and is mode 660 owner mserv, group mail is used to catch
all admin mail.

System aliases are added a file in /etc/mail, /etc/mail/names

### Mailserver ###
# if you want mail to go to real people
#mserv		plord andrew
# else put it in a mailbox
mserv		bit-bucket

# various typos on mail-server
mailserv	mail-server
mailserver	mail-server
mail_server	mail-server
mail-serverl	mail-server
mail-serv	mail-server
mail-serve	mail-server
mail-sarver	mail-server
mailx-server	mail-server
mailer-server	mail-server
ftpmail		mail-server


# various strange things that requestors send, best to dump them in the
# bit-bucket mailbox

reply-address	bit-bucket
your-address-here	bit-bucket
your-mail-address-goes-here	bit-bucket
address-to-reply-to	bit-bucket
your-email-address	bit-bucket


File Permissions:

All files except listener can be owned by user mserv.
listener has to be owned by root and setuid.


Subject: M44) How do I  setup a mailing list - such as Listproc ?

A port of ListProcessor Version 6.0, Binary distribution for UnixWare
is available on ftp.novell.de:/pub/unixware/usle/mailtools/listproc.bin.tar.Z.

Please observe the copyright notice below:

ListProcessor version 6.0 by Anastasios Kotsikonas, Copyright (c) 1991-93.
Use, duplication or disclosure by the U.S. Federal Government is subject to the
restrictions set forth in FAR 52.227-19(c), Commercial Computer Software or,
for U.S. Department of Defense Users, by DFAR 252.227-7013(c)(1)(ii).  


Note:
To make this work with the UnixWare mail subsystem (mailsurr), the
formail utility from procmail has been used as a front end to
the ListProcessor catmail utility, to edit the headers etc.


Installation instructions for this distribution

(1) Login as root

If you are running straight UnixWare 2.0 , 2.01 or 2.02
you need to apply a patch to the smtp subsystem. 

The supported version can be obtained from
ftp.sco.com:/UW20/tf2100.tar


(2) Then install the listproc tools into /home/listserv as follows:

cd /home
zcat listproc.tar.Z|tar xvf -
useradd -d /home/listserv -s /usr/bin/ksh listserv
chown -R listserv listserv
vi /usr/lib/cron/cron.allow     append listserv to the end of this file


(3) Setup the mailaliases etc:

You need to add entries in the /etc/mail/mailsurr file
for your mailing lists. This can be done by editing the
file /usr/lib/mail/mailsurr.proto adding the lines below
(note xopen-testing is an example) and then running the
command:

	/usr/lib/mail/surrcmd/createSurr -l on


####
#### Part 3
####
#### Delivery commands should go here.
####

# Check for binary mail. Uncomment this if you want to use it.
#
#'.+'	'!([^!]+)!.+'		'< F=*;C=0; /usr/lib/mail/surrcmd/ckbinarsys -t %C -s \\1'

# mailgate setup:
# mail-server, mailing lists and information distribution handling section
# admin requests
'.+'    'listproc'   	'<S=0;      /home/listserv/catmail -r -f'
# mailing lists
'.+'    'xopen-testing'   	'<S=0;F=1-255;C=*;  /home/listserv/catmail -L XOPEN-TESTING -f'


(4) Edit /etc/mail/namefiles and add:
/etc/mail/listaliases

This tells mailalias to look in this file for additional aliases.
Add the following to that list, change the name (andrew)
as appropriate

### Mailing Lists ###

# who is the overall admin for listproc
list-admin	andrew
# if you share this file on multiple machines enable the next line
# to get the mail to the right machine
#xopen-testing	lechladel!xopen-testing
xopen-testing-request	listproc


(5) Login as user listserv:

Edit the config file and change values in there as appropriate for
your configuration.

The organization line needs changing, as do the lists that
you define. In this example a list xopen-testing is shown.
This list requires all subscription requests to be approved
by the list owner.

Also in this example the lists are running on a machine called
lechlade, you want to change all email addresses to be those
of your mail domain.

Check out the documentation in the doc directory.

Lastly when you are ready and feel you have an understanding,
install a crontab entry .

Install a cron file to start the server:
	crontab crontab


This will start the server.

To test, send some mail to listproc, and also to xopen-testing.
It takes a while for the listproc to awake the first time, since
its only started on the hour, once awake the daemon keeps running.
Edit the crontab to start the daemon sooner.

To see where incoming requests go, if you configured the mailer
correctly, check the file /home/listserv/requests.

xopen-testing should say you are not subscribed, you can then
resend and subscribe. Check both the admin mail box and the
initiator.


Look at help/general and change the first line as required.

To add new lists you have to create a set of files in /home/listserv/lists
in a subdirectory as well as editing /home/listserv/config.
Check out the doc directory.


File & Directory Perms in /home/listserv

A couple of utilities have to be setuid listserv - see below:


total 4032
drwxr-xr-x    2 listserv other         96 Apr 12 14:56 News
drwx------    3 listserv other         96 Apr 12 14:56 arc
drwx------    5 listserv tech          96 Apr 12 14:55 archives
-rw-------    1 listserv tech           0 Jan 18  1994 batch
drwxr-xr-x    2 listserv other         96 Apr 12 14:56 bin
-rwsr-xr-x    1 listserv other         86 Apr 17 09:10 catmail
-rwsr-xr-x    1 listserv other     155400 Jan 26  1994 catmail.prog
-rw-------    1 listserv tech        6745 Feb 14 19:12 config
-rw-r--r--    1 listserv other         57 Feb 10  1994 crontab
drwx------    2 listserv tech        1024 Apr 12 14:55 doc
-rwx------    1 listserv other     175732 Jan 26  1994 farch
-rw-------    1 listserv tech          84 Jan 18  1994 flocks
-rwx------    1 listserv other      15208 Jan 26  1994 fwin
drwxr-xr-x    2 listserv tech          96 Apr 12 14:56 gateway
drwx------    2 listserv tech        1024 Apr 12 14:56 help
-rwxr-xr-x    1 listserv other      13892 Jan 26  1994 ilp
-rwx------    1 listserv other     321880 Jan 26  1994 list
-rwx------    1 listserv other     424760 Jan 26  1994 listproc
drwx------   11 listserv tech        1024 Apr 12 14:55 lists
-rwxr-xr-x    1 listserv other      45208 Jan 18  1994 make
-rw-r--r--    1 listserv tech         546 Jan 18  1994 makefile
drwxr-xr-x    4 listserv other         96 Apr 12 14:56 man
-rw-------    1 listserv other     251796 Jul  6 08:16 mbox
drwx------    2 listserv tech        1024 Jul 10 18:57 mqueue
-rwx------    1 listserv tech        1986 Jan 18  1994 news
-rw-------    1 listserv tech         892 Jul  5 10:18 owners
-rwx------    1 listserv tech        1888 Jan 18  1994 peer
-rwx------    1 listserv other     216956 Jan 26  1994 pqueue
-rwx------    1 listserv tech        1201 Jan 18  1994 queued
-rwxr-xr-x    1 listserv other        501 Jan 20  1994 rcp
-rw-------    1 listserv other         57 Jul  6 08:16 received
-rwx------    1 listserv tech         502 Jan 18  1994 redux
-rw-------    1 listserv other          0 Jul  6 08:16 requests
-rwx------    1 listserv other       4808 Jan 26  1994 rev
-rwxr-xr-x    1 listserv other       7420 Jan 26  1994 semset
-rw-------    1 listserv other          6 Jul  6 08:16 sent
-rwxr-xr-x    1 listserv other     172072 Jan 26  1994 serverd
-rwx------    1 listserv tech        6931 Jan 20  1994 setup
-rwx------    1 listserv other     169264 Jan 26  1994 start
-rwx------    1 listserv tech       23389 Jan 18  1994 systest
-rwx------    1 listserv other      22312 Jan 26  1994 tlock
-rwx------    1 listserv tech         133 Jan 18  1994 ulock
-rw-------    1 listserv tech         700 Jan 18  1994 unwanted.hosts
drwxr-xr-x    2 listserv tech        1024 Apr 12 14:56 util
-rw-r--r--    1 listserv tech         591 Jan 18  1994 welcome.live

Subject: M45) How do I  make sendmail the default mailer?

On UnixWare 2:

(Step 1). rename /etc/rc2.d/S81smtp to /etc/rc2.d/s81stmp
(Step 2).  Start sendmail in /etc/inet/config. Like this:

# The next line can be read:
# If field 3 is a Y and /usr/sbin/in.gated was not run, then run
# /usr/sbin/in.routed -q
4b:/usr/sbin/in.routed:/usr/sbin/in.gated:Y::-q:
###4c:/usr/sbin/route::n::add default router_placeholder 1
###6:/usr/sbin/in.xntpd::y:/etc/inet/ntp.conf::
7:/usr/bin/sh::y:/etc/inet/rc.inet:/etc/inet/rc.inet start:
4c:/usr/sbin/route::y::add default 129.123.1.254 1:
## added by JRD
8:/usr/ucblib/sendmail::y:/usr/ucblib/sendmail.cf:-bd -q24h:
9:/usr/sbin/syslogd::y:/etc/syslog.conf::


(Step 3). copy the /etc/ucbmail/mailsurr file over the /etc/mail/mailsurr file.

Note that you should also check the mailtools/sendmail directory
on the ftp archive since  there's likely to be a binary pkgadd
version of sendmail there..

Subject: M46) Mail of the address format @mylocal.domain:user@mylocal.domain 
              is not delivered locally, how can I fix this?

You need to add a line to /usr/lib/mail/mailsurr.proto
as follows:

After the uucollapse line add:

'.+'    '@(%DNODOT)[:,](.+)'               'Translate R=\\2'
'.+'    '@(%L%D)[:,](.+)'               'Translate R=\\2'
'.+'    '@(%U)[:,](.+)'         'Translate R=\\2'

Then run

        /etc/rc2.d/S81smtp stop
        /etc/rc2.d/S81smtp start            

Subject: M47) dtmail won't restart after my machine was switched off.

One of our machines was switched off with a dtmail session active
and when restarted wont let the user back into mail, saying the mail
is already being read - any ideas?

Check /var/mail/:readlock for a file as in username.lock

Try removing that file. If that does not work and you can't get
in (due to a kernel lock) move the mailbox in /var/mail aside
and rename it, then copy it back to the original name (has to be
done quickly:-)   

Subject: M48) Inbound mail is addressed to 
     <@site.demon.co.uk:user@domain.co.uk>
     and does not get delivered to the local user.


Our  Internet provider is Demon, and we are using the mail forwarding service.
This allows use of user@domain.co.uk, rather than the usual
user@site.demon.co.uk.
                    
The problem :-

The "RCPT TO:" line when receiving mail reads ( As seen in the osm log )

RCPT TO: <@site.demon.co.uk:user@domain.co.uk>

Instead of the mail being delivered to the user, it goes to root.  This is the
same for any user.  Outgoing mail is fine.   


To fix:  edit the /usr/lib/mail/mailsurr.proto file and
try the following:

{after uucollapse }; add

# Strip off local routes to domain, local.domain, uname, uname.alternate
'.+'     '@(%DNODOT)[:,](.+)'     'Translate R=\\2'
'.+'     '@(%L%D)[:,](.+)'     'Translate R=\\2'
'.+'     '@(%U)[:,](.+)'     'Translate R=\\2'
# put our alternate domain here
'.+'     '@(%site.demon.co.uk)[:,](.+)'     'Translate R=\\2'

                            
Subject: M49) I'm using PPP but don't have the interface up when the system
    creates the mailsurr file, and thus it does not detect my IP
    link - what can I do?


Bob Stewart writes:


If your only networking connection is via ppp, you will have to make
a change to /usr/lib/mail/surrcmd/configCheck if you want to use smtp
to send your mail.  Look for the section entitled "Check if IP is up
and running".  Add the following line immediately after the check to
just force IP as the mail transport:

$flaglist{IP} = 1;

Reboot your system, or alternately as root, type

	sh /etc/rc2.d/S81smtp stop
	sh /etc/rc2.d/S81smtp start

and verify that IP preceeds UUCP in /etc/mail/mailflgs.  

Subject: M50) How can I set mailalias in the form : user@site  maps to 
    local user?

I run multiple domains in my server and I want to map

	"sales@abc.com" to a user "andy"
	"editor@def.com" to a user "ron".     

How should I do this?
Set up the mailsurr file in the following way...

'.+'    '(sales)@([^@]+)(abc.com)'       'Translate T=1; R=andy'
'.+'    '(editor)@([^@]+)(def.com)'    'Translate T=1; R=ron'
            
The above matches sales@abc.com and sales@www.abc.com and any
other subdomains within abc.com.

To match editor and editors you can use a regexp as follows:

'.+'    'editor(s*)'    'Translate T=1;  R=andrew' 

Subject: M51) What is the /etc/mail/smtpcnfg file in tf2100/UW2.1?

This file is read when smtp is started.

It contains fields of the format 
	field=value

The default file with ptf2100 looks like

MX_FIRST=yes
USE_LOG_FILES=yes
USE_WRAPPERS=no
USE_OSM=yes
TIMEOUT=3 days
LOG_MASK=incoming, outgoing, errors

MX_FIRST=yes : means smtp attempts delivery to a hosts
specified Mail Exchanger record (MX DNS record) rather than the
delivering directly to the host IP address. If set to no,
then it attempts delivery directly to the host IP address and
then any MX hosts if specified.

USE_LOG_FILES=yes : whether to log to /var/spool/mailq/Logs. If no
value is given this defaults to yes.

USE_WRAPPERS=no : whether to check to access using the /etc/hosts.allow
file (as in the tcp wrappers package). I've not been able to convince
myself that this works at the moment.

USE_OSM=yes : whether to direct log messages to syslog (osmlog). If
yes these can be viewed using the Message_monitor GUI tool, or syslogd
can direct them to log files.

TIMEOUT=3 days : the time from original delivery attempt before the
mail is returned to the sender as being undeliverable. If a value of
"-1" is given the attempts continue indefinitely. An example of
7 days timeout can also be specified as "TIMEOUT=1 week".

LOG_MASK=incoming, outgoing, errors : what events to be logged.
Other classes to be logged are:  "queued" - log info on msgs
placed on queues; "debug" - log debug info; "connection" - log
info on connections; "recipients" - log info about recipients.
Its possible to switch all this off with the value "nothing"
or to switch all logging on with "everything".

Subject: M52) How should I setup Mail via PPP?

Let's assume firstly that you have a PPP link up and working
and that tcp/ip services between your host and your ISP have
been established.

Lets also assume that you can obtain the Email FAQ  from
ftp.abs.net:/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.m
since that explains the email subsystem in greater depth than here.

There are various scenarios:

  	(1) You have your own domain name, for example
  	tamarix.demon.co.uk and your ISP initiates an smtp
  	transfer to your host when you start a ppp session
  	(this is how demon work in the UK)

You need to establish your DOMAIN name for email. This can be
done by using the Mail_setup GUI tool or by editing(or creating)
the file: /etc/mail/mailcnfg

The mailcnfg file I use at home is

DOMAIN=demon.co.uk
FORCE_7BIT_HEADERS=1
FORCE_7BIT_MIME=1
ADD_TO=1
ADD_MESSAGE_ID=1
SMARTERHOST=post.demon.co.uk  

By setting DOMAIN=demon.co.uk outbound mail from my home machine tamarix
has the From: line set to tamarix.demon.co.uk.

Since you are at home you  want to try and do all mail processing
while offline - hence the use of a SMARTERHOST, whose IP address
should be added to your /etc/hosts file so as not to require
an MX lookup when sending mail (see smtpqer line later)

You also want to edit the file /usr/lib/mail/lookupLibs.proto
and comment out some lines in there so as to reduce DNS lookups.

/usr/lib/mail/libalias/home.so
/usr/lib/mail/libalias/file.so
/usr/lib/mail/libalias/passwd.so
<DNS>   #/usr/lib/mail/libalias/dns.so
<NIS>   #/usr/lib/mail/libalias/nis.so
<MHS>   #/usr/lib/mail/libalias/extract.so

This proto file ends up creating the file /etc/mail/lookupLibs ,
(after running the /usr/lib/mail/surrcmd/createSurr command - ran
out of /etc/rc2.d/S81smtp).

The /etc/mail/mailsurr file is the key file for determining how
mail gets delivered, I customize this file and then make it permanent -
after all once you've set it up why let createSurr keep rewriting it!

A fixed mailsurr file appropriate for PPP can be
obtained from:
	ftp.abs.net:/unixware/freebird/hints/Mail/mailsurr.ppp

  	(2) You have a POP mailbox on the ISP server, and your
  	mail account is username@your_isp_address.dom. You'll need
  	to use a POP client or equivalent to get the mail onto
  	your local machine. You'll then need to reply using mail on
  	the local machine and want to ensure that the mail headers
  	look like mail is being sent from the ISP machine.

In this case your mailbox is held on the ISP's machine and they
have a POP server.  You need a popclient to retrieve the mail from
the server onto your local machine. A version of the Mail Users Shell
(Mush) is available on ftp.abs.net:/unixware/freebird/mailtools/popclient
that can be used. There has also been a tool posted in this group
that will retrieve the mailbox from your ISP into the local machine,
in which case you can then use your favourite mail user agent to read it
(i don't have a copy off-hand).

POP allows you to retrieve mail but most servers don't allow you
to send mail. You can use smtp to send mail from your local machine
using the above configuration with one exception, you need to
rewrite the From: line for outbound mail to hide your nodename
(so in my case, mail would appear to come from demon.co.uk and
not tamarix.demon.co.uk).

This can be done by editing the file /etc/mail/rewrite
and adding the routine (this will need editing for your
configuration)

function check_headers()
{
var hdr;
# loop through ALL headers
for (hdr from headers_pattern("From:"))
   # if we match a header that has something like foo.xyz.com in it
   if (hdr ~ "[a-zA-Z]\\.demon\\.co\\.uk")
     # then substitute the shorter version in its place
     hdr=gsubstitute(hdr, "[a-zA-Z0-9.]+\\.demon\\.co\\.\\uk", "demon.co.uk");
}    

Add a call to this in the function main() in /etc/mail/rewrite, so this
looks like:

function main()
{
    add_missing_headers();
    check_headers();
}   

  	(3) When sending mail you'll want to consider whether you
  	want to relay mail via a SMARTERHOST (recommended), usually
  	your ISP or whether you want to send the mail directly 
  	across the internet to the remote recipient

In the mailsurr example above, I've assumed that this is what you'd
want to do. And in most cases this makes sense, since that way
you can let your ISP handle the routing and delivery issues.
For those odd occasions when you want to get mail somewhere quickly
or directly i use an i: prefix to say internet directly which you
may or may not find particularly useful. 

  	(4) Perhaps you have two PPP links in different domains (like
  	my home box), and can switch between them. You want to receive mail
  	to both domain addresses - this requires some level of customization

I have some scripts (written by Mike Convey) to swap between my ISP
and my work PPP links.  At home my machine is known as tamarix, at work
its known as voyager (now if i'd kept the names the same i would
not need this!).

When I send email i keep the tamarix.demon.co.uk
domain in there, but occasionally i want to forward mail over the work
link to my machine. In this case I have to add a line to the mailsurr
file so that it recognises the mail as local, otherwise it sends
it off to the SMARTERHOST

The trick is to add another delivery line to translate the mail
for local delivery, and add your alternate nodename in there

'.+'	'([^@]+)@(voyager)%D'		'Translate R=\\1'

The %D is needed since the inbound smtp adds the Domain info.

  	(5) Perhaps your ISP relays mail to you over uucp over TCP/IP,
  	perhaps by a mail forward? What then?

For incoming mail this is not a problem, and you can still send
mail outwards using smtp.

I'm sure there are other configurations not covered here, hopefully
this will be useful to some folks!

Subject: M53) How can I setup mail to handle virtual hosts's mail?

How do I handle virtual hosts' mail with mailsurr ?

Example: have machine           mydomain.net
have virtual machines           virtual1.ca
                                virtual2.ca
                                virtual3.ca
I want to have server handle mail for

sales@mydomain.net
sales@virtual1.ca
sales@virtual2.ca
sales@virtual3.ca   

One way to handle this is to add explicit rules on the mailsurr.proto
file as follows:

Add this in just before the area where it deals with supposedly local names.

# Map all names addressed to alias@domain.com to appropriate users.
'.+'    '(sales)@(mydomain.net)'                  'Translate T=1; R=ron'
'.+'    '(sales)@(virtual1.ca)'    'Translate T=1; R=andy'
'.+'    '(sales)@(virtual2.ca)'       'Translate T=1; R=linda'
'.+'    '(sales)@(virtual3.ca)'                    'Translate T=1; R=bob'

In the above, all the R=names are local users or aliases (if they
are not local you can alias them to the real addresses).   

Subject: M54) I need to print all incoming mail as well as send it to 
   local users.

# Add this before any address translations to mailsurr.proto
#    Send all incomming mail to printer and to user. 
#    Do a C=* so mail is sent to the user also.
'.+'    '([^@]+)@(mydomain.com)'                '< C=*; lp      -dtest'
                  
Acknowledgements:
----------------

Many thanks to the following for feedback and comments on various
drafts of this FAQ: Steve Wootton, Pete Holsberg, Michael Tiernan,
Bob Stewart, Dan Daggett.

--
Andrew Josey	 
#include <std/disclaimer.h>

