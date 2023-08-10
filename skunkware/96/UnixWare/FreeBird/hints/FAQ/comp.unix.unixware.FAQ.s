
Subject: UnixWare Frequently Asked Questions (SysAdmin)
Followup-To: comp.unix.unixware.misc
Summary: Answers to questions frequently asked about Novell's UnixWare product

Archive-name: unix-faq/unixware/sysadmin
Last-modified: XXXXXXXXXX
Version: 2.0

UnixWare Frequently Asked Questions List (SysAdmin)

For more information about the files which compose the total UnixWare
FAQ, see the "FAQ Overview" file posted regularly on the Internet newsgroup
comp.unix.unixware.misc.


INTRODUCTION

This is the User section of the UnixWare Frequently Asked Questions
file maintained on the Internet. Its maintainer is Evan Leibovitch
(evan@telly.org). Suggestions and contributions are always welcome.

The SysAdmin section deals with areas of interest to UnixWare system
administrators.


TABLE OF CONTENTS

S1) What books on UnixWare system administration might I read/purchase?
S2) How can I change my system's name?
S3) What traditional Unix utilities have been left out of the UnixWare PE?
S4) Does UnixWare come with TCP/IP and/or NFS?
S5) I've installed release 1.1.  Where's my TCP/IP?
S6) I've installed TCP/IP.  Where's NFS?
S7) Can I replace the stock UnixWare X server with something faster?
S8) Why can't I access the CD-ROM drive after I've just installed from it?
S9) Why does my data comm package lose characters constantly at high speeds?
S10) How can I make or get an emergency boot floppy?
S11) How do I set a dialup password on UnixWare for a specific port?
S12) How do I configure electronic mail on UnixWare?
S13) How many updates are there, what are they, and where do I get them?
S14) How do I know which updates I've already got installed?
S15) How can I make the man pages accessible from the command line?
S16) Are there disk compression utilties for UnixWare?
S17) How do I install a package downloaded from one of the ftp servers?
S18) How can I speed up the loading of Windows programs from floppies?
S19) Why has fingertip librarian suddenly stopped working?
S20) How can I get my 3COM 3C503 board to work?
S21) How can I set up my network adapter for 10base-T (twisted pair) wiring?
S22) How can I change [kernel tunable parameter]?
S23) Why does my system hang after displaying the Red Logo Screen?
S24) Why do I get error messages saying "Arg list or environment too large"?
S25) How can I add more pseudo terminals under UnixWare?
S26) What command will correctly tell me the amount of memory in my UnixWare box?
S27) Why can't I do tape backups > 512MB after loading UnixWare 1.1?
S28) How can I determine the serial number of my UnixWare installation?
S29) How can I send print jobs to an HP printer with a JetDirect card?
S30) How do I fix mail messages being flagged as From: smtp?
S31) Why do I get errors when trying to pkgadd PCFS?
S32) Root can telnet/rlogin/etc, but ordinary users can't?
S33) What does the message "socket: Permission denied" mean?
S34) How can I set up a printer for DOS/Windows users?
S35) UnixWare install tells me there aren't 120MB free, but there's much more!
S36) How can boot UnixWare/NT/OS2/etc all from the same hard drive?
S37) Can I use UnixWare with IDE drives larger than 528MB?
S38) What are "PTF"s and where do I find them?
S39) What PTFs are available?
S40) How do I install a package (like PTFs) that I've pulled off the net?
S41) Why can't files larger than 8MB be created?
S42) DOS won't run; says it's "Improperly installed".  Help?
S43) What non-SCSI CD-ROMs are supported by UnixWare?
S44) How can I set/change the system owner?
S45) Can I use my Mouse Systems mouse in 3-button mode?
S46) Some files copied from UNIX to NetWare simply disappear.  What gives?
S47) What does /dev/dsk/c0t0d0s0 mean, anyway?
S48) What does /dev/dsk/0s0 mean?
S49) How can I restore file privileges after a cpio restore?
S50) Does UnixWare implement full NIS client capability?
S51) How do I setup anonymous ftp?
S52) How do I setup a WWW server?
S53) Problems  Setting up an Install Server.
S54) When doing an upgrade/overlay from UW1 to UW2, what does Combine do?
S55) After installing UW2 why does it access the disk very heavily on the reboot?
S56) Are they any patches available for the NetWare UNIX Client for UnixWare2?
S57) How do I get NUC NLMS to load on a NetWare 3.11 server?
S58) Must I load NUC NLMs and add the NFS name space to volumes I want to access from UnixWare 2.01?

QUESTIONS

Subject: S1) What books on UnixWare system administration might I read/purchase?

Well, let's start with the UNIX Press books:

  - Administration Series -
  Title                                  ISBN #
  Basic System Administration            0-13-042573-7
  Advanced System Administration         0-13-042565-6
  Network Administration                 0-13-017633-8
  PC-Interface Administration            0-13-066820-6
  Audit Trail Administration             0-13-066887-7

Mick Galvin (mick@ddiq.com) adds:

  As I think one of the points of Unixware is the integration of Netware
  with Unix I would highly recommend "Novell's Guide to Integrating UNIX and
  NetWare Networks" by James E. Gaskin, published by Novell PRESS. This is
  a *very* current book (1993) and amongst other things offers thoughts on
  topics like why netware for unix is not available on UnixWare (even though
  the Univel fax back server suggests it is!) It is sprinkled with humour.

  Novell's Guide to Integrating UNIX and NetWare Networks
  James E. Gaskin, Novell Press, 1993
  ISBN: 0-7821-1129-7

A must for Unix sysadmins is:

  UNIX Power Tools
  Jerry Peek, Tim O'Reilly, and Mike Loukides
  O'Reilly and Associates/Random House 1993
  ISBN 0-679-79073-X

This book combines 1000+ pages of text-mode Unix advice with a CD-ROM
of precompiled binaries for various popular UNIX platforms (including
SCO, which should run on UnixWare) of a large variety of useful
text-mode applications.

Subject: S2) How can I change my system's name?

>From the command line, you can use the setuname utility:

  setuname -n <newname>

You can also use sysadm (either invoking it as such from the command
line, or from the UnixWare desktop as System_Setup->Extra_Admin).
Select

  system_setup->nodename->set->Network node name

and change the name found there.

You will also need to change the hostname entries in the following
files if you have networking installed:

  /etc/net/ticlts/hosts
  /etc/net/ticots/hosts
  /etc/net/ticotsord/hosts

These files deal with the loopback transport mechanism; each typically
consists of a single line of the form "<hostname><tab><hostname>".
You should change both instances of the host name.  And don't forget:

  /etc/hosts
  /etc/uucp/Systems.tcp

DON'T listen to those who recommend you use "uname -S <newname>", by
the way.  This sets not only the node name (which is what you want to
change) but the "system" name (which is initialized to UNIX_SV and
should remain that way) as well.  The latter is almost certainly not
necessary.

Subject: S3) What traditional Unix utilities have been left out of the UnixWare PE?

A common complaint among long-time Unix users is the omission of
numerous standard Unix utilities from the Personal Edition.  While
ordinary users might not typically use these commands, shell scripts
do, and thus Univel may have - if inadvertently - introduced yet
another Unix version incompatibility into the already-too-large mix.

Among the items lacking in the Personal edition are: the C and Korn
shells (the Windowing Korn Shell [wksh] _is_ included, however),
banner, calendar, head, join and dc.  These commands _are_ available,
however, in the Advanced Utilities module (an add-on optional
package).

Most, if not all, of these, utilities are included in the UnixWare SDK,
which bundled the "Personal Utilities" of v1.0.  GNU replacements for
many, if not all, of these can also be found on the Prime Time or 
Unix Power Tools CD-ROMs.

Oh, and of course TCP/IP was left out of the release 1.0 Personal
Edition, too, but is bundled with 1.1.  (NFS, however, is NOT
included.)

Subject: S4) Does UnixWare come with TCP/IP and/or NFS?

The Release 1.0 Personal Edition does not include TCP/IP or NFS in the
basic system.  A TCP/IP+NFS package is available from Univel; a
similar offer, plus a TCP/IP-only option, is available from
Information Foundation.

Release 1.1 does include TCP/IP in the Personal Edition, but not NFS.
NFS remains an extra-cost option. UnixWare 2.01 PE includes both
TCP/IP and NFS bundled.

TCP/IP and NFS are bundled with the UnixWare Application Server in
all releases 1.0 , 1.1 and 2.01.

Subject: S5) I've installed release 1.1.  Where's my TCP/IP?

Shame on you.  Page 1 of the UnixWare 1.1 Release Notes states:

  TCP/IP is a separate package on the CD-ROM or tape medium and must
  be installed in a separate step [...] after the base installation 
  and UnixWare 1.1 Post Install.

The package set that you must install is named tcpset.

Note that tcpset does not include NFS.  NFS is a separate package set,
named nfsset.

Subject: S6) I've installed TCP/IP.  Where's NFS?

NFS is not included in the tcpset package set in UnixWare 1.1.  It is
loaded as a separate package set, named nfsset.  This will be in the
Application Server distribution media; it is on separate media in the
Personal Edition.

Subject: S7) Can I replace the stock UnixWare X server with something faster?

Yes.  Several vendors sell X servers which can be used to speed up X
on your UnixWare system.  Typically, these vendors will also sell you
drivers for specific cards as well.  A partial list of such vendors
follows:

  Quarterdeck Office Systems' Hyper-X 
  (formerly sold as Pittsburgh Power Computing's Hyper-X)
  150 Pico Boulevard
  Santa Monica, CA 90405
  (310) 392-9851
  (310) 314-4219 FAX
  hyperx@qdeck.com
  info@qdeck.com
  Call 800-354-3222 Extension 8G8 for special introductory offer
  Hyper-X should also be available through conventional distribution
  channels, eg dealers selling other Quarterdeck products (QEMM, Desqview)

  Metrolink Metro-X
  2213 W. McNab Road
  Pompano Beach, FL 33069
  (305) 970-7353
  (305) 970-7351 FAX
  sales@metrolink.com

  X Inside (X server and drivers formerly sold by
  Snitily Graphics Consulting Service of Cupertino CA)
  Toronto CA
  (416) 762-3778

There is also XFree86.  From David Wexelblat's 
announcement of the release of XFree86 2.1:

  XFree86 is a port of X11R5 that supports several versions of Intel-based
  Unix and Unix-like operating systems.  The XFree86 servers are derived
  from X386 1.2, which was the X server distributed with X11R5.  This
  release consists of many new features and performance improvements as well
  as many bug fixes.  The release is available as source patches against the
  MIT X11R5 code, as well as binary distributions for many architectures.

  Source patches are available to upgrade 2.1 to 2.1.1.  These and source
  patches for 2.1 based on X11R5 PL26, from MIT, and as an upgrade from
  XFree86 2.0 are available via anonymous FTP from:

       ftp.x.org (under /R5contrib/XFree86)
		(note that this is not in place at the time of the posting)
       ftp.physics.su.oz.au (under /XFree86)
       ftp.win.tue.nl (under /pub/XFree86)
       ftp.prz.tu-berlin.de (under /pub/pc/src/XFree86)

  Refer to the README file under the specified directory for information on
  which files you need to get to build your distribution (which will depend
  on whether this is a new installation or an upgrade from an earlier
  version of XFree86).

  Binaries are available via anonymous FTP from:

       ftp.physics.su.oz.au                    - SVR4 binaries
                under /XFree86/SVR4
       ftp.win.tue.nl                          - SVR4 binaries
                under /pub/XFree86/SVR4
       ftp.tcp.com                             - SVR4 binaries
                under /pub/SVR4/XFree86
       stasi.bradley.edu                       - SVR4 binaries
                under /pub/XFree86/SVR4

Release 2-1 of the Prime Time SDK includes XFree86 2.0 in pkgadd
format.  Prime Time is now, in fact, _the_ point of contact for
XFree86 distribution; you can buy XFree86 by itself on a CD-ROM
for about $40.  Contact:

    Prime Time Freeware
    370 Altair Way, #150
    Sunnyvale, CA 94086
    +1 408 433 9662 Voice
    +1 408 433 0727 FAX
    ptf@cfcl.com

If you have access to Usenet news, see the newsgroup

news:comp.windows.x.i386unix

for ongoing discussions of XFree86 and other Intel/Unix/X solutions.

Subject: S8) Why can't I access the CD-ROM drive after I've just installed from it?

Bill Rosenblatt writes:

  This is a known bug that is supposed to be corrected for release 1.1.
  There's a relatively simple workaround:

   1. Shut down your machine.
   2. Open the machine and remove the SCSI adapter card.
   3. Leave the cover off and reboot.  The system will print an error
      message, but it will come up.
   4. Shut down again.
   5. Replace the SCSI card and put the cover back on the machine.
   6. Reboot again.  The system will rebuild the kernel, which will
      take a few minutes.  Then it will tell you to reboot.  Do so.
   7. When the system comes up again, the CD-ROM should be accessible.

Another method I received from UnixWare tech support proceeds as follows:

  When the CD-ROM driver seemingly drops out of sight in UnixWare, one
  cannot read from a CD, nor can one mount a cdfs file system.

  To correct this, first determine the proper name of your CD-ROM device
  driver. Change directory to /dev/cdrom and do an ls. There will be a
  driver file there in the form "cxtxlx" where the x's are SCSI controller
  number, tag numberm and logical unit number respectively. (e.g. the driver
  will be something like "c0t4l0" or c0t3l1") Write this name down!

  Next, it is necessary to create a "raw device." Change directory to /dev
  and "mkdir rcdrom" to create a directory called /dev/rcdrom. Then change
  to this new directory and make nodes for a CD based on the name found in
  /dev/cdrom.

                 mknod c0t4l0 c 0 0
                 mknod cdrom1 c 0 0

  These commands in succession are "make node <device driver> see-zero-zero"
  and "make node cdrom1 see-zero-zero." Note that the next-to-last character
  in the device driver name is an "ell" not a "one."

  While still in the /dev/rcdrom directory, make the whole directory 
  readable, writable, and executable to everyone.

                 chmod 0777 .
                 chmod 0777 *

  and everything should be fine. You can check by clicking on the
  "Disks Etc." icon to see if the CD-ROM icon is there.


Subject: S9) Why does my data comm package lose characters constantly at high speeds?

Bill Rosenblatt again:

   The odds are good that the problem is with the UART on your
   serial interface card.  If you have a relatively low-end PC,
   you probably have an old-style UART that interrupts the CPU after
   it receives every character.  Unix usually handles serial interrupts
   at a low level (lower than DOS does, for example), so it can't keep
   up if the speed is too high, usually above 9600bps.

   To fix this, you need to get a new UART, a 16550 UART that has
   a 16-byte buffer.  The 16540 UART, with a 2-byte buffer, may also
   be enough of an improvement.  If your UART isn't in a socket,
   then you will have to replace the entire card.  Luckily, these
   are not very expensive--about $40 for a single-port card or
   $70 for a standard PC multi-port card.

   Additionally, you need a device driver
   that knows how to take advantage of the UART's buffering.  
   UnixWare has such a device driver (asyhp), but the current version is
   known to be flaky.  Novell should have a fix for this available on
   ftp.novell.com before 1.1 comes out.  In any case, here's
   what you need to do to enable the driver, courtesy of Joao Costa
   (jcosta@quimic.pt):
   
   Just go to /etc/conf/sdevice.d, edit asyhp and turn N to Y for
   the ports you want, then edit asyc and turn Y to N on those ports.
   Rebuild the kernel and, when the new kernel boots, you'll have a status
   message about your 16550 ports.

Note that for UnixWare 2 you should NOT use the 'asyhp' driver.
All functionality of the 1.x asyhp driver has been rolled
into the new 'asyc' driver so there is no need to modify the
default serial driver in UnixWare 2.01.  This is discussed
in the man pages for both asyc and asyhp.   


Subject: S10) How can I make or get an emergency boot floppy?

Release 1.1 comes with the ability to create an EBF by one's self.
Insert a blank floppy in the drive, and execute as root:

  /usr/sbin/emergency_disk diskette1

Release 1.0 users must ftp the EBF from ftp.novell.com:

  ...you can now generate your own Emergency Boot
  Floppy (ebf) for UnixWare 1.0.  There is an ebf update available
  on ftp.novell.com (and on CompuServe).  The file is ebf.tar and is
  located in /pub/unixware/Updates.  This package DOES NOT create an ebf, but
  installs a utility to do so.

  Get ebf.tar, and as usual untar it.  chmod the .run file to be
  executable and then execute it to install the package.

  Once the package is installed, execute the command
  /usr/sbin/emergency_disk diskette1 (or diskette2).  This ought to
  do it.

Martin Sohnius (msohnius@novell.co.uk) warns:

`BEWARE!  There is a major security risk with the EBF.  This is pretty
  obvious to any knowledgable user, so there is no point not to warn you
  against it here:  the only thing preventing anyone who has access to the
  hardware, and has an EBF from any UW machine, from becoming root on your
  system is not knowing the system's serial number.  This, however, is
  printed on the third boot floppy, and, moreover, is displayed by one of the
  desktop utilities.  Since any EBF will boot any system (provided you give
  it the correct serial number), you better lock up your floppy drives!'

Note that the EBF can only boot a UnixWare 1.x system with an intact
root file system.  The EBF alone is not sufficient to boot UnixWare
1.x.  This may restrict the utility of the EBF somewhat.

Subject: S11) How do I set a dialup password on UnixWare for a specific port?

Andrew Josey of Unix Systems Labs Europe (a.josey@uel.co.uk) provides
the following guide:

  Two files must be created in the /etc directory, and for ease of
  use you can add a user (say called dialup).

  (1) /etc/d_passwd
  ------------------

  This is the dialup password file.

  # ls -l /etc/d_passwd
  -rw-------   1 root     root          70 May 13 07:44 /etc/d_passwd
  #

  This contains entries for login shells (uucico, ksh and sh).
  Usually there is no additional password for uucico.
  Interactive logins (ksh, and sh) have passwords.

  The encrypted password must be put in the file, note spaces and position
  of the colon delimiters are critical.

  # cat /etc/d_passwd
  /usr/lib/uucp/uucico::
  /usr/bin/ksh:66NOJGfJw4I.A:
  /usr/bin/sh:66NOJGfJw4I.A:
  #

  (2) /etc/dialups
  -----------------
  The second file /etc/dialups dictates which devices are
  to have the dialup password prompt

  # cat /etc/dialups
  /dev/tty00
  /dev/tty01h


  (3) Setting the password
  ------------------------
  To set the password, I have a login entry for a user dialup (this 
  just executes date as the login shell).

  Thus on the day to change the password

    i)

    # passwd dialup
    New password:
    Re-enter new password:
    #

    ii)

    # grep dialup /etc/shadow|cut -f2 -d":" >>/etc/d_passwd

    This appends the new dialup onto the end of the d_passwd file.

    iii)

    Edit the file with vi to place the new encrypted password
    in the appropriate fields marked XXXX below:

    /usr/lib/uucp/uucico::
    /usr/bin/ksh:XXXX:
    /usr/bin/sh:XXXX:

Subject: S12) How do I configure electronic mail on UnixWare?

>From another machine that is already properly connected for email,
send a message to Andrew Josey's mail server at USL Europe to receive
some hints, that cover both UnixWare 1.x and 2:

  mail-server@novell.co.uk

The message body should be:

  begin
  reply <your-email-address>
  send hints/Mail/Howto_setup
  end

where, of course, you have substituted your actual email address for
"<your-email-address>".

Subject: S13) How many updates are there, what are they, and where do I get them?

Update 5, the first for v1.1 and known as update 1.1.1, involves the 
Pentium-optimizing compiler which was inadvertently left out of the
1.1 SDK and other minor fixes.  It is available on 3.5" floppies or
CD-ROM directly from Novell, as well as via ftp:

  ftp.novell.com://pub/unixware/unxwre11/coreos/upd111.tar

Update 1.1.1 for UnixWare 1.1 is itself at revision 1.1.  (Finally, some
unity in the Unix world, eh? :-)  Only a few individuals who downloaded
update 1.1 from the Internet shortly after it was released are likely to
have revision 1.0 of Update 1.1.1; to verify which revision you have on
your system, perform a "pkginfo -l update111".  If revision 1.0 has been
installed, patch ptf155.tar can be downloaded from the Internet to
update the broken X server (which caused problems with SCO X binaries)
in the 1.0 package.

UnixWare 1.1 and the UnixWare 1.1 SDK should _both_ be installed prior
to installing update 1.1.1.

Updates for UnixWare 1.1 can be found at:

  ftp.novell.com://pub/unixware/unxwre11/coreos/

Current updates include
	upd111.tar
	upd112.tar
	upd113.pt1
	upd113.pt2
	upd113.pt3
	upd113.pt4
	upd114.pt1
	upd114.pt2
	upd114.pt3
	upd114.pt4

Subject: S14) How do I know which updates I've already got installed?

Updates will show up as installed packages; from the UnixWare desktop,
double click:

  System_Setup->Application_Setup

Be patient while the installed applications are cataloged.  When you get the  
browser showing installed packages, you will be able to see the installed  
updates.

If you are the impatient sort, Andrew Josey (andrew@uel.co.uk) suggests:

  I cancel the cataloging, and then hit

	View
	  Installed Appl'ns
	    All

  Which is usually quicker... and ok when you know you've not reinstalled
  anything new recently.

Subject: S15) How can I make the man pages accessible from the command line?

This answer for UnixWare 1.x.

The following symbolic links will enable users to access the standard
UNIX man pages without further action on their part:

  ln -s /usr/flib/books/man /usr/share/man
  ln -s /usr/flib/bin/fman /usr/bin/man

UnixWare 2 includes a "traditional man pages" package, which when
installed means you can type man ls. UnixWare 2 also replaced
the FingerTip Librarian with Dynatext, a hypertext-based browser.

A documentation FAQ is available from ftp.novell.de
	~ftp/pub/unixware/usle/hints/FAQ/uwdocs.FAQ

Subject: S16) Are there disk compression utilties for UnixWare?

Programmed Logic sells such a drop-in replacement compressed file
system that, among other things, can be installed as the root
partition and can be NFS-exported.  Programmed Logic claims that it
can double a file system's capacity.  For information on the Desktop
File System (DTFS), contact:

  Programmed Logic Corp.
  200 Cottontail Lane
  Somerset, NJ 08873
  (908) 302-0090 Voice
  (908) 302-1903 FAX
  Email:
  info@prologic.com (For product inquiries)
  sales@prologic.com (For order placement)
  support@prologic.com (technical support for registered users)

Subject: S17) How do I install a package downloaded from one of the ftp servers?

Rick Richardson (rick@digibd.com) explains:

  You can untar the stuff anywhere convenient, say,
  under /tmp, and then:

    pkgadd -d /tmp

  The pkgname is optional.  Note that the -d flag assumes that if the
  argument begins with a '/', then its a package in filesystem format.
  Otherwise, its a magic cookie (e.g. diskette1) to pick a storage device.
  I.E., this won't work:

    cd /tmp; pkgadd -d .

Subject: S18) How can I speed up the loading of Windows programs from floppies?

If you find yourself loading a Windows program more than once, for
whatever reason, you might appreciate Rick Richardson's "Handy trick
#1427":

  Use the file manager to copy each
  installation floppy to d:\diskN where N is the disk number.
  Then, you can try to install a program as many times as you
  want without waiting for floppies.  Just run D:\DISK1\SETUP
  from the file manager.  At least with Word, setup seems
  to understand that the files aren't coming from floppies
  and will just proceed to install everything it needs
  from d:\disk1, d:\disk2, etc. without further prompting.

  Discovered purely by accident - I had the disks in
  d:\w1, d:\w2, etc. and after setup finished with w1,
  it said it couldn't find d:\disk2\somefile.  Aha I say!

(FAQ maintainer's observation: I believe this is how some Windows
software is organized on CD-ROMs for installation - that might be why
the Windows setup program understands it.)

Subject: S19) Why has fingertip librarian suddenly stopped working?

(This answer for UnixWare 1.x only)

An authorization code file for the flib shipped with release 1.0
inexplicably carried an expiration date of 12/31/93.  There is a
trivial fix for this: 

  $ mv /usr/flib/authorization /usr/flib/authorization.old

flib should now work again.  This problem has been fixed in v1.1.

Subject: S20) How can I get my 3COM 3C503 board to work?

Try disabling shared memory on the card.

Subject: S21) How can I set up my network adapter for 10base-T (twisted pair) wiring?

Specify "BNC" as the transceiver type.  This enables the internal
transceiver on the card, which is used by both BNC and 10base-T
connections.

Subject: S22) How can I change [kernel tunable parameter]?

The following is quoted verbatim from a UnixWare TechFlash from June 1993:

  To increase file limit size (equivelent to
  ulimit):

    SFSZLIM - Soft file size limit.
    HFSZLIM - Hard file size limit.

  To increase user data (process heap and
  brk(2)) area:
  
    SDATLIM - Soft data limit.
    HDATLIM - Hard data limit.
  
  To increase user stack (stack segment) area:
  
    SSTKLIM - Soft stack limit.
    HSTKLIM - Hard stack limit.
  
  To increase address space (brk(2) area) for
  process:
  
    SVMMLIM - Soft Virtual Memory limit.
    HVMMLIM - Hard Virtual Memory limit.

The procedure to change these tunable parameters is documented
in the UnixWare System Administration - System Performance
Administration manual, Chapter 3.  To change these parameters,
login or su to root and:

	# cd /etc/conf/bin

	# ./idtune SFSZLIM 0x7FFFFFFF

Change all the parameters that affect you.  The idtune command
changes SFSZLIM to the unlimited setting.  You also may specify
a lower value than this if you do not want it set to unlimited.  
You can also see each tunable parameter's current setting by
doing the following (using SFSZLIM for example):

  # ./idtune -g SFSZLIM
  0x1000000       0x1000000       0x2000  0x7FFFFFFF

The first value is the current setting, the second is the
default setting, the third is the minimum value, and the last is
the maximum value.

After all tunable paramters have been changed, you need to
rebuild the kernel and shutdown the system:

  # ./idbuild -B

  # cd / ; shutdown -g0 -y

Subject: S23) Why does my system hang after displaying the Red Logo Screen?

Martin Sohnius (msohnius@novell.co.uk) explains:

After a little techie conference here in the "YES, Tested and Approved"
lab, we came to the following conclusion:

  At boot time, the original boot code performs the BIOS call to set
  up graphics mode.  The "Loading UnixWare" logo screen is displayed
  while the Unix kernel is loaded.  When the Unix kernel takes over,
  it switches the processor to 'protected mode' and among its first
  responsibilities is to switch the display back to VGA text.  It
  doesn't properly do this on all Pentium/PCI machines at this stage,
  presumably because it's now accessing hardware directly rather than
  through BIOS calls. 

  The good news is, that a work-around which we found for the
  installation can therefore be relied upon to work:

  When the red logo screen comes up during UnixWare installation (both
  on Boot Floppy 1 of 3 and later when it reboots after the final
  kernel has been built), IMMEDIATELY use the space bar to interrupt
  the boot process.  The logo screen will disappear, and you will be
  prompted 

	Enter the name of a kernel to boot:

  Simply hit <Enter> (meaning unix), and things will proceed.
  Switching out of graphics mode BEFORE unix is loaded, means that the
  the switch is performed via the BIOS call, and thus works.

  Once you have installed the system successfully, rename or remove
  the file /stand/image.


Subject: S24) Why do I get error messages saying "Arg list or environment too large"?

By default, UnixWare limits the total size of a command's argument list
to 5120 bytes - far too small a value.  I regularly ran up against this
limit trying to grep things in /usr/include/sys/*.h, myself.

You need to increase the ARG_MAX tunable kernel parameter to get around
this - see the FAQ on changing tunable parameters, and set ARG_MAX to 
something like 10240, or larger.

Subject: S25) How can I add more pseudo terminals under UnixWare?

Martin Sohnius (msohnius@novell.co.uk) is to be thanked for this FAQ
(in which I quote both the question and the answer verbatim - makes my
job easy! :-)

  To add more pseudo terminal devices (say, 32), perform the following
  steps as 'root':
 
  1)   Edit /etc/conf/mtune.d/io and increase the first value on the
        NSTREAM row by 32, but don't exceed 512.
 
  2)   Edit /etc/conf/sdevice.d/ptm and change the first numeric value
       from 16 to 32:
 
            ptm Y   16  0   0   0   0   0   0   0   -1

       to:
 
            ptm Y   32  0   0   0   0   0   0   0   -1
 
  3)   Similarly, edit the two files /etc/conf/sdevice.d/ptem and
       /etc/conf/sdevice.d/consem and change the first
       numeric value from 16 to 32.
 
  4)   Next you need to tell the system to create the proper device nodes
       when the kernel is rebooted.  To do this, create the following shell
       script /tmp/node.sh:
 
       for i in 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
       do
            echo "pts pts/$i    c    $i" >> /etc/conf/node.d/pts
       done
 
       Make sure that node.sh is executable (chmod 755 node.sh) then run
       it.  Also note the spacing between the strings within the quotes:
       between the strings 'pts' and 'pts' there is a space, between '$i'
       and 'c' there is a tab, and between c' and '$i' is also a tab.

       Look at the /etc/conf/node.d/pts file to see whether this succeeded.
 
       After you have run the scripts,
	   
  5)   Run /etc/conf/bin/idbuild -B to rebuild your kernel, then reboot.


Subject: S26) What command will correctly tell me the amount of memory in my UnixWare box?

Use the memsize command (/sbin/memsize or /etc/memsize), which
displays the kernel's concept of how much memory it has available.

/usr/sbin/prtconf, which gets memory information from the system BIOS,
is inaccurate above 16MB of installed memory.

Subject: S27) Why can't I do tape backups > 512MB after loading UnixWare 1.1?

This is a bug in the UnixWare 1.1 tape driver.  Martin Sohnius offers
the fix:

  Download the file /netwire/nsd/ptf126.tar from the server
  ftp.novell.com (note: you cannot scan the directory /netwire/nsd).
  Unpack the tar archive, run the ptf126.run script to create a diskette,
  and from it load the package ptf126 onto your machine.  This should
  fix the problem.


Subject: S28) How can I determine the serial number of my UnixWare installation?

The following will print out your UnixWare installation's serial
number:

  cat /etc/.snum


Subject: S29) How can I send print jobs to an HP printer with a JetDirect card?

The HP JetDirect cards include software that is installed on host
systems that are to send jobs to the printer.  Currently, UnixWare is
not among the supported platforms.

Newer versions of the JetDirect card support the lpd protocol,
however, allowing connection to UnixWare machines.  Simply set up the
printer as an ordinary remote, BSD-style printer.

For older versions, a connection of sorts can be made by opening a TCP
socket to port 9100 and dumping the data directly to the printer.

Subject: S30) How do I fix mail messages being flagged as From: smtp?

Paraphrased from an Andrew Josey (andrew@novell.co.uk) posting:

Add the following line to /etc/mail/mailcnfg:

  ADD_FROM=1

The ADD_FROM entry tells the smtp daemon to add a From: line to an
incoming mail message that does not already include one.  This ensures
a valid reply address to an incoming mail message.

To provide valid return addresses on outgoing mail, edit the smtp
entry in /etc/inetd.conf to read as follows:

  smtp stream tcp nowait smtp  /usr/lib/mail/surrcmd/in.smtpd in.smtpd -r

The -r flag tells the smtp daemon not to rewrite the mail headers.
After making this change, send a hangup signal to inetd, or execute
the following commands:

  sacadm -k -p inetd
  sacadm -s -p inetd


Subject: S31) Why do I get errors when trying to pkgadd PCFS?

Someone hacked the pkginfo file, apparently unaware that pkgadd
checksums everything before installing it.  To fix this, after
extracting the tar archive, edit the file pcfs/pkgmap and replace the
line which says

  1 i pkginfo 216 18169 748905337

with

  1 i pkginfo 183 14284 748905337


Thanks to Martin Sohnius (msohnius@novell.co.uk) for this fix.

Subject: S32) Root can telnet/rlogin/etc, but ordinary users can't?
Subject: S33) What does the message "socket: Permission denied" mean?

UnixWare has, in addition to the standard file mode bits, a set of 
"file privileges" associated with executable files.  These privileges 
need to be properly set for executables, such as networking utilities,
to be able to access and use the resources necessary to accomplish
their task.

For some reason, the TCP/IP networking utilities are often installed
without their file privileges properly set.  To fix this, bring the
system down to single-user mode by logging in as root on the console
and executing the command

  shutdown -y -g0 -iS

Then enable the TCP/IP utilities' file privileges by executing
the command:

  /etc/inet/inet.priv -e

Then reboot the system

  shutdown -y -g0 -i6

and the TCP/IP utilties should work properly.

Subject: S34) How can I set up a printer for DOS/Windows users?

>From System_Setup->Printer_Setup, add a printer called "doslp".

Type it as a "DOS Printer", no matter what it is, but set up the
  rest of the parameters just like normal.  This means that you'll
  probably not want to use this from within UNIX (although, more on
  that later), but strictly from DOS/Windows.  Well, that's why
  it's called "doslp".

>From within DOS, this printer will be accessible as LPT1:

>From within Windows, this printer will be accessible as LPT1.DOS.

One note about the doslp printer:  it essentially passes data through
unfiltered.  This means that if, like me, you've expected to be able
to send PostScript files off to a PostScript printer typed as PostScript
when set up within the UnixWare print system - and, like me, been quite
annoyed when the file is converted into mountains of plain text output
because you didn't specify a -T option (and is the correct -T option
"postscript", "Postscript", "PostScript", or just plain "PS"?) - you
might then find the doslp printer convenient.  Indeed, I have tested
it, and the following:

  lp -d doslp file.ps

does precisely what you'd expect.

Subject: S35) UnixWare install tells me there aren't 120MB free, but there's much more!

Probably it didn't recognize your host bus adapter (HBA), and hence
doesn't see a SCSI disk out there to install onto.  In that case,
you'll need an HBA diskette from your SCSI adapter vendor to supply to
the installation process when it asks for one.

Subject: S36) How can boot UnixWare/NT/OS2/etc all from the same hard drive?

Scott G. Hall (sgh@cbvox1.cb.att.com) has one possibility:

  There is a commercial product available to switch between operating
  systems that I suspect loads as the primary bootmanager for the
  harddisk.  The product is called "System Commander" from

  V Communications
  San Jose, CA
  800-648-8266
  (408-296-4224)

Check out their ad in Dr. Dobb's Journal, August '94, p.58, and an
apparent review in PC Magazine, May 31 '94 (per their ad).

Subject: S37) Can I use UnixWare with IDE drives larger than 528MB?

Terry Lambert (terry@cs.weber.edu) delivers the bad news:

The current IDE standard doesn't support > 528M -- period.

There *is* a new standard (ATA) that will.

There are also three other methods of pushing out the size; the first
is by stealing 2 unused bits to use a 12 bit (instead of 10 bit) cylinder
address.  This gives you 4096 cylinders instead of 1024.  The second
method is doing what UNIX does, and using sector offset addressing --
that is, use an absolute sector offset instead of a C/H/S address
(this is the one WD is pushing, but it means throwing away BIOS).  The
third and final method is by taking your two drive slots and *logically*
pretending that a 1G drive is two 528M drives (menaing you are now
limited to one drive).

Now the good news: with the exception of logically splitting the drive
into two drives, all these approaches mean new controller hardware, at
the least, or a new bus interface (meaning news controllers, cables,
and drives) at most.

So at least you get new hardware out of it.  8-(.

The probable reason UnixWare isn't supporting the 1G drive is that
it uses the logical drive splitting, and the idiots who manufactured
the controller were only interested in the DOS market, so they did the
tricks in BIOS using weird (non-ST506/WD interfaced) hardware, so it
would take a hardware driver to support the interface card.

Subject: S38) What are "PTF"s and where do I find them?

A PTF is a "Program Temporary Fix", aka, a patch.  These
are located dependent on the OS version:

UnixWare 1.x PTFS are in:

ftp://ftp.novell.com/pub/unixware/unxwre11/coreos

UnixWare 2.x PTFs are in:

ftp://ftp.novell.com/pub/unixware/unxwre201/coreos

The UnixWare 2 PTFs are now now called TFs - temporary fixes.

Subject: S39) What PTFs are available?

In the two directories mentioned above is a file called
	pinfo.tar

This contains a report detailing the available PTFs and their
applicability.

Subject: S40) How do I install a package (like PTFs) that I've pulled off the net?

Someone (probably Martin Sohnius) posted the following advice:

Usual method:

For *most* ptf's, once you have un-tarred the stuff, you'll have a file
whose name ends in .txt, and possibly a read.me file.  Read those.  Then,
usually, there will be a file ending in *.run, and one or more other
files.  When you run the *.run script like this (as root):

  sh *.run

you'll be presented with a menu which includes "install now" (or similar)
as an option.

Exceptional method:

ptf130, and also some others like ptf619 (Kumar's video drivers), are
exceptions to this rule.  After un-tarring, there is no *.run file, only a
(big) file called ptf130.  This file is in "package stream format".  You
can verify this by the command

# hd ptf130 | head -2
0000	23 20 50 61 43 6b 41 67  45 20 44 61 54 61 53 74   # PaCkAgE DaTaSt
0010	52 65 41 6d 0a 70 74 66  31 33 30 20 31 20 39 35   ReAm.ptf130 1 95

Normally, you would copy this file to a diskette,

  cat ptf130 > /dev/rdsk/f0t

and you can then use 

  pkgadd -d diskette1

To load directly from the hard disk, do:

  pkgadd -d `pwd`/ptf130


Subject: S41) Why can't files larger than 8MB be created?

UnixWare by default sets a file size limit of 8MB, both via the kernel
tunable parameters SFSZLIM & the HFSZLIM (soft and hard file size limit,
respectively) and via the "ULIMIT=" line in /etc/default/login (the
default login profile file) or in a user's .profile (or .cshrc &c) file.

See the FAQ section on changing kernel tunables for information on how
to increase SFSZLIM and HFSZLIM; you can edit /etc/default/login or
~/.profile by hand.

Martin adds:

It's best to remember that the symbolic value "unlimited" will
always work.  Thus

  ULIMIT=unlimited

in /etc/default/login, and

  ulimit unlimited

from the command line. (BTW, that sets it to 7FFFFFFF, the biggest
signed long.)

UnixWare 2 has a larger ulimit by default:

$ uname -a
UNIX_SV usle 4.2MP 2.01 i386 x86at 
$ ulimit
2097151     

Subject: S42) DOS won't run; says it's "Improperly installed".  Help?

If you're getting errors such as the following:

     % dos +x
     IMPROPER_INSTL: dos: ERROR: Improperly installed.
     Permission mode incorrect and/or ownership is wrong.

try the following advice from Martin Sohnius (msohnius@novell.co.uk):

/usr/bin/dos is a so-called "privileged file", and
*any* modification of its inode modification time such as by chmod or chgrp
or of its contents (such as adding a virus) will scupper the privileges.
As root, you *should* get:

  # filepriv /usr/bin/dos
  fixed     macupgrade,loadmod


If you don't get any privileges listed, do this:

  # grep /usr/bin/dos /etc/security/tcb/privs
  307512:39868:764947112:%fixed,loadmod,macupgrade:/usr/bin/dos
  # ls -l /usr/bin/dos
  -r-xr-xr-x   2 bin      sys       307512 Apr 28  1993 /usr/bin/dos
  # sum -r /usr/bin/dos
  39868   601 /usr/bin/dos

Then check that the first two fields of the entry in the privs file match the
size and checksum of your /usr/bin/dos -- we wouldn't want to catch a virus,
would we?  Then do:

  # filepriv -f macupgrade,loadmod /usr/bin/dos

Happily, there is a shell script (/usr/lib/merge/instdx.sh) that
automates the procedure of fixing the permissions on /usr/bin/dos.
Simply run this script as root to accomplish this task.  This shell
script only fixes /usr/bin/dos, however; it will not deal
with any other executables (DOS or otherwise) whose file privileges
have been munged somehow.

Subject: S43) What non-SCSI CD-ROMs are supported by UnixWare?

The following non-SCSI CD-ROM drives are supported by UnixWare 1.1 out
of the box:


* Sony CD 31A
* Sony CD 535
* Philips LMS CM205
* Philips LMS CM255


There are drivers on the ftp servers for the following devices:


* Mitsumi CRMC-LU005S [but not the FX]


jpltech@aol.com adds:

I recently used a Sony CDU-33A (follow-on to the 31)
with a SMS31083 controller to install UW PE 1.1.
The only problem was that the controller IO address had to be changed
from the factory defaults to what Unixware 1.1 wanted.

Subject: S44) How can I set/change the system owner?

See the man page for make-owner, which adds, deletes or transfers
ownership privileges for various usernames.  The executable is
/usr/X/adm/make-owner.

Thanks to Terry Lambert (terry@cs.weber.edu).

Subject: S45) Can I use my Mouse Systems mouse in 3-button mode?

No.  At least, not with the stock USL server.  You must use Mouse
Systems rodents in 2-button mode (flip the little switch on its
underbelly).

Some other (non-Novell) X servers might support the Mouse Systems
mouse in 3-button mode (one that I know of is the old Snitily server;
I don't know if the XInside servers carry forward this practice or
not).

I replaced the Mouse Systems device I got with my Mobius system (which
used to have the Snitily server on board) with a Logitech "First
Mouse".  This latter device does work in three-button mode, and is
very comfortable (IMO) to work with.  Your mileage may vary, of
course.

Subject: S46) Some files copied from UNIX to NetWare simply disappear.  What gives?

If you've copied files from the UNIX domain onto a NetWare server, and
some or all seem to have disappeared (as viewed from a DOS box), first
try listing the directory into which you've copied the files with the
NetWare "ndir" command.  You may find that the recently copied files
have the "System" and/or "Hidden" attribute set on the DOS side,
either of which causes the files to be invisible when viewed with an
unaided "dir" command.

The cause of this is the imperfect mapping of UNIX mode bits into
NetWare/DOS attributes.  Files with an "execute" mode bit set on the
UNIX side, for example, will have the "system" attribute set on the
DOS side.

To fix this, simply remove execute permissions on the UNIX side prior
to transferring the files.  Or, if the files have already been
transferred, use the DOS "attrib" command to remove the "System"
and/or "Hidden" attributes.

Subject: S47) What does /dev/dsk/c0t0d0s0 mean, anyway?

The two directories /dev/dsk and /dev/rdsk contain device
nodes for the block I/O drivers (suitable for mounting as filesystems)
and raw disk partitions, respectively.  The following chart, by Martin
Sohnius, explains the naming scheme of these device nodes:

  /dev/[r]dsk/c?t?d?s?
               ^ ^ ^ ^
               | | | |_____   slice number (0 - f)
               | | |
               | | |_______   logical unit number (almost always 0)
               | |
               | |_________   SCSI ID (for IDE drives: 0 or 1)	 
               |
               |___________   controller number (0 for primary -- boot)

In somewhat more detail:

* The controller number refers to the disk controller.  The
primary controller, off of which the system boots, is always zero.
Note that this numbering scheme encompasses both IDE and SCSI
controllers.
* The target number identifies the particular unit connected
to a disk controller.  For SCSI disks, the target number is the same
as the SCSI address of the disk.  For IDE drives, the target is 0 or
1, identifying the two possible drives on an IDE chain.
* The logical unit number distinguishes among multiple units
multiplexed onto a single SCSI or IDE target.  It is almost always 0,
specifying the first (and only) unit at that target.  (It may be used
to distinguish among multiple disks in a RAID configuration - can
anyone help the FAQ maintainer on this question?)
* The slice number identifies which of up to sixteen possible
disk slices is referred to.  In the case of the nodes in
/dev/dsk, these slices correspond to mountable filesystems.

Subject: S48) What does /dev/dsk/0s0 mean?

To simplify access to device nodes (which otherwise, by the
/dev/dsk/c?t?d?s? scheme, would require detailed knowledge of
disk layouts, the primary and secondary drives on a system are also
available via the nodes

  /dev/[r]dsk/[01]s[0-F]

Here the first number in the node name, always 0 or 1, identifies the
primary or secondary disk.  The second number identifies which slice
of up to fifteen is being referred to.  Hence, /dev/dsk/0s0
refers to the first slice on the primary disk, while /dev/dsk/1s0 
refers to the first slice on the secondary disk.

This naming scheme only covers the first two drives on the system,
subsequent disk drives must be accessed by the nodes
/dev/[r]dsk/c?t?d?s?.

Subject: S49) How can I restore file privileges after a cpio restore?

As many sysadmins have discovered, simply restoring files with their
original mode bits is not sufficient in UnixWare.  In addition to the
standard UNIX file access modes, UnixWare adds on certain file
"privileges" for enhanced security.  Unfortunately, these privileges
are not retained across a cpio backup and restore.

Greg Kable of Novell Sydney provides the following shell script, to be
run as root, to restore these privileges:

#!/bin/sh
sed 's/:/ /g' /etc/security/tcb/privs |
while read code1 code2 code3 privs file 
do 
filepriv echo "$privs" | sed -e s/%fixed,/ -f /' -e 's/%inher,/ -i /' $file 
done
_ttyoff

_faq(How can I get my Etherlink III (3C509) card to work?)

UnixWare 1.1s problems with the 3C509 card are legendary.  The root
cause seems to be the card's design, which use an I/O scheme that's
tight and fast and safe under DOS, but gives fits to multitasking
operating systems like UnixWare.  Not to put the entire blame on the
card, it also turns out that a slight deficiency in one part of the
UnixWare kernel's I/O system was outed by the 3C509.

At any rate, the following three-step program should get you back on
the right track with the Etherlink III:

* Bring your system up to version 1.1.2, by installing updates
1.1.2 and 1.1.1 as necessary.
* Apply patch ptf648.  This installs a new 3C509 driver.
* Apply patch ptf192.  This fixes the kernel I/O deficiency.


Subject: S50) Does UnixWare implement full NIS client capability?

Upgrade your system to version 1.1.2 to obtain full NIS client
capability.

Subject: S51) How do I setup anonymous ftp? 

* Send email to mail-server@novell.co.uk
* Send the following as the text of the message (the subject
is unimportant):

     begin
     send hints/Networking/anon-ftp
     end

There is also binaries and sources for wu-ftpd on 
ftp.novell.de:/pub/unixware/internet/server/wuftpd

Subject: S52) How do I setup a WWW server? 

Binaries and sources for setting up a WWW server on UnixWare can
be found ftp.novell.de:/pub/unixware/internet/server/. There are
two versions available ncsa-httpd and cern-httpd. The CERN version
takes approximately one minute to install and get running.

Subject: 53) Problems  Setting up an Install Server.

        Q - When attempting to setup an Install Server, I am not
allowed to load the system image.

        A - You must first 'enable' to install server within the
Install Server utility before attempting to load the system
images.
     
S54) When doing an upgrade/overlay from UW1 to UW2, what does Combine do?

Q - When doing an upgrade/overlay installation, what is the
proper usage of the 'Combine' or the 'Not Combine' option?

A - When upgrading from 1.x to 2.01, ALWAYS use 'Combine'.
The 'Not Combine' option is used ONLY for 2.01 to 2.01
overlay installs where some of the system files have been
corrupted, and fresh system files are needed.  See the
Installation handbook, page 80 for information about doing a
'Not Combine' overlay installation.
   
S55) After installing UW2 why does it access the disk very heavily on the reboot?

After the first reboot of the system and the graphical
login is displayed, DOS Merge files are being configured in
the background.  This will take a few minutes to complete.
If this process is interrupted prematurely and the system is
shutdown, DOS Merge may not function properly.  You may need
to remove and re-add the Merge package using the App
Installer graphical utility.  


S56) Are they any patches available for the NetWare UNIX Client for UnixWare2?

Yes; it's name is: tf2000.tar.  It is available on the ftp server 
ftp.novell.com, World Wide Web server www.novell.com, and on Compuserve.  
This patch is a necessity if you are using the NetWare Unix Client on
UnixWare to communicate with NetWare servers.


S57) How do I get NUC NLMS to load on a NetWare 3.11 server?

You must load 2 updates onto your 3.11 server: LIBUP5
and TCP188.  Once loading these updates, the NUC NLM's will
load.  Please note that XCONSOLE will not load until you
first load REMOTE and RSPX. 


S58) Must I load NUC NLMs and add the NFS name space to volumes I want to access from UnixWare 2.01?

Yes.  Novell are currently working on this issue to allow
file system access to NetWare servers without requiring NUC
NLM and the NFS name space.  


