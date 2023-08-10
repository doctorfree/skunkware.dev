Newsgroups: comp.unix.unixware.misc
Subject: UnixWare Frequently Asked Questions List (General)
Supersedes: <Dp4nC8.1LC@tamarix.demon.co.uk> 
Followup-To: comp.unix.unixware.misc
Summary: Answers to questions frequently asked about SCO's UnixWare product
Expires: Wed, 15 May 1996 00:00:00 GMT

Archive-name: unix-faq/unixware/general
Posting-Frequency: monthly
Last-modified: 14 April 1996
Version: 2.05

UnixWare Frequently Asked Questions List (General)

For more information about the files which make up the total UnixWare
FAQ, see the "FAQ Overview" file posted regularly on the Internet newsgroup
comp.unix.unixware.misc.

Introduction

This is the General section of the UnixWare Frequently Asked Questions
file maintained on the Internet. Its maintainers are Evan Leibovitch
(evan@telly.org) and Andrew Josey (andrew@tamarix.demon.co.uk). 
Suggestions and contributions are always welcome.

The General section covers aspects of UnixWare not covered in the other
sections of the FAQ (User, Sysadmin, and Developer). This section may
be subdivided in the future if necessary.

This document may be obtained by anonymous ftp from the freebird
archive at
    ftp.abs.net:/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.g
    netlab1.usu.edu:/pub/mirror/freebird/hints/FAQ/comp.unix.unixware.FAQ.g
    ftp.osiris.com:/pub/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.g 

TABLE OF CONTENTS

G1) What is UnixWare? Is it really SVR4 based?
G2) Where can I purchase UnixWare?
G3) How much does UnixWare cost?
G4) What industry standards does UnixWare support?
G5) What versions of X11 and Motif are supported? What about CDE?
G6) What's new in UnixWare 2?
G7) What are UnixWare's hardware requirements?  Does it run on a PC?
    How can I find out hardware compatibility?
G8) What is the current release/version of UnixWare?
G9) Can I upgrade from any version of UnixWare 1.1 to version 2.0?
G10) What is the UnixWare "Personal Edition"?
G11) What is the UnixWare "Application Server"?
G12) Are there any books I can read/purchase about UnixWare?
G13) How about review articles on UnixWare?
G14) Are there anonymous ftp / mail server sites with UnixWare archives?
G15) Where can I get online information on UnixWare?
G16) Where can I get a hardware compatibility list for UnixWare?
G17) Where can I find a driver for [accelerated graphics card]?
G18) Is there a UnixWare user's group?
G19) Does UnixWare support multiprocessing?
G20) Does UnixWare function as a NetWare server?
G21) What is the future for UnixWare?

QUESTIONS

Subject: G1) What is UnixWare? Is it really SVR4 based?

UnixWare is one of SCO's Unix offering (transferred from Novell to SCO 
on Dec 6th 1995), combining UNIX System V Release 4.2 for 80x86 processors
(including Multiprocessors)  with NetWare client connectivity, DOS Merge,
Motif, support and documentation.  It provides a graphical user
interface based on the X11R5 windowing system, and is capable of
running Unix, DOS, and/or Windows programs.

UnixWare, first released in November 1992, was the product of a
jointly-owned venture, named Univel, between Novell and Unix System
Laboratories (USL, then 77% majority owned by AT&T).  In June 1993,
Novell completed its acquisition of USL and, by extension, Univel.
USL and Univel were folded into the Novell Unix Systems Group 
(USG, the namesake of an earlier group by the same
name at AT&T). 

UnixWare 2 and 2.1 were developed by the same team (formerly 
at 190 River Road, Summit, New Jersey, then Florham Park, NJ) 
that worked with Sun Microsystems to create UNIX System V Release 4.
UnixWare 1.x was based on the UNIX System V Release 4.2 kernel completed
by USL in July 1992 , and UnixWare 2.x was based on the UNIX System V
Release 4.2MP kernel completed by USL in December 1993.

In September 1995 Novell announced it was pulling
out of the UNIX business and that the UnixWare business would transfer
to SCO Inc. The transfer completed on December 6th 1995.
Future development of UnixWare 2 will be done by  SCO at Florham
Park and other sites TBD.

The "UNIX" trademark, previously owned by AT&T and then deeded to USL,
passed to Novell with the acquisition of USL.  After a brief period of
negotiations with rival Unix vendors Sun Microsystems, Santa Cruz
Operation, International Business Machines, and Hewlett-Packard,
Novell granted exclusive licensing rights to the UNIX trademark to
X/Open Co. Ltd., an Open Systems industry standards organization
headquartered in the United Kingdom.  The granting of licenses for
the trademark UNIX is now handled exclusively by X/Open (see
http://www.xopen.co.uk/faq/faq_brnd.htm for Q&A's on X/Open
UNIX and the branding programme); the industry agreed definition
of UNIX (known as UNIX95 aka Spec1170) is a set of over 1,000-odd 
applications programming interfaces (APIs) drawn from the 
following standards:

  IEEE Portable Operating System's Interface (POSIX) 1003.1
  AT&T's System V Interface Definition SVID3
  X/Open's XPG4 Version 2 interface specification
  "Use-based" APIs drawn from an assortment of third-party vendors

UnixWare 1.x and 2.x are currently UNIX93 branded.  

A summary of some of the key features of UnixWare (taken from
http://unixware.sco.com) follows:

   32-bit processing with a fully-multithreaded kernel and preemptive
   multitasking 
   Based on the latest version of UNIX SVR4.2 MP multiprocessor technology
   Asynchronous I/O 
   Kernel, disk I/O and networking protocols are multithreaded for optimal
   performance and scalability 
   User-levels threads APIs for writing multithreaded applications 
   Dynamically loadable modules including device drivers, file systems, etc., to
   optimize memory utilization and performance 
   Adheres to POSIX 1003.1, X/Open XPG4 Base Profile Brand, FIPS 151-2,
   UNIX System V ABI, ABI+, SVID 3, iBCS2 and X Consortium ICCCM 
   Point-and click, drag-and-drop GUI 
   Clock, calculator, text editor, e-mail and terminal emulator 
   Online hypertext documentation and help facility 
   OSF/Motif 1.2.3 GUI for desktop and applications 
   Support for X-Window X11R5 facilities, including bit-mapped fonts 
   Adobe Type Manager plus 13 Adobe Type 1 scalable fonts (uses standard DOS
   and Adobe fonts) 
   Intuitive installation procedure from CD-ROM or QIC-tape or via network 
   Graphical system and network administration tools 
   Support for UNIX commands, interfaces and utilities such as Bourne shell,
   ksh, csh, vi, tar and cpio 
   Full internationalization:English, German, French, Japanese, Italian and
   Spanish versions available


Subject: G2) Where can I purchase UnixWare?

Since December 6th 1995, UnixWare can be purchased through the SCO
reseller channel.

To order SCO UnixWare in North America, call the following number:

	1 800 SCO UNIX     (1 800 726 8649)

For outside of North America, call:

	+44 1923 816344


Some existing resellers of UnixWare prior to the transfer to SCO
are listed below, please note that the following information may no 
longer be current.

Information Foundation can be contacted at sales@if.com.

Every mail-order software house I've contacted so far has carried
UnixWare.  This includes the following:

  Computer Discount Warehouse     Programmer's Paradise
  1-800-891-4CDW                  1-800-445-7899

  ASAP Software Express           Inmac
  1-800-248-ASAP                  1-800-323-6905

  UniPress Software               Unidirect
  1-800-222-0550                  1-800-755-8649

When dealing with mail-order houses, be sure to specify exactly what it
is that you want, i.e. Release 2.01 or 1.1. 

Subject: G3) How much does UnixWare cost?

Please note: The information below may be a bit dated but was 
current before December 6th 1995.

UnixWare 2.01 Personal Edition carries a price tag (list) of $445,
while the Application Server lists at $1,695.
The software development kit lists at $145.

Note that UnixWare 2 now includes the C compiler in the PE and AS
editions - see the developer FAQ for more details.

Subject: G4) What industry standards does UnixWare support?

UnixWare 1.x

UnixWare 1.x supports the following formal and defacto industry standards

   X/Open Portability Guide Issue 3 Base Profile (XPG3)
   System V Interface Definition Issue 3 (SVID3)
   IEEE Std POSIX 1003.1-1990 (ISO 9945-1) [UW1.1.1 and later **]
   US Govt. FIPS 151-2 [UW1.1.1 and later formally certified]
   X/Open UNIX 93 branded


UnixWare 2.x

UnixWare 2.x supports the following formal and defacto industry standards

   X/Open Portability Guide Issue 4 Base Profile (XPG4)
   System V Interface Definition Issue 3 (SVID3)
   IEEE Std POSIX 1003.1-1990 (ISO 9945-1) 
   US Govt. FIPS 151-2 (2.01 has been certified to GTI, MC, MFS and AP)
   Partial IEEE POSIX 1003.2-1992 support (commands)
   Partial XPG4 X/Open Transport Interface (XTI)
   X/Open UNIX 93 branded
   
Subject: G5) What versions of X11 and Motif are supported? What about CDE?

X11 Support (graphical display system)

UnixWare 2 currently supports the X11 graphical system at release 5
(complete with the standard X11 libraries and window managers). However,
an unsupported release of X11R6 (as well as updated graphic drivers) are
available on the Novell Germany ftp site

The X11R6 server supports PEX, XIE, SHAPE ,MIT-SHM, Multi-Buffering,
XTEST, BIG-REQUESTS, MIT-SUNDRY-NONSTANDARD, XIdle,
DEC-XTRAP, XIE, SYNC and XC-MISC extensions.

The X11R5 server supports SHAPE, MIT-SHM, Multi-Buffering, XTEST,
MIT-SUNDRY-NONSTANDARD, XIdle and DEC-XTRAP extensions.        

Motif

Motif libraries and the mwm window manager are shipped with UnixWare. The
current version of Motif is 1.2.3. Also included are the MOTIF/OpenLook (Moolit)
libraries and window manager.

CDE (Common Desktop Environment)

Although UnixWare 2 out-of-the-box doesn't support CDE directly, UnixWare
2 is "CDE-ready". This allows third parties to provide CDE functinality for
UnixWare 2.     One such company is TriTeal (see http://www.triteal.com).
                            
Subject: G6) What's new in UnixWare 2?

This taken and Abridged from Novell's WWW site

Question: What are the key enhancements in UnixWare 2 over UnixWare 1.1?

Answer: 

1. Fully multithreaded: UnixWare 2 operating system, I/O subsystem,
TCP/IP, NFS, IPX, and user level threads, to dramatically increase
performance and scalability from small desktop machines to very large
MIS SMP servers. UnixWare 2 Application Server (AS) and Personal Edition
(PE) packages support dual-processor machines "out-of-the-box," with the
AS expandable to many processors via simple Processor Upgrade kits. 

2. Improved installation and configuration. Installation
routines have been simplified, hardware detection automated,
installation over LANs is more flexible (TCP/IP or IPX), setup of video
monitors is graphical, and total install time is reduced significantly. 

3. Improved PC LAN integration. Single login to UnixWare 2 and NetWare
LAN, printer sharing from clients to either UnixWare or NetWare servers,
built-in NVT2 DEC VT220 and Host Presenter terminal emulation for
NetWare clients, access to more LAN cards via the NetWare ODI driver
interface, NFS included in the Personal Edition. 

4. Improved administration and management. Many enhanced graphical
administration functions, graphical performance monitor and tuning, C2
Auditing included, MIB II compliant SNMP network management agent in
both TCP and IPX networks, new Dynatext browser for on-line
documentation, dynamic start-up and shut-down of processors in SMP
configurations via the graphical interface. 

5. Expanded hardware support. A broad array of Intel uniprocessor and
SMP machines, including those designed for the Intel MP Spec v1.1,
Corollary CBUS II, an other proprietary architectures. SMP platform
support is simplified by a Platform Support Kit (PSK) which abstracts
many interfaces and provides examples of working code for different
implementations. Many new peripherals including ODI LAN adapters, high
resolution video cards, CD ROM drives, SCSI adapters, sound cards, and
many others. 

6. Improved SDK. The AS and PE include the C compilation system. C++
and the Graphical programming SDKs are included on the UnixWare 2 SDK

Subject: G7) What are UnixWare's hardware requirements?  Does it run on a PC?
    How can I find out hardware compatibility?

Yes, UnixWare runs on PCs.  The necessary hardware configuration for
installing and running UnixWare is:

* A personal computer running an Intel 80386 or higher processor
  with a minimum speed of 25MHz.
  The ISA, EISA, and MCA bus architectures are supported.
* A minimum of 8MB RAM for the Personal Edition.
* A minimum of 12 MB RAM for the Application Server.
* A minimum 80MB hard disk for the Personal Edition.
* A minimum 120 MB hard disk for the Application Server.
* A minimum 40MB if you have a second hard disk (optional).
* A 3.5-inch or 5.25-inch diskette drive for booting UnixWare.
* A serial, bus, or PS/2-compatible mouse is recommended, but not required.

Evan Leibovitch (evan@telly.on.ca) notes that, while UnixWare does not
absolutely require a 3.5" diskette drive, it is a practical necessity
in real world usage.  Many useful/necessary packages only come on 3.5"
media.  He adds that the 1.1 release supports the new 2.88MB format
3.5" floppies for those machines which support it.

Eric Raymond used to post in the Usenet group comp.unix.pc-clone.32bit
a guide to hardware compatibility for Unix versions that run on
Intel-based hardware.  While not specifically devoted to UnixWare, it
was handy for discussions of the difficulties that may be encountered
in installing Unix on PC hardware.  Unfortunately, nothing has been
heard from Raymond in recent times and, while you can probably find a
copy of the last version of the pc-clone hardware guide in the
rtfm.mit.edu archives, the information therein is getting more dated
by the minute.

SCO maintain a set of Web pages that provide an Online
Hardware Compatibility Handbook. The UnixWare2 information is
integrated into that. This is available at:
	http://www.sco.com/Third/hch

Subject: G8) What is the current release/version of UnixWare?

The current version of UnixWare 1.x is release 1.1.4.  
The current version of UnixWare 2.x is release 2.03.

UnixWare 2.1 (also known as Eiger) is expected in 1H96.

Subject: G9) Can I upgrade from any version of UnixWare 1.1 to version 2.01?

Yes.  UnixWare 2.01 will overlay certain versions of UnixWare 1.1.
These are UnixWare 1.1 and UnixWare 1.1.2, you must remove the
UnixWare 1.1.3 or 1.1.4 update releases prior to beginning an installation.

Update 2.03 can be applied to UnixWare 2.01 directly without the need
to apply Update 2.02.


Subject: G10) What is the UnixWare "Personal Edition"?

The UnixWare "Personal Edition" is limited version of UnixWare.
It is limited to 2 users and 2 CPUs (in UW2.x).
UnixWare 2.x includes NFS , TCP/IP and the CCS .


Subject: G11) What is the UnixWare "Application Server"?

As the name implies, the Application Server is the server version of
UnixWare.  Originally, at least, the idea was that an enterprise
network would be built up of DOS, Windows, and UnixWare clients, with
a NetWare box providing file services and a UnixWare AS running
applications which would display on the PE clients.  I don't know if
this is still the plan or not.
It has an unlimited user license and the ability to support
more than 2 CPUs (with the appropriate licenses). 


Subject: G12) Are there any books I can read/purchase about UnixWare?

If you have UnixWare 2, firstly try the online documentation -
now in Dynatext and a great improvement on the UnixWare 1.x Fingertip
Librarian.

A book worth considering is "Novell's Guide to UnixWare 2"
by Chris Negus and Larry Schumer . This is a second edition,
the previous edition was about UnixWare 1.1. Published by Sybex
its ISBN number is 0-7821-1720-1.

Its also possible to order printed documentation (see the developer
FAQ for details).

Another good reference is the UNIX Press books on Unix SVR4.2.
There follows a complete list of the Unix SVR4.2 series:

  Title                                  ISBN #

  - User's Series -
  Guide to the Unix Desktop              1-56205-114-8
  User's Guide                           0-13-017708-3

  - Administration Series -
  Basic System Administration            0-13-042573-7
  Advanced System Administration         0-13-042565-6
  Network Administration                 0-13-017633-8
  PC-Interface Administration            0-13-066820-6
  Audit Trail Administration             0-13-066887-7

  - Programming Series -
  UNIX Software Development Tools        0-13-017690-7
  Programming in Standard C              0-13-017666-4
  Programming with UNIX System Calls     0-13-017674-5
  Character User Interface Programming   0-13-042581-8
  Graphical User Interface Programming*  0-13-042698-9
  Network Programming Interfaces         0-13-017641-9
  Device Driver Programming              0-13-042623-7
  STREAMS Modules and Drivers            0-13-066879-6
  Portable Device Interface              0-13-066838-9

  - Reference Series -
  Command Reference (a-l)                0-13-042699-0
  Command Reference (m-z)                0-13-042607-5
  Operating System API Reference         0-13-017658-3
  Windowing System Reference             0-13-017716-4
  System Files and Devices Reference     0-13-017682-6
  Device Driver Reference                0-13-042631-8

(*Be careful of this book; the copy you are buying may be based on
the old MoOLIT GUI technology, which is being phased out in favor of
pure Motif.)

To order single copies of this documentation, call (515) 284-6761.
For bulk purchases (more than 30 copies), contact

  Corporate Sales Dept.
  PTR Prentice Hall
  113 Sylvan Avenue
  Englewood Cliffs, NJ 07632
  (201) 592-2863
  (201) 592-2249

Samuel Ko (kko@sfu.ca or sko@wimsey.bc.ca) maintains the "Concise
Guide to UNIX Books", which is posted regularly to the Usenet
newsgroups misc.books.technical, alt.books.technical,
biz.books.technical, comp.unix.questions, comp.unix.wizards,
comp.unix.admin, comp.answers, and news.answers.  It can also be
downloaded from the Internet via anonymous ftp at

ftp://rtfm.mit.edu/pub/usenet/news.answers/books/unix.

This list contains many titles of interest to UNIX users both new and
old, and is well worth the trouble to acquire.

Subject: G13) How about review articles on UnixWare?

Open Systems Today, in its February 15 1993 issue, reviewed the
initial release of UnixWare 1.0.

The June 15, 1993 PC Magazine reviewed UnixWare favorably, rating it
the Editor's Choice for "Intel Unix" above Consensys V4.2, Dell Unix
(RIP), Interactive, SCO Open Desktop, NeXTStep on Intel and Solaris
x86.  (Note that the last two were reviewed prior to release.)  The
review concluded `This just may be the Unix for the masses.'

UnixWorld magazine profiled UnixWare over a two-part series in the
July and August 1993 issues.  UnixWorld looked at UnixWare from the
traditional Unix user's point of view, predicting that `power Unix
users will dismiss UnixWare out of hand, ' but also noting the
advantages of the tight integration with NetWare.  The UnixWorld
reviews are probably much more useful to a system administrator than
an ordinary user.

Byte Magazine, after a September 1992 "Is Unix dead?" cover story that
looks rather silly now in retrospect, gave UnixWare (then still in
beta) a friendly reception in its January 1993 issue.  `On features
alone, UnixWare is one hot number: networked file, mail, printer, and
application sharing; NetWare client connectivity; DOS compatibility;
high-performance multitasking and virtual memory; a network-capable
windowing system with scalable Adobe Type Manager fonts; two levels of
hypertext help -- and these are just the highest of the high points'
opined the Byte reviewer (Tom Yager [tyager@bytepb.byte.com], Byte's
Multimedia Lab).

Subject: G14) Are there anonymous ftp / mail server sites with UnixWare archives?

SCO has an anonymous ftp service at ftp.sco.com.
UnixWare files can be found under ~ftp/UW20.


For freeware checkout ftp.abs.net:/unixware/freebird -
binaries of handy things like the GNU development tools, perl, Seyon
and GhostScript show up there.

The ftp.abs.net site is also available at

  ftp.osiris.com:/pub/unixware/freebird
  netlab1.usu.edu:/pub/mirror/freebird
  ftp.novell.co.uk:/pub/unixware/freebird
  ftp.novell.de://pub/unixware/usle

A mailserver site for UnixWare binaries and sources (which makes
the freebird archive available by email) is

  mail-server@novell.co.uk

To obtain an index of the contents, send an email to that address with
the following contents:

  begin
  mail <reply-address>
  send INDEX
  end

Subject: G15) Where can I get online information on UnixWare?


*** COMPUSERVE ***

SCO maintains a UnixWare forum on CompuServe.  If you have a
CompuServe ID and wish to access this form, type:

  GO UNIXWARE

at any CompuServe prompt.  There are message sections for General
Information, Product Information, Developers, DOS Merge, Installation,
X Windows, Networking, Device Drivers, Printing, Communications,
Applications, Bug Watchers, and Updates.

If you do not have a CompuServe ID, contact CompuServe Customer
Service at 800-848-8990 or 614-457-8650 for information on setting up
an account.

*** USENET ***

If you have access to Usenet, look into the newsgroup

news:comp.unix.unixware.misc, comp.unix.unixware.announce.

These forums entertains discussions and announcements of all issues
related to UnixWare.  Other newsgroups possibly of interest to
UnixWare users are

news:comp.unix.sys5.r4

(for discussions relating to the
System V Release 4 version of Unix, which includes Novell's UnixWare)
and

news:comp.unix.misc

(for miscellaneous discussions of Unix).

If you do not have access to Usenet, you have a variety of options.
If you have access to a Unix system, chances are good that it may
already provide Usenet access - particularly if it is at an academic
or research site.  If you do not have access to a Unix system, your
best bet is to get an account with one of the increasing number of
public-access Unix systems being set up by entrepreneurial Unix
sysadmins.  You can find the contact phone numbers for such systems in
any one of the many books on the Internet now beginning to flood the
popular press.

*** MAILING LIST ***

The news:comp.unix.unixware.misc newsgroup is gatewayed into a
mailing list for the benefit of those users with email, but not
Usenet, access.  I quote from Evan Leibovitch's instructions for that
list:

  TO SUBSCRIBE/UNSUBSCRIBE/GET HELP/ETC:
  Send an appropriate message to any *one* of the following addresses,
  each of which is addressed to the list server mechanism at this site
  (listed in order of my preference):

  listproc@telly.on.ca
  univel-request@telly.on.ca
  listserv@telly.on.ca

  The body of your message should contain one of the following lines
  *AS ITS ONLY CONTENT*:

  subscribe univel Your_Full_Name      (Not your e-mail address, the system
                                        will pick that up from the headers.)
  unsubscribe univel
  recipients univel                    (gets a list of subscribers)
  help


*** EMAIL ***

(This section needs  to be reworked.)


*** FTP ***

SCO maintains an official UnixWare FTP site at ftp.sco.com.  To
access this server, you will of course need Internet access.  Type

  ftp ftp.sco.com

At the login prompt, type

  anonymous

When it asks for a password, enter your full email address.
UnixWare 2.x updates and patches can be found in /UW20.


*** WORLD WIDE WEB (WWW) ***

SCO have now taken over the UnixWare WWW site (indeed UnixWare 2.1
will include a copy of Mosaic that defaults to this page)

  http://unixware.sco.com/

(Its not clear if SCO has a European presence for a Web or ftp site).

Via the WWW server at unixware.sco.com, you can submit product inquiries
and technical support queries.
Plus, there's quite a bit of documentation there to be perused.

For the latest UnixWare xmosaic binary to access the WWW server:

  ftp to ftp.abs.net   or ftp.novell.co.uk 
  and look in ~ftp/pub/unixware/freebird/internet/client/mosaic
  for mosaic.pkg.tar.Z.  This can be untarred into /tmp and pkgadded
  to install the Mosaic binary.  It requires Motif 1.2 runtime support;
  standard in UnixWare 1.1.

  Mosaic sources are available from ftp.ncsa.uiuc.edu in ~ftp/Web.

Send comments on the WWW services to webmaster@sco.com

*** GOPHER ***

We've no data on the availability of any gopher servers at the moment.


Subject: G16) Where can I get a hardware compatibility list for UnixWare?


Currently, in the US the UnixWare Compatibility information is available
from Banta by part number 462-000-525-001.  The US number to call is
1-800-346-6855 or 1-801-373-6779.

SCO also has a set of Web pages containing hardware compatibility for
all of SCO's server products.  Certified hardware for UnixWare 2 has been
merged into those pages which can be found at http://www.sco.com/Third/hch.



Subject: G17) Where can I find a driver for [accelerated graphics card]?

Try ftp'ing to ftp.novell.co.uk, and look in the 
/pub/unixware/usle/x11/servers/betaX directory.  Check the 
README file there for a listing of currently available drivers.  
These drivers are updated on a quarterly basis,
and may be newer than those (and/or unavailable) on the latest OS
distribution.

Subject: G18) Is there a UnixWare user's group?

Evan Leibovitch (evan@telly.on.ca) responds:

  Yes! UUX, the UnixWare User Exchange, was founded at UniForum 1994.
  It is still in the formative stages, and is looking for any assistance
  possible from people in the UnixWare user/developer/reseller community.

  The next meeting of the UUX will take place Wednesday, October 5 1994,
  at the Jacob Javits Convention Center in New York City, held
  concurrently with the Unix Expo trade show.

  For more information contact Evan Leibovitch, evan@telly.on.ca or
  (905) 452-0504.

Subject: G19) Does UnixWare support multiprocessing?

Yes, Multiprocessing support is included in release 2.01.

Subject: G20) Does UnixWare function as a NetWare server?

No, not at present.  UnixWare is strictly a NetWare client.  It can,
however, function as an NFS server. UnixWare 2.1 will be able
to function as a NetWare 4.1 server including NDS support (this is
an add-on package to UW2.1).

Subject: G21) What is the future for UnixWare?

SCO plan to merge SCO OpenServer and SCO UnixWare into a product codenamed
"Gemini", which will be  a common UNIX implementation that integrates the best
features from both. This is due in 1997. In the meanwhile SCO plan
to deliver a set of tools to assist developers to migrate. See 
the SCO WWW pages for more information (http://www.sco.com).


