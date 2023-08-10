Newsgroups: comp.unix.unixware.misc
Subject: UnixWare Frequently Asked Questions (Developer)
Supersedes: <Dp4nG6.1qD@tamarix.demon.co.uk>  
Followup-To: comp.unix.unixware.misc
Expires: Wed, 15 May 1996 00:00:00 GMT
Summary: Answers to questions frequently asked about SCO's UnixWare SDK

Archive-name: unix-faq/unixware/developer
Posting-Frequency: monthly
Last-modified: Mar 11, 1996
Version: 2.05

UnixWare Frequently Asked Questions List (Developer)

For more information about the files which compose the total UnixWare FAQ,
see the "FAQ Overview" file posted regularly on the Internet newsgroup
comp.unix.unixware.misc.

This document may be obtained by anonymous ftp from the freebird
archive at
    ftp.abs.net:/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.d
    netlab1.usu.edu:/pub/mirror/freebird/hints/FAQ/comp.unix.unixware.FAQ.d
    ftp.osiris.com:/pub/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.d 

INTRODUCTION

This is the Developer section of the UnixWare Frequently Asked Questions file
maintained on the Internet. Its temporary maintainer is Andrew Josey
(andrew@tamarix.demon.co.uk) - we're presently seeking a new fulltime 
maintainer.  Please note that since the original FAQ was written
that some Novell contact references still need to be updated to
the SCO counterparts and that the information has been requested.

Suggestions and contributions are always welcome.

The Developer section covers aspects of the UnixWare 1.1.x and UnixWare 2.x
SDK.  It also covers general concerns for anyone writing software for the
UnixWare operating system.


TABLE OF CONTENTS

D0) How do I get ahold of UnixWare Developer Support?
D1) What does the UnixWare 1.1 SDK contain?
D2) Is there a C++ compiler for UnixWare 1.1?
D3) What does the UnixWare 2.0 SDK contain?
D4) Where is the ccs package on UnixWare 2.0?
D5) Where is the documentation for the UnixWare SDK?
D6) What books are there on UnixWare programming?
D7) Where are the man pages for the Standard C functions?
D8) Are there alternative SDKs to the UnixWare SDK for developers?
D9) How do I correctly use the UCB compatibility libraries?
D10) In what library is <undefined symbol> defined?
D11) In what library is regex() and regcmp() defined?
D12) In what library is XmbTextListToTextProperty defined?
D13) What libraries do I need to include for X applications?
D14) What libraries do I need to include for socket applications?
D15) How do I compile the sample Motif applications?
D16) Why do I get memory errors while building applications?
D17) I don't like the new Motif look and feel, How do I get the old one?
D18) How come I keep on getting as_dup proc failures?
D19) How do I get the C compiler to accept C++ style comments?
D20) How do I increase the number of socket connections for my application?
D21) How do I run debug on a SUID root program?
D22) Why do I get Driver without "f" flag not supported?
D23) Why can't I get my SUID root program to work?
D24) Why do I get a symbol error in librpcsvc.a on UnixWare 1.1?
D25) How do I get kdb output to go to a tty?
D26) Why do I have this library dtruntime.so.1 on UnixWare 2?
D27) I included all the necessary libraries, why do I still get unresolved 
     symbols?
D28) How come I can't get some Motif keyboard mappings to work?
D29) Why do I get a bad Makefile from xmkmf on UnixWare 2.0?
D30) How do I get cc to place object files in specific directories?
D31) Why does the open() call block when I try opening the serial port device?
D32) How do I compile tin?
D33) How do I compile emacs?
D34) How do I compile Perl 5.001?
D35) Where can I get the GNU debugger (gdb) for UnixWare 2?
D36) How can I debug an application without the source code?
D37) When I link I can 't find the syslog routines, what should I do?
D38) When I link I can 't find the strcasecmp routine?
D39) When I link I can 't find the alloca routine?


D0) How do I get ahold of UnixWare Developer Support?

The SCO Developer programme can be reached on 1-800-SCO-UNIX in North America,
for the UK and International customers call SCO on +44 1923 816344.

As a member of the developer programme you get 5 free technical support
questions among other benefits - see http://www.sco.com/Developers
for info on the Developer programmes.

D1) What does the UnixWare 1.1 SDK contain?

1) C compiler
2) Enhanced Graphical debugger
3) Motif development tools (sorry, no GUI builder).
4) Network client/server developer tools {so what's new :-) }.
5) Online documentation through Fingertip Librarian.
6) Driver development tools including sample driver source.
7) Windowing Korn Shell
8) Software Packaging Tools
9) Kernel Debugger

D2) Is there a C++ compiler for UnixWare 1.1?

(Note the ordering information needs to be updated in the
light of the transfer of the UnixWare business to SCO ,
that information has been requested).

The C++ Compilation System 2.0 for UnixWare 1.1 is available for the
suggested retail price of U.S. $99 in CD ROM and QIC-24 tape formats.
To order in the U.S.  or Canada, call 1-800-457-1767 or fax (317)
364-8888.  Outside North America, call +31-55-384279 or fax
+31-55-434455.

D3) What does the UnixWare 2.0 SDK contain?

1) C++ compiler with templates (C compiler is part of the AS and PE)
2) Enhanced Graphical debugger
3) Motif development tools (sorry, no GUI builder).
4) Network client/server developer tools {so what's new :-) }.
5) Online documentation through Dynatext.
6) Driver development tools including sample driver source.
7) Integrated window development tools
8) Software Packaging Tools
9) Kernel Debugger
10) Enhanced performance tools and profilers
11) Multithreaded application development

D4) Where is the ccs package on UnixWare 2.0?

The ccs package is no longer a part of the UnixWare SDK, but instead has
been included on the UnixWare AS and PE media.  This is to facilitate
support for third- party SDKs and other software such as databases that
need the C compiler present to function.  Even though this does give you
the C compiler, it does not give you all the components of the SDK such
as the debugger, include files, and miscellaneous static libraries.  So
for a full development environment, an SDK is still considered
essential.

Note that you need to install the ccs package from your AS or PE media prior to
installing the SDK, or YOU WILL NOT be able to install the C++ compiler.

D5) Where is the documentation for the UnixWare SDK?

UnixWare 2.01 includes all the UnixWare SDK documentation and provides
it through the online documentation system of UnixWare 2.01.  Printed
versions of the SDK Documentation are available in English only from:

Hart Graphics for the Novell Fulfillment Department
P.O. Box 141805
Austin, TX, USA 78714-9783

Or courier to:

Hart Graphics for the Novell Fulfillment Department
3106 Longhorn Blvd.
Austin, TX, USA 78758

Country        Voice                    FAX
Australia      0014-800-128-411    0014-800-124-233
Canada         1-800-366-3892      1-800-826-5399
Singapore      800-1100-073        800-1100-088
U.S.           1-800-336-3892      1-800-826-5399
All others          U.S. Country Code   U.S. Country Code
               +512/834-6905       +512/834-8901

Group 6   Basic Software Development    US$ 125.00
Group 7   Networking Development   US$  95.00
Group 8   Windowing Development    US$  95.00
Group 9   C++ Development          US$  55.00
Group 10  IHV Development (drivers)     US$ 115.00
Group 11  OSAPI Reference               US$  95.00
Group 12  NetWare Lib. Ref. for C       US$ 125.00
Group 13  Motif Reference Manual        US$  75.00
Group 14  Additional SDK Reference US$  75.00

Note:  These prices do not include Shipping & Handling, or Tax.

D6) What books are there on UnixWare programming?

No UNIX programmer should be caught without the Stevens books:

  Advanced Programming in the UNIX Environment
  W. Richard Stevens
  Addison-Wesley, 1992
  ISBN 0-201-56317-7

  UNIX Network Programming
  W. Richard Stevens
  Prentice Hall, 1990
  ISBN 0-13-949876-1

Donald Lewine's POSIX programming guide is also indispensable as a
reference for "which standard defines what API?" kind of questions:

  POSIX Programmer's Guide
  Donald Lewine
  O'Reilly and Associates, Inc.
  ISBN 0-937175-73-0


D7) Where are the man pages for the Standard C functions?

UnixWare 1.1:

Kevin Brannen (kbrannen@metronet.com) has become UnixWare's "Master of
Man Pages":

First, make sure you've gone thru the "Guide to Fixing Man".  (I've sent
Martin a note asking him to talk to Andrew Josey about putting my "Guide
to Fixing Man" on the mail-server there at novell.co.uk.)

Now do "apropos command" or "man -k command", you should see the
topic to do a man on.  For example, "man strchr" returns:

   No manual entry for strchr.

So do "apropos strchr", which returns:

   string: strcat, strncat, strcmp, strncmp, strcpy,  strncpy, strdup,
   strlen,  strchr, strrchr, strpbrk, strspn, strcspn, strtok,
   strstr (3C) -  string operations

which tells you that you should do "man 3c string".  Famous groupings
that hide a lot of functions but which have no corresponding function are:
string, memory, directory, trig, and exec.


UnixWare 2.0:

I just use the man -k command.


D8) Are there alternative SDKs to the UnixWare SDK for developers?

Yes, there are many options, and the number is increasing.  The first
option developers generally try is using the GNU gcc compiler and other
GNU tools.  The GNU tools are available from several sources.  The first
place to try is ftp.abs.net or any of its mirror sites.  Here you can
get packaged binaries.  The second is to get them from a CD-ROM
distribution such as the Prime Time Freeware Tools and Toys for UnixWare
or the Walnut Creek SVR4 (UnixWare) CD-ROM.  These CDs include many
useful utilities that any developer would find handy.  The third is to
get source from the Free Software Foundation or any of the many CD-ROMs
and build the binaries yourself.

There are many third party compilers available for UnixWare, and if the
vendors contact me I will include them in the FAQ.

D9) How do I correctly use the UCB compatibility libraries?

There are two problems that are typically encountered when
compiling/linking code that uses Berkley-isms:

* Undefined symbols at link time
* Incompatibilities between the SysV header files and the UCB libraries

C code using Berkley-isms such as index/rindex will generate "undefined
symbol" messages for each of the BSD-specific functions.  To get around
this, you have one of two options:

* Option A: Straight UCB compile
   
   Compile with the "UCB" compiler (/usr/ucb/cc).  This is actually a shell
   script wrapper around the standard C compiler (/usr/ccs/bin/cc) that 
   sets up the necessary #include and library paths.  This is the path to
   take if you want a more "pure" BSD environment for your development.

* Option B: SysV compile with Berkeley extensions
   
   If you want a SysV environment, but need to link in some functions
   only available in the BSD library (eg, you'll replace gethostname() with
   uname() later), simply link in the UCB libraries _after_ the standard
   (SysV) libraries.  For example:

     cc -o foo foo.c -lc -L /usr/ucblib -lucb

Note the order of the library specifications, and that "-lc" should
precede the UCB library specification to resolve all possible synonyms
against the SysV library, rather than the BSD library.

Be careful exercising option (b), however.  Merely linking against the
UCB library, without the preceding "-lc", will cause code to be compiled
against the SysV #include files (located in /usr/include) and then
linked against the UCB libraries:

    cc -o foo foo.c -L /usr/ucblib -lucb  # Don't do this

(Note that an implicit "-lc" is appended to the command line.)
Differences in such things as structure sizes between the SysV #includes
and the UCB libraries can wreak all kinds of havoc - as Jim Vlcek
discovered in just this fashion when trying to use setjmp in a source
module that also called some UCB functions.  One way to get around this
is to insert a "-I /usr/ucbinclude" directive into the command line, but
this is essentially the effect of using /usr/ucb/cc.


Gordon W. Ross <gwr@mc.com> wrote:

  I just wanted to mention here that most people I have helped with
  porting problems related to the dirent or directory libraries have
  caused their own problems by incorrectly using the UCB library.
  The directory(3) routines in the UCB library only work with the
  header files in /usr/ucbinclude so if you fail to put that in
  your include path and just link with -lucb you end up with
  seriously broken programs.  The stuff in /usr/ucbinclude/ and
  /usr/ucblib/ was meant to be used by /usr/ucb/cc only, and
  when used that way it (mostly) works.  I have usually found it
  easiest to just stay away from the UCB library entirely.
  I would advise others to do the same.  (The UCB library has
  well known problems in signal and some dbm functions.)

Robert Withrow (witr@rwwa.com) wrote:

  In addition, checking the following things will almost always yield a
  working port for any reasonably `well behaved program':

  1 Replace bcopy et.al with the apropriate memcpy functions...

  #define bcopy(b1,b2,len) memmove((b2), (b1), (size_t)(len))
  #define bzero(b,len) memset((b), 0, (size_t)(len))
  #define bcmp(b1,b2,len) memcmp((b1), (b2), (size_t)(len))

  2 Replace index and rindex approprately:

  #define index(a,b) strchr((a),(b))
  #define rindex(a,b) strrchr((a),(b))

  3 Don't use the SVR4 library's signal() routine,
  [use sigaction instead ...]

  /* Reliable signals */
  /* This was taken from Stevens... */

  #include <signal.h>

  typedef void Sigfunc(int);

  Sigfunc *signal(int signo, Sigfunc *func)
  {
    struct sigaction act, oact;

    act.sa_handler = func;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;
    if (signo != SIGALRM) {
      act.sa_flags |= SA_ESTART;
    }
    if (sigaction(signo, &act, &oact) < 0)
      return(SIG_ERR);
    return(oact.sa_handler);
  }

  4 Replace random with lrand

  #define random() lrand48()
  #define srandom(seed) srand48((seed))

  5 Replace the bsd readdir code with the Posix code (requires changing an
  include file and a declaration usually, but also perhaps a symbol with a 
  strlen.)

  6 Replace wait3 and wait4 with posix wait code.  This is complicated
  because some code *writes* into the values that posix only provides read 
  access to.


Rick Richardson (rick@digibd.com) wrote:

  Its much easier to port stuff than most people think.

  I've found that 99.99% of applications with BSDisms can be ported
  by simply compiling normally, but linking with -lc -lucb.  This
  resolves the SVR4 C library first, avoiding problems with dirent
  and the like, but also lets you pick up any BSD-isms like
  random(), index(), etc.

  Really, its painless.

D10) In what library is <undefined symbol> defined?

The command 'nm' can be used to examine the contents of library files,
or use the following script to automate the process.

--- Cut here and save to "who_defines", then "chmod +x who_defines"---
#!/bin/sh
if [ $# -ne 1 ]
then
        echo "Usage: who_defines function_name" >&2
        exit 1
fi
 
# You may need to add library directories to this list.
 
LIBDIRS="
        /usr/lib
        /usr/ccs/lib
        /usr/X/lib
        /usr/ucblib"
 
for dir in $LIBDIRS
do
        for lib in $dir/*.a $dir/*.so
        do
                if [ -r "$lib" ]
                then 
                        nm -px $lib | sed -n '/T \<'$1'\>/p' 2>/dev/null |
                        while read ans
                        do
                                echo $lib:$ans
                        done
                fi
        done
done
--- End of "who_defines" ---


To determine where a symbol (eg, bind) is defined:

  % who_defines bind
  /usr/lib/libsocket.a:0x000000c0 T bind
  /usr/lib/libsocket.so:0x00008050 T bind

Note that, as above, you will often get multiple answers.  Here, we see
that bind itself is in the socket directory (the .a and .so are the
static and dynamic libraries, respectively).  The library name is the
path that precedes the colon; your ld command line should thus include
the entry:

  -lsocket


D11) In what library is regex() and regcmp() defined?

The functions regex() and regcmp() are located in the general function library
/usr/ccs/lib/libgen.a and can be included by using the option -lgen to cc.

D12) In what library is XmbTextListToTextProperty defined?

This function as well (as the function XmbTextPropertyToTextList()) is
defined in the library /usr/X/lib/libXIM.so on UnixWare 1.1.  This
should not be a problem on UnixWare 2.0.

D13) What libraries do I need to include for X applications?

This is how the sample application periodic was linked:

$ cc -o periodic periodic.o -O -Xa  -T 0x8300000 -L//usr/X/lib
/usr/X/lib/libMrm.so /usr/X/lib/libXm.so -lXt -lXext -lX11  -lgen  -lnsl
-z nodefs


D14) What libraries do I need to include for socket applications?

Socket applications need to include the sockets library and the
networking support library:

$ cc -o foo foo.c -lsocket -lnsl

D15) How do I compile the sample Motif applications?

The simple way to compile one of the sample Motif applications is to
first copy it to some local working directory to avoid permission errors
on the files:

$ cp -r /usr/X/lib/motifdemos/periodic periodic

Then cd into the periodic directory:

$ cd periodic

Run xmkmf to convert the Imakefile into a Makefile (See D29 first):

$ xmkmf
imake -DUseInstalled -I/usr/X/lib/config

Then run make:

$ make
        /bin/rm -f periodic.o
        cc -c -O -Xa -I. -I./X11 -I./X11 -I///usr/X/include -I///usr/X/include/X11
-I/usr/include -I//usr/X/include -I. -DSVR4 -DSYSV386 -DI18N
-DFUNCPROTO=15 -DNARROWPROTO -DLIBDIR=\"/usr/X/lib\"
-DDESTDIR=\"/usr/X\"  periodic.c
        /bin/rm -f periodic
        cc -o periodic periodic.o -O -Xa  -T 0x8300000 -L//usr/X/lib 
/usr/X/lib/libMrm.so /usr/X/lib/libXm.so -lXt -lXext -lX11  -lgen  -lnsl  -z nodefs

Then run:

$ ./periodic

D16) Why do I get memory errors while building applications?

The first potential problem is running into user process limits which
are controlled by the following tunables:.

     SDATLIM
     HDATLIM
     SSTKLIM
     HSTKLIM
     SVMMLIM
     HVMMLIM

These may need to be increased so that enough memory resources are available to
build very large applications.

The second potential problem could be a lack of swap space.  This can be
checked by using the swap command.  Remember that swap is a dynamic
thing so just running the swap command after a failed compile does not
tell the story of what is happening during the compile.  On UnixWare 2,
you can use the real time performance monitor (rtpm) or the GUI System
Monitor to watch what is going on.  More swap can be added by swapping
to a file which should be covered in the administration FAQ.

On UnixWare 2.0, there is also the possibility that you are running out
of /tmp file space since this defaults to a memfs.  Since the compiler
heavily uses /tmp, this filesystem may need to be increased by editing
the /etc/vfstab file entry for /tmp, or not using a memfs for /tmp at
all.

D17) I don't like the new Motif look and feel, How do I get the old
one?

Some developers have expressed the desire to have Motif version 1.2.3
under UnixWare 2.0 have the older look and feel of Motif version 1.2.2. 
Following is a developers note:

> ... the look and feel of the XmToggleButton
> is vastly different under UW 2.0 than those of the standard
> Motif version.  The XmToggleButton in radio mode is a round
> circle instead of the standard diamond shape.  The non-radio
> mode XmToggleButton displays a check mark inside the square
> under UW 2.0.  IMHO this is ugly.

This is the standard look and feel for CDE. Sun, HP, IBM, DEC, Novell,
Fujitsu, Hitachi, and other vendors are or will soon be shipping this
same Motif (same source code). While UnixWare 2.0 does not include the
CDE desktop, it does include the CDE Motif implementation.

Furthermore, this user interface design change was in response to
_significant_ user complaints about the old look. Hundreds of users have
complained that the old visuals were not visibly distinctive, leaving
them unsure which toggles were set and which were not. The new visuals
are decidedly better, in the humble opinion of customers, user interface
designers, and the vendors shipping CDE.

> The question I have is
> WHY OH WHY did Novell do this type of thing?  The Motif look
> and feel is supposed to be standard across all platforms.
> What Novell did to Motif is gratuitous, and a disservice to
> the efforts of a standard.

Nope, just the opposite. We participated in the standards activities
that lead to this change.

In any case, one can get the old look (diamonds, no-checks) by setting
these resources:

*enableToggleVisual: false    # use the diamond/empty-square visuals
*enableToggleColor:  false    # use "select" color, instead of highlight color

This will restore the original, hard-to-distinguish visuals.

The complete set:

*enableToggleVisual:     {true|false}
               # use the diamond/empty-square visuals

*enableToggleColor: {true|false}
               # use "select" color, instead of highlight color for selected toggles

*enableBtn1Transfer:     {button2_transfer|true|false}
               # true == Button 2 is ADJUST, Button 1 is TRANSFER
               # button2_transfer, Button 2 is TRANSFER, Button 1 is drag
and drop

*enableButtonTab:   {true|false}
               # TAB moves among pushbuttons in tab groups, e.g.
Apply/Reset/Cancel

*enableDefaultButton:    {true|false}
               # shows button highlight inside the default-ring on the default
button

*enableDragIcon:    {true|false}
               # uses better default icons (visuals) for drag and drop

*enableEtchedInMenu:     {true|false}
               # shows menu buttons as "pressed in" rather than "pushed out"

*enableMenuInCascade:    {true|false}
               # can use the Button 3 to pull down menus on menu bars

*enableMultiKeyBindings:{true|false}
               # enable use of additional key bindings (e.g. Sun's
Cut/Copy/Paste)

In all cases, a value of "false" gets the original (old) Motif behavior.
For UW 2.0, the default .Xdefaults file gives "true" for all these,
except the third ("button2_transfer").

D18) How come I keep getting as_dup proc failures?

UnixWare 1.1:

These errors are generally caused by memory problems (as opposed to
newproc pid_assign errors, which are generally due to low values of the
NPROC and MAXUP tunables).  These errors could be caused by insufficient
RAM, swap space or by processes which take up too much memory.
Processes which do many time calls may be prone to the localtime memory
leak and might get very large and thus take up a lot of memory.  Also,
processes which do successive mallocs and frees may be prone to a
problem with free (where memory does not get correctly returned to the
system) and may also get very large and use too much memory.

To find whether there are processes running which have grown too large,
enter:

    ls -l /proc

This will list all processes (by pid) and how much memory they take.

Aside from adding more RAM or swap, if there are processes which are
taking up an inordinately large amount of memory, try applying PTF174
(localtime memory leak) and/or PTF161 (problem with free).  These ptf's
contain updates to shared object libraries and thus they should be able
to be applied to the run-time system.  The app should not have to be
re-compiled.

NOTE:  ptf174 is contained in Update 1.1.3.

UnixWare 2.0:

I have never heard of anyone getting this under UnixWare 2.0, but the
same memory problems would be at fault.

D19) How do I get the C compiler to accept C++ style comments?

By supplying the following options on the cc command line, you can get
cc to accept C++ style comments:

     cc -W0,-B foo.c

D20) How do I increase the number of socket connections for my
application?

UnixWare 1.1:

To do this you first must edit the /etc/conf/sdevice.d/sockmod system
file and increase the number in the third field.  Normally this defaults
to 128.  The system maximum for this is about 256 connections due to a
limitation in the library libc.so.  After this value has been increased,
the kernel must be rebuilt and the system rebooted.  Also, the kernel
tunable NUMTIM might need to be increased to allow for the greater
number of streams modules required by the socket interface.  For every
socket connection opened there is an associated file descriptor.  If the
user executes the command 'ulimit -a' he/she will see that this defaults
to 64.  In order to get more than 64 connections the associated tunables
SFNOLIM and HFNOLIM must be increased.  Because of the limitations in
the library libc that were described previously, there isn't much need
to increase this beyond 256.  There is an upper limit to the number of
connections allowed due to kernel memory allocation limitations.  Kernel
memory must exist in the less than 16MB memory range due to
historical/architectural reasons.  This means that the kernel image,
drivers, and kernel buffers (including streams buffers) live in the less
than 16MB memory range.  This creates the limitation on the number of
connections based on how much memory can be acquired to maintain these
connections.  This has implications for machines with less than 16 MB of
RAM, i.e., more RAM may be necessary to increase the number of
connections.  I was successful in getting 197 socket connections, and
had a developer get around 230.

Now with the number of connections increased, if the applications being
run are things such as telnet or ftp, the /etc/inet/inetd.conf
configuration needs to be such that the required number of server
daemons can be  started such as in.telnetd or in.ftpd.

Note: after the initial release of this TID, I have had some developers
in Novell USG state that they believe there should not be a limitation
in the number of connections through libc.  So it may be possible to
increase this to a value greater than 256.

UnixWare 2.0:

There are several causes that lead to not having enough socket connections:

1) The ulimit values may be limiting the number of open files allowed.
2) For UNIX Domain sockets, the third field in
/etc/conf/sdevice.d/ticots is set too low.

3) For Internet Domain sockets, the third field in
/etc/conf/sdevice.d/tcp is set too low.

First, increase the number of open files a process is allowed to have by
tuning the SFNOLIM system tunable.  This can be done using the System
Tuner in the Admin_Tools folder on the desktop.  (This value can also be
increased temporarily by typing "ulimit -n unlimited" as root.)

Second, for UNIX Domain sockets, increase the number in the third field
of /etc/conf/sdevice.d/ticots.  Rebuild this module by typing "idbuild
-M ticots".  For Internet Domain sockets, increase the number in the
third field of /etc/conf/sdevice.d/tcp.  Rebuild this module by typing
"idbuild -M tcp".

Reboot the system.

Note:  For this I increased the values to 1024, there appears to be no
upper limit on how many connections there can be.

D21) How do I run debug on a SUID root program?

When trying to run debug on a setuid program, the following error
message appears:

    System error attempting to control process <pid>
    Create failed: all resulting processes killed

This happens whether debug is run by the program owner (usually root) or
not.  debug cannot be run by someone other than the program owner
(usually root) because then the person running the program could make
modifications to the program which are not explicitly allowed by
setuid.

The graphical version of debug cannot be run by the program owner
(usually root) because this person is generally not the same person
whose desktop debug will try to display on.  By default, X does not
allow one user to display windows on another person's desktop.

To run the graphical version of debug on a setuid program:

    1)  xhost +

(This allows other users to display windows on your desktop).

    2)  su to the person who owns the setuid program.

    3)  run debug on the program.

D22) Why do I get Driver without "f" flag not supported?

This driver probably has a version 0 Master file and does not have an
"f" in the characteristics field (see man (4) Master).  This means that
this driver is not a DDI/DKI compliant driver, and thus will not work on
UnixWare 2.0.

The solution is to modify the driver to be DDI/DKI compliant.  This will
also guarantee that the driver will work on future releases of UnixWare.
Consult the Device Driver Reference Manual (DDI/DKI) in the Dynatext
Browser.  It gives good detail on what is needed to be compliant, what
is supported, and what is not supported.

NOTE:  We stated that UnixWare 1.1 drivers will run on UnixWare 2.0.
The actual situation is that DDI/DKI compliant 1.1 drivers (drivers
written for 1.1) will work on 2.0.  The problem is that 1.1 supported a
lot of older driver interfaces, but this support is not in 2.0.
Developers need to become DDI/DKI compliant.

D23) Why can't I get my SUID root program to work?

The common situation is that a developer has a SUID application (The
effective user ID bit set) for a root owned application and it is unable
to locate dynamic libraries at runtime.  The error would be something
like:

dynamic linker : xapplication : error opening libX11.so
Killed

This is common if the SUID root application is an X application.

This is a deliberate action to prevent a problem with security.  If the
dynamic linker did not cause this to break on SUID programs a potential
security hole would occur.  The security hole would be in the form that
the SUID program would use the LD_LIBRARY_PATH to search for dynamic
libraries needed.  In a SUID program that path must be static.  If the
library were located using the LD_LIBRARY_PATH then a user could
potentially create his own library that mimics a well known library. 
This "imposter" library could have a deliberate security hole in it.
When the application tried to locate a library such as libX11.so and
went to the user's imposter library by using the LD_LIBRARY_PATH, the
security would have been compromised since the application may be owned
by root.

To prevent this security problem, SUID applications must have the path
to all libraries statically included.  To do this the developer needs to
set the LD_RUN_PATH to point to all libraries needed by that application
prior to linking.  By default SUID applications search for libraries in
/usr/lib, but if the application is an X application, all the X
libraries are in /usr/X/lib and these libraries would not be located if
the LD_RUN_PATH environment variable was not set prior to linking.

D24) Why do I get a symbol error in librpcsvc.a on UnixWare 1.1?

This library has a symbol table problem.  When trying to link to the library
librpcsvc.a, the developer gets an error that this library is corrupt.

This library can be fixed by running the 'ar' command on it as root.

# ar -sr /usr/lib/librpcsvc.a

D25) How do I get kdb output to go to a tty?

The kdb command 'newterm' will let you change a kdb session to a tty.
All subsequent kdb sessions will then go to this same tty.  Just make
sure there is a ttymon active on the tty before you do this.

The syntax on UnixWare 2.0 is "newterm <driver> <minor #>", so for
example "newterm iasy 2" will send output to /dev/tty01.  For UnixWare
1.1 the syntax is a little different, but the effect is the same.

Another option which will force all console output to another device is
to edit the /stand/boot file and use the console parameter to indicate
another device.  See the man page for boot(4) for parameter details and
the man page for boot(1) for information on the boot file itself.

D26) Why do I have the library dtruntime.so.1 on UnixWare 2?

Developers have noticed that several of the standard X libraries are
symbolically linked to the library /usr/X/desktop/dtruntime.so.1.  What
is the reasoning behind this?

The reason for this library is as follows:

1)  dtruntime is a library that is the combination of many of the X libraries

2)  This was done to speed up X programs.  It accomplishes this 2 ways:  the
    run-time linker has to do much, much less work at startup to resolve
    symbols and locality tuning is more effective on one large object (as
    opposed to many small ones) since there is a high correlation between
    references to multiple libraries (e.g. Xtfunc always calls Xfunc).

3)  There is no wasted space on a run-time system (a system with no SDK). 
    Simply, many libraries are link-edited to one and links are made to the
    individual names.  On a system with the SDK installed, 3 MB is wasted,
    since we can't link the run-time libraries to the build libraries (i.e. 
    ZZZ.so.1 -> ZZZ.so).

4)  Any programmer who uses the SDK will not see dtruntime unless he/she is
    doing ls's around /usr/X (see #5).

5)  One's binaries still say that the program requires libXt.so.5.0 to run. 
    It just happens to be that on our system, this file is a link to
    dtruntime.

    In fact, we took great effort in not "exposing the implementation"
    so that executables will never be dependent on dtruntime and the ABI 
    is not violated.

6)  Some have commented "what a hack".  
    
    This is, actually, an unhack.  Novell realized that the illusion
    of separate libraries was just that . . . so we put them together.  The
    beauty of the idea is that we can unlink the libraries at any time if
    there was a reason to do so (see #5).

D27) I included all the necessary libraries, why do I still get
unresolved symbols?

Some developers have noticed that while linking an application on
UnixWare with the correct libraries, they still get unresolved symbols. 
The libraries are even verified with the 'nm' command to contain the
needed symbols.

It has been noted that how files are specified on the cc command line
affects what libraries are searched and included.

The following command line will not work:

        $ cc -lsocket -lnsl -lgen -o main.o main.c

Where this one will:

        $ cc -o main.o main.c -lsocket -lnsl -lgen

Note that the libraries must be specified last.  The reason for this is
because the first few options go to the C compiler, where the last
options go to the linker.  Before someone states that this is broke,
this is actually done to be SVID/ABI compliant.

D28) Why can't I get some Motif keyboard mappings to work?

A Developer had an application that remapped keys on the keyboard in the
defaults file located in /usr/X/lib/app-defaults under UnixWare 1.1.3
and it worked fine.  When moved to UnixWare 2.01, the application can no
longer map the keys correctly.

The problem here is that in going from UnixWare 1.x to UnixWare 2.x the
Motif library changed from 1.1 to 1.2.  With this library change, the
concept of Virtual Key bindings was introduced which adds a level of
abstraction between actual Key events and what applications act on.
Client side generated osfXXX key events are then translated to actual
key events at the Server level.

When an application overloads Raw Key events, there's no guarantee that
Motif will not overload those.

In a test program I was able to overload <Key>Home and <Key>End with no
problem but could not overload <Key>Insert.  Changing the <Key>Insert to
<Key>osfInsert worked fine. In general the application should overload
the osfXXX events instead.

The developer needs to modify the translation table to overload
<Key>osfInsert <Key>osfBeginLine and <Key>osfEndLine instead of the
<Key>Insert, <Key>Home and <Key>End translations.

D29) Why do I get a bad Makefile from xmkmf on UnixWare 2.01?

During the building of periodic in the /usr/X/lib/motifdemos/periodic
directory, I get these problems:

$ cd periodic
$ ls -l
total 130
-r--r--r--    1 darrend  other        984 Jun 22 10:50 Imakefile
-r--r--r--    1 darrend  other       1127 Jun 22 10:50 Periodic.ad
-r--r--r--    1 darrend  other      18137 Jun 22 10:50 periodic.c
-r--r--r--    1 darrend  other      35962 Jun 22 10:50 periodic.uil
-r--r--r--    1 darrend  other       7381 Jun 22 10:50 periodic_local.uil
$ xmkmf
imake -DUseInstalled -I/usr/X/lib/config
$ make
        /bin/rm -f periodic.o
        cc -c -O -Xa -I. -I./X11 -I./X11 -I///usr/X/include -I///usr/X/include/X
11 -I/usr/include -I//usr/X/include -I. -DSVR4 -DSYSV386 -DI18N  
-DFUNCPROTO=15
 -DNARROWPROTO -DLIBDIR=\"/usr/X/lib\" -DDESTDIR=\"/usr/X\"  periodic.c
        /bin/rm -f periodic
        cc -o periodic periodic.o -O -Xa  -T 0x8300000 -L//usr/X/lib  ./lib/Mrm/
libMrm.so ./lib/Xm/libXm.so -lXt -lXext -lX11  -lgen  -lnsl  -z nodefs
UX:ld: ERROR: ./lib/Mrm/libMrm.so: fatal error: cannot open file for reading
*** Error code 1 (bu21)
UX:make: ERROR: fatal error.
$

It appears that the Motif templates file in /usr/X/lib/config is
incorrect.  You can get imake or xmkmf to work correctly if you fix the
file /usr/X/lib/config/Motif.tmpl with the following corrections.

Change:
    MTOOLKITSRC = $(LIBSRC)/Xt
     MWIDGETSRC = $(LIBSRC)/Xm
   MRESOURCESRC = $(LIBSRC)/Mrm

To:
    MTOOLKITSRC = /usr/X/lib
     MWIDGETSRC = /usr/X/lib
   MRESOURCESRC = /usr/X/lib

I suggest that you comment out the old lines like this:
/*    MTOOLKITSRC = $(LIBSRC)/Xt */
/*     MWIDGETSRC = $(LIBSRC)/Xm */
/*   MRESOURCESRC = $(LIBSRC)/Mrm */

Note also that you will get a permissions error if you try to build this
application in that directory.  I suggest making a local copy, as root
does not have the necessary environment for building this application
(No X references).

D30) How do I get cc to place object files in specific directories?


Developers using the C compiler cc need to place object files in
specific directories.  Note that this feature is supported by some third
party compilers, e.g.

        $ cc -c darren.c -o /tmp/darren.o

The SVID definition states that the -o option only applies to the
linker.  Since using the -c option means the linker is never called,
this option will not work.

There is a workaround using the -Wa option to the compiler (see the cc
man page.)

        $ cc -c darren.c -Wa,'-o/tmp/darren.o'


Note that I did not put a space after the -o option.

D31) Why does the open() call block when I try opening the serial port
device?

The general symptoms of this problem are:

1) I try to open the serial port device and the open() call blocks.

2) How can I bypass this insistence on having a modem carrier when I am not
talking to a modem?

3) I don't want O_NOBLOCK behavior for my serial device.


One solution involves making a special serial cable as follows:

    You could loop 6, 8 and 20 at the Unix end to assert DCD.


Another solution involves opening the driver non-blocking.  There is an
O_NDELAY flag or an O_NOBLOCK flag to open() which causes the open call
to succeed without waiting for carrier detect to be asserted. If you use
either of these modes,  you can turn off the non blocking behavior,
since this is not the operating mode you may desire for the subsequent
read() and write() calls.

You use fcntl() after open() to turn off O_NDELAY (error checks omitted):

    fd = open ( "/dev/tty01h", O_RDWR | O_NDELAY );
    flags = fcntl ( fd, F_GETFL );
    fcntl ( fd, F_SETFL, flags & ~O_NDELAY );


D32) How do I compile tin?

This should by now be a classic problem in compiling tin under UnixWare
(1.0 at least, I don't know if 1.1 fixed this particular bug).

When you're compiling tin, the make may fail on the first source file
with messages like the following:

"/usr/include/sys/termios.h", line 503: (struct) tag redeclared: winsize
active.c, line 615: warning: argument is incompatible with prototype: arg #4
active.c, line 616: warning: argument is incompatible with prototype: arg #4
make: fatal error.

If this occurs, you've encountered a bug in one of the UnixWare system
header files.  You can do one of two things to compile tin under
UnixWare:

* Fix the header file.  Change all occurrences of

    _IO_PT_PTEM_H

   to

    _IO_PTEM_H

   in the file /usr/include/sys/ptem.h.

<or>

* Hack the tin header file tin.h, which is what I did.  At line 130 in 
   tin.h, you'll find two #include directives, <sys/ptem.h> and 
   <sys/tty.h>.  Place the following #define between these two #includes:

    #define _IO_PTEM_H

This works around the problem with the system header files, if you're
not excited about modifying them (or don't have su privileges).


D33) How do I compile emacs?

The UnixWare cc preprocessor (cc -P) doesn't work the same as
/usr/ccs/bin/cpp from the configure script.  You have three options:

1) Use gcc.  The GNU compiler groks the GNU configure file.

2) Use the UnixWare preprocessor /usr/ccs/bin/cpp directly.

3) Get the emacs binary as indicated in the FAQ.

D34) How do I compile Perl 5.001?

Note that Perl 5.001 source and binaries are now available from ftp.abs.net

tye@fohnix.metronet.com (Tye McQueen) wrote:

   Porting (aka Installing) Perl 5.x to UnixWare systems can be
   confusing, but it need not be difficult.  Here are some notes
   to help you.  I hope to make some of these notes obsolete in a
   future release of Perl and to include the remaining ones in a
   README.svr4 file in that distribution.

   First, be sure you have Perl5.001m or later.  You can fetch a copy
   from:
     ftp://ftp.metronet.com/pub/perl/source/perl5.001m.tar.gz
    or many other places listed in the Perl meta-FAQ, which can be
    found at:
     http://www.khoros.unm.edu/staff/neilb/perl/metaFAQ/metaFAQ.html
    or
     ftp://ftp.khoros.unm.edu/pub/perl/metaFAQ.txt
   I don't recommend trying to apply patches to a Perl5.000 or
   Perl5.001 distribution; just fetch the full latest distribution.

   Next, an easy way to build Perl successfully is simply:

    1.  $ mv -f config.sh config.sh.old
    2.  $ ./Configure -dsE
    3. You can edit config.sh here (but don't do it this first time).
    4.  $ ./Configure -S
    5.  $ env LD_LIBRARY_PATH=`pwd` make
    6.  $ env LD_LIBRARY_PATH=`pwd` make test
    7. Become "root", if you aren't already.
    8.  # env LD_LIBRARY_PATH=`pwd` make install
    9. Answer "yes" that you want /usr/bin/perl set up.

   I say "simply" because this method only asks you one question and I've
   told you what the answer is.  Yes, it is more steps than it should be.

   You might want to save the last two steps until you are sure you
   have everything configured the way you like.  Please don't let the
   "WHOA THERE!!!"s scare you.  They are there for a reason and the
   default answer ("yes") is what you want.

More advanced options

   If you don't like the directories that Configure picks to install
   things into, the simplest change is to add "-Dprefix=/usr/local" on
   the end of Step 2 above (where "/usr/local" is the directory where
   you want "bin/*", "lib/perl5/...", and possibly "man/*/*" to be
   installed).  ./Configure will pick /usr/local if it exists,
   otherwise it will probably pick /opt.

   You can also go back to Step 3 above and change the paths in config.sh
   that you don't like (the Notes section has more hints on doing this).

   There are even more options you can give to Configure to influence
   what directories it picks, but I haven't tested those options so I
   won't go into those switches here.  You can type "./Configure -h" for
   more information on switches that can be given to Configure.

   If you want to use GNU CC to build Perl:

     * Add "-Dcc=gcc" on the end of Step 2 above.
     * Be sure to not use GNU AS, GNU LD, nor GNU LIBC.
     * Make sure you installed GNU CC correctly, including the
       "fix-includes" step.
     * You may be able to use GNU's gdbm to emulate odbm and ndbm for the
       ODBM_File and NDBM_File extensions, but I've seen reports of
       problems (lock ups) with this under Linux.

   I haven't installed gcc so I haven't tested this (these hints come
   from problems others have had using GCC on other systems).

Possible problems

  Building Perl on UnixWare 1.x then running on UnixWare 2.x

   The most serious problem I am aware of is that a Perl executable
   compiled on UnixWare 1.x may run on UnixWare 2.x but it will not
   do I/O correctly.  This is because Perl uses some "officially
   non-standard" optimizations (that happen to port well to a wide
   variety of UNIX systems) in order to get much faster I/O under many
   circumstances.

   If you really want one version of Perl that will run on both UnixWare
   1.x and UnixWare 2.x, then you can disable these optimizations either
   by adding "-Dd_stdiobase=undef" on the end of Step 2 above or by
   going back to Step 3 above and changing d_stdiobase='define' to
   d_stdiobase='undef' then continuing on with the rest of the steps.  I
   have tested both of these methods and am using such a version of Perl
   under both UnixWare 1.1 and UnixWare 2.01.

   If I don't find any problems with it I will update the hints/svr4.sh
   file to do this automatically for UnixWare systems.  I'll also see if
   Novell or SCO will make this version available in "pkgadd" format.

  File glob tests fail due to broken csh in UnixWare 1.1.4.

   I have two reports that the version of csh included with UnixWare 1.1.4
   is broken (which is the version of csh included in PTF2001 which fixes
   memory leaks in csh).  This will cause some of the "file glob" tests to
   fail.

   If this happens to you, you can get around the problem by going back
   to Step 3 above and changing d_csh='define' to d_csh='undef' in
   config.sh then continuing on with the remaining steps.  You might also
   want to check out my File::Glob module which does file globbing inside
   Perl (http://www.metronet.com/~tye/glob.html).

  Easy to break DynaLoader, ODBM_File, and NDBM_File.

   You should be able to include Dynamic Loading along with both the
   ODBM_File and NDBM_File extensions in Perl under SVR4.  It is very easy
   to run into problems using any of these three features under SVR4, but
   if you follow the above instructions, then you shouldn't run into
   these problems.

   You won't get the ODBM_File nor NDBM_File extensions if you haven't
   installed the "BSD Compatibility" package.  This is because the dbm
   routines are kept in /usr/ucblib/libucb.a and the ndbm routines are
   kept in /usr/ucblib/libdbm.a and require /usr/ucblib/libucb.a.

   This stuff is easy to break because all SVR4 systems (except UnixWare
   2.x -- thanks Novell!) have a broken /usr/ucblib/libucb.a which will
   often break programs that try to use it.  The hints/svr4.sh file can
   usually prevent problems by telling Perl to not use most of the
   routines in libucb.a.  The way hints/svr4.sh does this is why Configure
   gives you all of those scary "WHOA THERE!!!" warnings.

   You can use most (on UnixWare 2.x, all) of the BSD-compatibility
   routines, if you want.  I made the defaults to not use any of these
   for several reasons.

     * Prior to UnixWare 2.x, trying to ld with the floating point
       routines from libucb.a (ecvt, gcvt, fcvt, etc.) resulted in
       "undefined symbol" errors.  If using them only in a dynamically
       loaded extension, then these "unresolved external" errors might
       not show up until you tried to use the extension.
     * I worried that there could be SVR4.x systems with versions of
       libucb.a where even more of these routines don't work.
     * I don't believe that they add any functionality over the
       corresponding native SVR4.x routines, even considering how Perl
       knows how to use them.  If anyone finds otherwise, please let us or
       me know so that Perl can be fixed to use the SVR4.x routines more
       effectively.
     * I worry that they add some overhead, though probably not a great
       amount.

Notes

  Changing where Perl will be installed

   Don't worry too much about all the stuff in config.sh that may not
   make sense to you.  You can just change the first part of any absolute
   paths (those that start with "/") that appear between single quotes
   (') after an equal sign (=).  But don't change any of these "paths"
   that point to files that already exist on your system (ie. only change
   ones that point either to directories or to places that don't exist
   yet).  Save a copy of config.sh before you edit it in case you change
   your mind.


Subject D35) Where can I get audio software for UnixWare ?

Voxware driver support for UnixWare 1.x and 2.x can
be found on ftp.abs.net:/unixware/freebird/sound.


Subject D36) Where can I get the GNU debugger (gdb) for UnixWare 2?

This can be found in the developer section of the usle
archive. Check ftp.abs.net:/unixware/freebird


Subject: D37) How can I debug an application without the source code?

Peter Lord writes:
 
If you are a developer working on a new software product, then debugging
an application is fairly straight forward. But what can you do if you
are an end user and don't have access to the source code?

You may come across this problem when trying to run an application
designed for a different operating system on UnixWare.

Truss

Truss(1) is a wonderful program designed for debugging BINARY programs.
It takes control of the process you are interested and prints out all
the system calls your program makes!

For example, if you tried to run the SCO version of Framemaker 3.1X on
UnixWare, you will find it fails without any sensible error message. By
trussing the Framemaker binaries, you can find out if any of the system
calls are failing. In this example, it was easy to find out that
Framemaker was trying to run a program from the bin.i386 directory ...
but only a bin.scounix directory existed. A simple symbolic link brought
the application into life!

Lets take a simple example. 

$ ls /fred
UX:ls: ERROR: Cannot access /fred: No such file or directory
$

In this case we get a error message which can be understood ... but this
may not always be the case. Now, if we truss this same command we get :-

$ truss -o/tmp/trussout ls /fred
UX:ls: ERROR: Cannot access /fred: No such file or directory
$

and the file /tmp/trussout contains :- 

...
lxstat(2, "/fred", 0x08047520)                  Err#2  ENOENT
...
write(2, " U X : l s :  ", 7)                   = 7
write(2, " E R R O R", 5)                       = 5
write(2, " :  ", 2)                             = 2
write(2, " C a n n o t   a c c e s".., 47)      = 47
_exit(2)

Here you can see that ls has made a system call lxstat which returns an
error.

So you can see that although truss cannot follow all of the program, it
can print out the system calls and so give you some clues to where your
program is failing.

One useful truss option is -t. This allows tracing of certain system
calls only (and thus reducing the amount of output you need to scan
through). See the truss manual page for more options.

Truss can even follow processes which are currently running! For
example, if you want to debug your running lockd daemon, use ps to find
out it's process id and then use the command truss -p pid. 

Subject: D37) When I link I can 't find the syslog routines, what should I do?

You need to include libgen. Add -lgen to your link line.

Subject: D38) When I link I can 't find the strcasecmp routine?

You need to link to the ucblib library. This has to be done
as follows:
	-lc -L/usr/ucblib -lucb

Subject: D39) When I link I can 't find the alloca routine?

See D38 above.

Acknowledgements   
---------------

Special thanks to Darren R. Davis and the Novell UnixWare
Developer Support team for getting this FAQ going and to
those folks who've made suggestions and contributions either
directly or via the netnews.


