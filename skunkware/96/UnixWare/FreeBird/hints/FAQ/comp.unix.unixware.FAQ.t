Newsgroups: comp.unix.unixware.misc,comp.answers,news.answers
Subject: UnixWare Frequently Asked Questions (Miscellaneous Troubleshooting)
Followup-To: comp.unix.unixware.misc
Supersedes: <Dp4n0H.1AM@tamarix.demon.co.uk>
Expires: Wed, 15 May 1996 00:00:00 GMT
Summary: Answers to questions frequently asked about SCO's UnixWare product
Approved: news-answers-request@MIT.EDU

Archive-name: unix-faq/unixware/trouble
Posting-Frequency: monthly
Last-modified: Apr 14 1996
Version: 2.08

UnixWare Frequently Asked Questions List (Miscellaneous Troubleshooting )

For more information about the files which compose the total UnixWare
FAQ, see the "FAQ Overview" file posted regularly on the Internet newsgroup
comp.unix.unixware.misc.
                                          
INTRODUCTION

The purpose of this document is to provide miscellaneous hints and
troubleshooting tips for UnixWare 2.x, for information that does
not seem to fit elsewhere in the FAQs.

Some of the installation information is extracted from the UnixWare 2
Installation Handbook - please consult that for further information.
For information on invoking the DCU - see the Autoconfiguration FAQ.
Much information has been gathered from the netnews, some
from the World Wide Web Technical support databases, see the 
acknowledgements section.

Its maintainer is Andrew Josey (andrew@tamarix.demon.co.uk). 
Suggestions and contributions welcome.

This document may be obtained by anonymous ftp from the freebird
archive at
    ftp.abs.net:/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.t
    netlab1.usu.edu:/pub/mirror/freebird/hints/FAQ/comp.unix.unixware.FAQ.t
    ftp.osiris.com:/pub/unixware/freebird/hints/FAQ/comp.unix.unixware.FAQ.t  

Small print: This file is freely copyable. Many proper names of
companies and software mentioned in these files are trademarks
of their respective owners.  All views are those of the
individual contributors and not of their employers.


TABLE OF CONTENTS

Installation Troubleshooting:

T0) How do i find out hardware compatibility, ie. does UnixWare support
  my hardware?
T1) How do i find out whether  UnixWare supports my Host Bus Adapter (hba)
T1.1) Installation fails intermittently on my Adaptec 1542B, what should I do?
T1.2) My system automatically detects two Adaptec 2940 PCI SCSI
     controllers when I only have one, what should I do? 
T1.3) The system does not recognise my Adaptec 1542CP, what should I do?
T2) What to do if the Booting UnixWare Message is not displayed
T3) What to do if the system Panics or Resets While Booting from 
    the Install Diskette, for example on an IBM Thinkpad 755CX.
T4) Your PCI system hangs or panics during installation
T5) The system hangs on a reboot.
T6) You've installed a new kernel and it fails to boot.
T7) What to do if your Resource Manager Database gets Corrupted
T8) Your machine has the Power Saver Option Enabled
T9) UnixWare does not see the additional 16 MB added to my machine with the 
   existing 16 MB, what should I do?
T10) Is there support for IDE/ ATAPI CD-ROM drives? And which drives
    are supported?
T11) Installing Windows 95 on the same disk as a UnixWare partition
    overwrites the boot loader. What can I do?


Desktop and X Troubleshooting:

T12) Desktop tools stop working .
T13) Desktop tools stop working when using a monochrome vga monitor
T14) How do I configure Mosaic to change its Home page and 
    foreground/background colours?
T15) Where can I find  a driver for my SVGA card ?
T16) How do I change from a 2 button to 3 button mouse?

Comms Troubleshooting:

T17) How to update the default modem speed from 38.4 to 115.2
T18) How to setup  UUCP over TCP/IP between two UnixWare machines
T19) How to setup  UUCP over TCP/IP between UnixWare  and
   another O/S running UUCP.
T20) How do I get my serial communications working?
T21) In UW1.x in order to use the 16550 UART chips in my serial card,
    I needed to use the asyhp driver. Is this still necessary in UW2?
T22) How can I debug outgoing modem connections?
T23) How can I quickly setup outgoing uucp?
T24) How can I access a Comms port from DOS running under UnixWare?

General Troubleshooting:

T25) Where do I find updates and patches for UnixWare 2?
T26) How can I set the machine to auto reboot on a panic ?

Laptop Troubleshooting:

T27)  Are there any pitfalls when installing UnixWare on a laptop 
   with PCMCIA support?

NetWare connectivity:

T28) Are there any problem in getting UnixWare/NetWare connections
    up and running?

Pkginstall problems:

T29) When installing the 2.02 update, an error appearead about
    a bad entry on the contents file - how can this be fixed?
T30) How do I install the *.pkg.tar.Z files from the USLE archive?

Networking problems:

T31) How do I configure support for WWW virtual hosts, so that
one machine can have several IP addresses?
T32) How do I setup the NFS automounter?
T33) How do I change the IP address and name of a UnixWare box?

Miscellaneous Other problems:

T34) How can I read the size of installed memory in a UnixWare system?
T35) I have UnixWare 2.03 and have problems reading multiple files
    from floppy (the machine has 32MB of RAM).
T36) How do I found out the number of max processes a UnixWare machine
    is set for?
T37) I've lost the root password, what do I do now?
T38) How to recover with an Emergency boot?
T39) Where are the system messages and log files on UnixWare?
-------------------------------------------------------------------
Subject: T0) How do i find out hardware compatibility, ie. does UnixWare support
  my hardware?


Currently, in the US the UnixWare Compatibility information is available
from Banta by part number 462-000-525-001.  The US number to call is
1-800-346-6855 or 1-801-373-6779.

SCO also has a set of Web pages containing hardware compatibility for 
all of SCO's server products.  Certified hardware for UnixWare 2 has been 
merged into those pages which can be found at http://www.sco.com/Third/hch.
                                                           

Subject: T1) How do i find out whether  UnixWare supports my Host Bus 
        Adapter (hba)

UnixWare2 supports a selection of HBA's on the boot disk
and a separate HBA disk. This section describes the support
for UnixWare 2.01 and UnixWare 2.02/2.03.

The UnixWare 2.03 HBA diskette is available from:
ftp.sco.com:/UW20, or ftp.abs.net:/unixware/Patches2
A dd image is also on:
ftp.novell.co.uk:/pub/unixware/usle/updates/hba203.dd

Due to problems with the 2.03 README file, the changes in 2.03
are not fully described here but the 2.02 HBA set is, one change
that is known is the addition of support IDE CDROM support (see
later in this Install section).

Section A: UnixWare 2.01 HBA Support (see later for 2.02 HBA)

Some 2.x drivers will automatically detect the interrupt, I/O
port, memory address and DMA channel.  When this applies to the
driver, "auto" will be listed under "Irq/IO/Mem".  Other UnixWare
2.x drivers require that you use DCU (Device Configuration
Utility) to configure the driver or set the scsi controller to
the predetermined interrupt, I/O port, and/or memory address
before installation.  Using DCU, these can all be changed after
the UnixWare installation.

SCSI Adapter     Bus Type  Driver  Irq/IO/Mem    Driver available from:
============     ========  ======  ========== ======================
------- Adaptec, Inc. -------  Phone: 800-959-7274
1505/1515 - These cards use a variation of the 6360 chipset and
are defined by Adaptec as VERY low end cards.  They will support
DOS and Windows only.  The Installation Handbook incorrectly
lists the AHA-1505 as supported by the adss driver.  There is no
AHA-1505, only the ADA-1505.

1510, 1512         ISA      adss   10/340/DC000  2.0.1 hba disk, Adaptec
(This card has no bios and therefore cannot be used for a
primary hard drive)

1520, 1522 /A      ISA      adss   10/340/DC000  2.0.1 hba disk, Adaptec
(**chipset: 6x60)

1540, 1542 /B/C/CF ISA      adsc   11/330/DC000  boot disk or Adaptec

1640               MCA      adsc   11/330/DC000  boot disk or Adaptec

1740, 1742 /A      EISA     adse   auto          2.0.1 hba disk

(In standard mode this card emulates a 154x and uses the adsc
driver.)

2740, 2742 /T      EISA     adsa   auto          2.0.1 hba disk, Adaptec

(**chipset: 7770)

(Due to problems with the second channel on the 2740-T/2742-T,
this card is supported by Novell when only the first channel is
used.  The 2740-W/2742-W is supported by Adaptec.)

2840, 2842         VLB      adsa              ***2.0.1 hba disk, Adaptec 

(**chipset: 7770.  If you do not have the 2.0.1 hba
diskette, you MUST contact Adaptec for a driver.  SEE THE NOTE
(***) BELOW FOR INSTRUCTIONS ON SETTING UP THE adsa DRIVER FOR
THE 2840/42 CONTROLLER.)

2940, 2942, 3940   PCI             auto          2.0.2 hba disk

(**chipset: 7870)

chipset 7850                       auto          2.0.2 hba disk

3985 RAID Adapter  PCI  

Adaptec has a NetWare driver for this card, but UnixWare support
has not been released as of this date.  Please call Adaptec for
the latest information on a driver for this card.

------- AMD -------
Am53c974 PCscsi, Am79c974 PCnet-scsi

                            PCI              auto      2.0.2 hba disk

------- AT&T -------
WGS Adapter        ISA     wd7000  15/350/CE000  boot disk

(manufactured by Western Digital) see Symbios Logic below

------- Bus Logic -------  Phone: 408-492-9090
BT-946C, 956C/CD   PCI      blc    auto          2.0.1 hba disk
(The 956C/CD is supported by Bus Logic.)

BT-440C, 445C/S    VLB      blc    11            2.0.1 hba disk
(The 440C and 445C are supported by Bus Logic.)

BT-742A, 746C, 747C/S/D, 757C/CD/S/D

                   EISA            auto          2.0.1 hba disk
(The 746C, 747C, and 757C/CD are supported by Bus Logic.)

BT-540CF, 542B/D, 545C/S

                   ISA             11/330/DC000  2.0.1 hba disk

(The 540CF and 545C are supported by Bus Logic.)

BT-640A, 646S/D    MCA             auto          2.0.1 hba disk

------- Compaq Computer Corporation -------
32-Bit FAST SCSI-2 EISA     cpqsc  auto          2.0.1 hba disk

(This driver will NOT work with the integrated SCSI-2 PCI
controller)

IDA, IDA-2, IDAE (Expansion System), SMART SCSI Array
                            EISA     ida        auto          2.0.1 hba disk

------- DAC (Mylex) -------
Dac960 (2 channel, 3 channel, and 5 channel)
                            dak    auto          2.0.1 hba disk

------- Distributed Processing Technology -------
DPT-2011/95, 2021/95
                   ISA      dpt    15/170/C8000  boot disk

DPT-2012A/95, 2012B/B2/95, PM2022/95, PM2122A/95X
                            EISA     dpt    auto          boot disk 

DPT-2322                    dpt    15


------- Future Domain Corporation -------
TMC 850IBM/M/MEX/MER, IC-9C50
                            ISA      fdeb    5/0/CA000    2.0.1 hba disk

TMC 1650/1670, 1660/1680, 1610MER/MEX/M, 3260, IC-18C30,
IC-18C50, IC-36C70, MCS 600/700, 

                   ISA/EISA fdsb   11/140        2.0.1 hba disk

(EISA controllers will auto configure the fdsb driver.)


------- Hewlet Packard -------
Vectra and possibly others.  See AMD.

------- IBM -------
MCIS-1015, 1018    MCA      mcis   auto          2.0.1 hba disk

IBM 16-Bit AT Fast SCSI-2 Adapter

                   ISA      fdsb    5            2.0.1 hba disk

------- Mylex -------
see DAC above

------- NCR -------
see Symbios Logic below

------- Olivetti -------
EFP2 SCSI                   efp2   auto          2.0.1 hba disk


------- Symbios Logic -------
53c8xx chipset, 8xxxx host adapter boards

(See the 2.02/2.03 HBA for support for the Symbios Logic (formely NCR or 
AT&T-GIS) 53c8xx chipset and/or Symbios Logic 8xxxx host adapter boards.  
The driver will not load on Compaq platforms or integrated 53c8xx's on 
Compaq 53c8xx EISA/PCI host bus adapter boards in a Compaq platform.
See the seperate 2.02/2.03 driver for 53c8xx support for Compaq
platforms.)

------- Tricord -------
PowerFrame                  iiop   auto          2.0.1 hba disk

------- UltraStor -------
UltraStor has not made any drivers available for 2.x at this time.


------- Western Digital -------
7000               ISA      wd7000 15/350/CE000  boot disk


**      Problems arise in a some cases when scsi chipsets have been
placed directly on the motherboard or on a 3rd party controller.
Often the controller is not given the full functionality the
chipset was intended to  have.


***     The adsa driver will not auto configure with the Adaptec
2840/42 controller.  The fundamental problem is that the VLB
(Vesa Local Bus) can't tell the system what kind of slots or
cards they have.  As it happens, the adsa driver (for the Adaptec
7770 chip) is mainly targeted for the 2740 card, an EISA device. 

        To make the adsa driver work with the 2840/42 controller,
enter the DCU when prompted after loading the HBA diskette.  (If
you are not installing, you will not be prompted to enter the
DCU).  Go to "Software Drivers", and "Host Bus Adapters".  Move
the cursor to the "adsa" entry (note that the AHA-2842 is not
mentioned, but this is the right driver nevertheless).  Hit 
for "new".  Change the ITYPE field from 4 to 3.  Change the
interrupt number to match the value the card is set to.  Hit
 to save and exit, and then exit out from the DCU, saving
your changes.

        This procedure can be repeated if a second 284x is to be used
during the installation.  In other words, hit  again for the
second card.

Section B: : HBA202 - UnixWare 2.02/2.03 HBA drivers

The 2.02/2.03 HBA package contains new drivers as well as all
maintenance, enhancements, and fixes for  UnixWare 2.01 HBA
drivers.

*  Highlights

The following is a list of new and enhanced drivers which
are included in this package:

          - fdeb - Future Domain HBA Driver

          - fdsb - Future Domain HBA Driver

          - wd7000 - Western Digital HBA Driver

          - zl5380 - Media Vision HBA Driver

          - amd - Advanced Micro Devices HBA Driver

          - blc - Bus Logic HBA Driver

          - c8xx - Symbios Logic HBA Driver

          - dpt - DPT HBA Driver

          - adsl - Adaptec HBA Driver

          - ida - COMPAQ HBA Driver

          - cpqsc - COMPAQ HBA driver


*  Features

The following HBAs are new or enhanced for 2.02/2.03:

-  Future Domain HBA Driver fdeb

The fdeb driver provided by this package has enhanced
direct  access to the SCSI peripherals (pass-thru) and extended 
read/write support.

The default UnixWare configuration is interrupt 5 and
memory address CA000-CBFFF.

-  Future Domain HBA Driver fdsb

Enhanced direct access to the SCSI peripherals (pass-thru)
and extended read/write support are provide in fdsb in
this package. Also, support for the Future Domain PNP-1630
adapter has been added to the driver.

The default UnixWare configuration is interrupt 11 and I/O
address 140-14F.

- Western Digital HBA Driver wd7000

Enhanced direct access (pass-thru) ioctl support is 
available in this release of the driver.

The default UnixWare configuration is interrupt 15, I/O
address 350-357, and memory address CE000-CFFFF.

-  Media Vision HBA Driver zl5380

Support for the Media Vision Pro Audio Spectrum 16 adapter
is provided in the this package. Note that this support is
SCSI only, and that support for audio on this adapter
is not provided.

The default UnixWare configuration is interrupt 10 and I/O
address 388-38B. Interrupt and I/O settings should be
verified using the Quick Start program provided with the
controller (runs under DOS).

-  New Advanced Micro Devices HBA driver amd

The new amd HBA driver is provided in this update.  This
driver supports the following adapters:

            Am53C974 PCscsi
            Am79C974 PCnet-scsi.

Tagged command queuing is supported, and the UnixWare
auto- configuration utility is responsible for configuring the
adapter for use with the system.

-  Bus Logic HBA Driver blc

blc has been modified to support the following adapters:

            BT-956C
            BT-956CD
            BT-7942 (RAID)

These adapters and the blc driver support "WIDE SCSI,"
tagged command queuing (if enabled), and  hot insert.  The
UnixWare auto-configuration utility is responsible for
configuring the adapter for use with the system.

-  Symbios Logic HBA driver c8xx

The 2.02/2.03 HBA package provides the Symbios Logic HBA c8xx.
This driver supports the following PCI to SCSI adapters
and controllers:

            Symbios Logic 8100S (adapter)
            Symbios Logic 8251S (adapter)
            Symbios Logic 53c810 (controller)
            Symbios Logic 53c820 (controller)
            Symbios Logic 53c825 (controller)
            Symbios Logic 53c815 (controller)

Tagged command queuing, WIDE SCSI and hot insert are supported.

The UnixWare auto-configuration utility is responsible for
configuring the adapter for use with the system. The
driver will support the Symbios Logic (NCR Microelectronics)
53c8xx family. The driver will NOT load on COMPAQ Computer
Corporation's 53c8xx host adapters in COMPAQ machines. The
user must use the update cpqsc driver for the 53c8xx in
COMPAQ machines.

-  DPT HBA driver dpt

The dpt driver has been enhanced to support WIDE SCSI, hot
insertion/removal and EATA direct access to the SCSI peripherals
(pass-thru). The Storage Manager utility is   supplied by DPT directly.
You can monitor the the controller and target devices via the Storage
Manager, in addition to performing diagnostic and maintenance tasks.
Tagged command queuing is still supported by the controller
firmware without driver intervention.

EISA and PCI versions of the DPT controllers are completely
auto-configured and require no special configuration. ISA
versions of the DPT controllers need to be configured as
follows: I/O Address - 170 (also called "secondary"),
Interrupt 15 and the controller BIOS can be configured at
any non-conflicting address.

-  The New Adaptec HBA Driver adsl

adsl supports the following adapters:

            AHA-2940
            AHA-2940W
            AHA-3940
            AHA-3944
            AIC-7870
            AIC-7850

WIDE SCSI peripherals may be used with the AHA-2940W
adapter.

The UnixWare auto-configuration utility is responsible for
configuring the adapter for use with the        system.

-  COMPAQ HBA Driver ida

ida has been modified as follows:

          - support for more than seven disks
          - support for WIDE SCSI
          - corrected interaction with CIM agents
          - corrected operation of ida controllers with IDE
            compatible interfaces

The UnixWare auto-configuration utility is responsible for
configuring the adapter for use with the        system.

-  COMPAQ cpqsc HBA Driver cpqsc

The COMPAQ cpqsc HBA driver is updated in this release.  The
driver supports the following:

COMPAQ Integrated 32-bit
COMPAQ Integrated 32-bit Fast-SCSI-2 (CPQ4410)
COMPAQ 32-bit Fast-SCSI-2 (CPQ4411)
COMPAQ Integrated 32-bit Fast-SCSI-2/E (CPQ4430)
COMPAQ 32-bit Fast-SCSI-2/E (CPQ4431)
COMPAQ Integrated 32-bit Fast-SCSI-2/P (Symbios Logic 53C810)
COMPAQ 32-bit Fast-SCSI-2/P (Symbios Logic 53C825)

Support for WIDE  SCSI peripherals, tagged command queuing,
and hot insertion has been added.

The driver will support COMPAQS Fast-SCSI-2 family of
controllers.  The driver  will NOT support the Symbios
Logic (NCR Microelectronics) c8xx host adapters.

Subject: T1.1) Installation fails intermittently on my Adaptec 1542B, what 
  should I do?

Check the jumpers for the speed setting. Some cards will fail to install
when the DMA transfer rate is set too high, say 8MB/sec. Change
this to 5MB/sec and retry, this is typically removing jumpers 12 and 13
from block J5.

Subject: T1.2) My system automatically detects two Adaptec 2940 PCI SCSI
controllers when I only have one, what should I do? 

This is a well-known problem that affects some, but not all PCI
motherboards. Obtain tf2069.tar (note that some of
the other tf2069 files on the ftp site are corrupt, so get this
larger file) to extract a new boot floppy for the 
AS as well as the PE.  (NB, you still need the original install 
floppy 1 in order to license your installation -- see release notes of 
ptf2069 for more detail.)

Subject: T1.3) The system does not recognise my Adaptec 1542CP, 
   what should I do?

I ordered an Adaptec 1542CF and got (instead) 1542CP.  I have tried
a first time installation of Unixware and can't succeed.  DCU shows
one device as UNKNOWN at the bottom of the list with parameters which
can't be changed (as far as I can tell), and don't appear to match
my board.  Can I use the Adaptec 1542CP (the "P" is for plug and play)?

The solution is to disable the Plug & Play feature in the 
Adaptec 1542CP's BIOS. Use IRQ 11 & 330 as the port address (as noted 
above for the 1542C).

Subject: T2) What to do if the Booting UnixWare Message is not displayed

Check whether the boot disk drive contains a diskette. If so,
remove the diskette and reboot your system. Otherwise, you may have a
system hardware problem. See the documentation provided with your
hardware. Many add-on devices and cards come with configuration
utilities. Check all the  connections and run the configuration
utilities.

Subject: T3) What to do if the system Panics or Resets While Booting from 
    the Install Diskette - for example on an IBM Thinkpad 755CX

Problem. After booting your system with the Install Diskette, the UnixWare 
logo screen is displayed and then the system either displays a panic message or 
resets (the system FIRMWARE messages are displayed again).


You can either try an alternate boot diskette from
ftp.sco.com:/UW20/tf2069.tar 
This is known to work when installing on an IBM Thinkpad 755CX.

If you still have a problem read on.


This problem is typically the result of not running a hardware 
configuration program, such as the ECU or the CMOS setup program, before 
installing UnixWare. To fix the problem, run all machine and peripheral 
hardware setup programs provided by your hardware vendor and verify that 
your hardware is correctly configured. In particular, check your memory 
size/control, cache control, bus speed, and video specifications. See your 
hardware documentation for details.

For example, this problem may occur if the correct amount of memory is not 
configured. (To determine the amount of memory on your system, either check 
your hardware documentation or CMOS settings.) 

If running hardware setup programs does not solve the problem, then there 
may be a memory problem. You can try to manually set the amount of memory 
on your system as follows

1.	Reboot your system.

2.	When the Booting UnixWare... prompt or the Novell logo is 
displayed, press the <SpaceBar>.

The interactive boot session prompt, [boot]#, is displayed. 

3.	Set the MEMRANGE parameter by typing

MEMRANGE=0-640K:256,1M-nM:16896

GO

where, n is the amount of available contiguous RAM in megabytes.

4.	Continue the installation of your system until you are
asked to reboot the system.

5.	When prompted to reboot your system, invoke a UnixWare shell by 
typing

<Alt>-<SysRq>-<H>

The VT0> prompt is displayed.

6.	Update the /stand/boot file by typing

echo "MEMRANGE=0-640K:256,1M-nM:16896" \

>> /stand/boot

7.	Type

<Alt>-<SysRq>-<F1>

8.	Continue the installation .



Subject: T4)Your PCI system hangs or panics during installation

Solution. UnixWare supports installation on PCI systems that are compliant 
with the PCI 2.0 specification. If your PCI system is not compliant with these 
specifications, then do the following to boot UnixWare:

Automatic detection of PCI peripherals is disabled if you follow this 
procedure. 

1.Press reset (or power the computer off, then on again if you do not have 
a reset button).

2. Wait for the Booting UnixWare... prompt; then press the 
<SpaceBar> key to begin an interactive boot session. 

3.	When the [boot]# prompt is displayed, type

PCISCAN=NO

go

4.	Continue installation until you are prompted to reboot your  system.

5.When prompted to reboot your system, invoke a UnixWare shell by typing

<Alt>-<SysRq>-<H>

The VT0> prompt is displayed.

6.	Update the /stand/boot file by typing

echo "PCISCAN=NO" >> /stand/boot

7.	Type

<Alt>-<SysRq>-<F1>

8.	Continue the installation.

Subject: T5) The system hangs on a reboot.

- If your computer has a hard disk drive greater than one gigabyte and you 
have an Adaptec 1542 SCSI controller with extended translation enabled, 
disable the extended translation.

- If your computer already had an operating system (for example, OS/2) 
before installing UnixWare, it may have a "boot code" on the hard disk 
which is incompatible with UnixWare. If this is the case, UnixWare will 
not boot and you may receive a message such as Cannot Load User 
Driver or No Active Partition Found.

You should obtain the osbs from ftp.abs.net:/unixware/freebird/bootselector.


Subject: T6) You've installed a new kernel and it fails to boot.

You can restore the old UnixWare system as follows:

1.Press reset

2.Wait for the Booting UnixWare... prompt; then press the 
<SpaceBar> key to begin an interactive boot session. 

3.When the [boot]# prompt is displayed, type

KERNEL=unix.old

go

Subject: T7)  What to do if your Resource Manager Database gets Corrupted

Problem. The system will not boot and an error message indicates that the 
resource manager database, /stand/resmgr, is either corrupted or missing.

Solution. Reboot UnixWare. Press <SpaceBar> when the Booting 
UnixWare... prompt is displayed. The interactive boot session prompt, 
[boot]#, is then displayed. Type

RESMGR=resmgr.sav

GO

This loads a backup copy of the resource manager database. You system should 
then reboot.

When the system comes up you may want to invoke the DCU to verify that
all device  driver parameters are set correctly. A corrupted or missing
resource manager database  is normally the result of improper changes
made when adding/modifying hardware  parameters.

Subject: T8) Your machine has the Power Saver Option Enabled

Problem. Installation fails at random points after the hard disk is  set
up (or the  message WARNING: Disk Driver Request Timed Out,  Resetting
Controller is displayed after a successful installation) on  systems
with the "Power Saver" option (also referred to as "Power  Management"
or "Green PC") enabled.

Solution. Turn off the "green/energy star" power saving time outs in the 
system BIOS. (Refer to the hardware manual for details.)

Subject: T9) UnixWare does not see the additional 16 MB added 
 to my machine with the existing 16 MB, what should I do?

If it's an ESIA machine it's very important the the EISA config is run
correctly.
And then there is page 132 of the Installation Handbook.
        "Create a /stand/boot file with the following entry:
        MEMRANGE=0-640K:256,1M-16M:512,16M-nnM:8704
        where nn equals the actual amount of RAM memory, in megabytes.
        see boot(4)"

Subject: T10 )Is there support for  IDE/ ATAPI CD-ROM drives?

You need either hba203.tar or tf2197.tar
These can be obtained from ftp.sco.com:/UW20

tf2197.tar: 102400 bytes
TF2197 - IDE Host Bus Adapter Driver -- 11-15-95/20:12p
PTF2197 provides UnixWare 2.01 with support for the IDE HBA
driver for use with ATAPI CD-ROM devices.   

The following ATAPI CD-ROMs have been tested (other drives
may or may not work):

   Mitsumi ATAPI CD-ROMs with firmware of BB03, BE01L, BB04, and BS01.
   Toshiba ATAPI CD-ROM XM-5302 with firmware of TA1095.
   Sony ATAPI CD-ROM CDU76E-S with firmware of 1.0C. 

If you are installing afresh:

(1) Boot off the UW2.01 boot floppy

(2) When prompted install 2.03 HBA disk

(3) Enter DCU

        Software Drivers
        Host Bus Adaptors

        Deselect all but the ide driver

        Select F5 for new

The primary PCI IDE controller, if used,
should be configured with:   


   IRQ      14
   IOStart  1F0
   IOEnd    1FF
   MemStart 10000   (THE DEFAULT VALUES) 
   MemEnd   10001


        Select F5 for new

The secondary PCI IDE controller, if used, should be configured with:

   IRQ      15
   IOStart  170
   IOEnd    17F
   MemStart 0
   MemEnd   0

NOTE on MemStart and MemEnd values:  
-------------------------------------
Kevin Bulgrien reports:
I have a DTC-2280 controller and a Mitsumi FX400 drive.
Are the values for MemStart and MemEnd supposed to be zero?  In my many attempts
to load TF2197, I crashed my UnixWare installation and had to restart from the
loader diskettes.  The installation did not recognize my drive until I
specified non-zero values for these items.  The values used were 
10002 and 10003.
(END Note)

                           
Go into HW Configuration again, if you have three ide controllers
switch the first to N

Then exit, save changes and apply     

If you have a running system, you can pkgadd the hba diskette,
and then enter the dcu. (Before attempting this you may want to
ensure you have created your emergency boot diskettes).
If installation fails and you cannot boot the operating system,
the recovery procedure is as follows:

1.Press reset
   2.Wait for the Booting UnixWare... prompt; then press the
<SpaceBar> key to begin an interactive boot session.

3.When the [boot]# prompt is displayed, type

KERNEL=unix.old

go

If that does not work then

Before the go add

RESMGR=resmgr.sav

This loads a backup copy of the resource manager database. Your system should
then reboot.
                 

Subject: T11) Installing Windows 95 on the same disk as a UnixWare partition
overwrites the boot loader. What can I do?

Install the  osbs boot manager, this can be obtained from 
ftp.novell.co.uk:/pub/unixware/freebird/bootmanager.


Subject: T12) Desktop tools stop working.

Critical system commands such as tfadmin, no longer execute.
This causes administration tools in the desktop to not function.

These symptoms could occur after doing a backup and restore of
system files, or after doing pkgchk -f. 

TROUBLESHOOTING

To determine if the filepriv database is out of sync, as
superuser run the command:

     initprivs


CAUSE

System commands such as passwd, tfadmin, ftp, etc. rely on the
filepriv database to be correct.  If a file mentioned in the
filepriv database has been modified on the file system in any
way, including simply touching the file, and that change is not
reflected in the filepriv database, the command will not execute
or will not function properly.

One way to cause a lack of syncronization between the file
system and the filepriv database is by doing pkgchk -f, which
goes through the /var/sadm/install/contents file and compares
file attributes in the file, with those on the file system.  If
there is a discrepancy between the two, pkgchk changes the file
attributes on the file system to match the contents file.  Once
the file on the file system has been modified, the filepriv
database is now out of sync with the actual file.  This will
cause the symptoms above to occur.

Another way the filepriv database can become out of sync, is by
backing up and restoring system files.  This causes the 'last
update' time of the file to be modified on the file system, which
does not match the last update time in the filepriv database.

SOLUTION

To syncronize the filepriv database with the file system, run the
command:

     /etc/security/tools/setpriv -x

To check the filepriv database at any time, run the command:

     initprivs

Initprivs will return nothing if the filepriv database is in
sync with the file system.

Subject: T13) Desktop tools stop working when using a monochrome vga monitor

This can be caused by using a monchrome  (gray-scale) vga monitor. Checking
/tmp/xdm-errors shows some error messages. The X Server does not find
enough colours to function.

Several work-arounds exist:

(1)  Reboot the system.  When the red Novell logo appears, hit
enter to get to the interactive boot prompt.  Once there, type
"go" and hit enter.  The system will come up and will look and
function properly.

(2)  Disconnect the monitor from the VGA card during boot.  Once
the system has had time to come up, connect the monitor and it
should function correctly.

(3)  Connect a color VGA monitor for boot.  Once the system is
up, the monitor can be swapped for the monochrome and it should
function properly.

(4)  There have been reports that simply having the monitor
turned off during boot also works.  However, this could not be
reproduced on a consistent basis.

Each time the system is rebooted, one of these methods must be
used.


Subject: T14) How do I configure Mosaic to change its Home page and 
    foreground/background colours?

Place your Xdefaults in $HOME/Mosaic or /usr/X/lib/app-defaults/Mosaic,
or $HOME/.Xdefaults-nodename. The desktop seems to control .Xdefaults.

Mosaic*homeDocument: http://myhome.com
Mosaic*Background: color-name-here
Mosaic*Foreground:  #000000000000

You can also set various Mosaic defaults on the command line, as in:

Mosaic -mono &   # for monochrome monitors

Mosaic -bg Green -fg White &  #  set the background colour to green and 
     # the foreground text to white

Subject: T15) Where can I find  a driver for my SVGA card ?

Checkout the betaX distribution on 
ftp.novell.co.uk:/pub/unixware/usle/x11/servers/betaX. Since
graphics cards always change at a faster rate than the OS release
then this is a way to pick up the latest set of drivers.

Subject T16) How do I change from a 2 button to 3 button mouse?

Choose the Preferences/Mouse icon from the desktop
and select the appropriate number of buttons.

If you have a Logitech mouse, then you may also need to apply
tf2071.tar from ftp.sco.com 


Subject: T17) Howto update the default modem speed from 38.4 to 115.2

Bob Stewart has written a piece of code called hispeed.c included
here.  The source is attached (with permission).

This program changes the asycspdtab table in the running kernel
to support higher speeds than 38400 baud.  It changes the speed
of the B50 entry to 112500, and the B75 entry 50 57600.

There is a restrictions:

It only works on a 16550 UART PC serial port, ie: COM1-4

A binary version in uuencode format is available from
ftp.novell.[de|co.uk]:/pub/unixware/usle/hints/Uucp/hispeed.uu

===========================================================================

/*
 * SCCSID @(#)hispeed.c	1.5 9/27/95
 *
 * file: hispeed.c
 *
 * Copyright 1995, Bob Stewart
 * This program may be used freely with no limitations on distribution,
 * except that changes MUST be noted.
 *
 * You may not charge another person any fee for a copy of this program.
 *
 * Bob Stewart will not be responsible for any errors or problems caused
 * by this program whether through its proper use, misuse, or abuse.
 * It is your responsibility to examine this program, and decide whether
 * you wish to compile and run it on your system.  By doing so, you
 * accept full responsibility for any damage that may occur to your system.
 *
 * This program is not not warranteed to perform any function, including
 * the service it was designed to perform.  :-)
 *
 * NOTICE: This program modifies your running kernel!
 *
 * On Unixware 1.1.x systems, you MUST be using the asyhp driver.
 * On Unixware 2.x systems, you MUST be using the asyc driver.
 *
 * You MUST be using a 16550 uart for hispeed to be effective.  If you
 * are not using a 16550, you will probably experience data over-runs
 * and data loss at 115.2, and probably at 57.6, as well.
 *
 * This program changes the asycspdtab table in the running kernel
 * to support higher speeds than 38400 baud.  It changes the speed
 * of the B50 entry to 115,200, and the B75 entry to 57,600.
 *
 * These changes are NOT permanent.  The old speeds will return on reboot.
 * This program MUST be run by root.
 *
 * Change your /etc/uucp/Systems file to enable the higher speed, e.g.:
 *
 * dial-earth Any ACU 50 1235678 "" \d "" \d in:--in: login word: password
 * dial-sun   Any ACU 75 3193856 "" \d "" \d in:--in: login word: password
 *
 * Make this program by typing "make hispeed", then run it by typing
 * "./hispeed".  For 1.1.x systems, use "./hispeed -h".
 *
 * For a printout of the before and after table values, use "./hispeed -v",
 * or ./hispeed -v -h".
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ksym.h>
#include <stdio.h>


void main(int argc, char *argv[])
{
   int i;
   int verbose=0;
   char fileid[]="/dev/kmem";
   char symname[15];
   short speed[16];
   int  kmemfd;
   struct mioc_rksym rks;

   strcpy(symname,"asycspdtab");

   for(i=1; i<argc; i++)
   {
      if(argv[i][0] != '-')
         continue;

      switch(argv[i][1])
      {
         case('v'):
            verbose=1;
            break;
         case('h'):
            strcpy(symname,"asyhpspdtab");
            break;
         default:
            break;
      }
   }

   if((kmemfd = open(fileid, O_RDWR)) == -1)
   {
      perror("open /dev/kmem:");
      exit(-1);
   }

   rks.mirk_symname = symname;
   rks.mirk_buf = &speed;
   rks.mirk_buflen = sizeof(speed);

   if(ioctl(kmemfd, MIOC_READKSYM, &rks) == -1)
   {
      perror("ioctl /dev/kmem:");
      exit(-1);
   }

   if(verbose)
   {
      printf("Original %s\n",symname);
      for(i=0; i<16; i++)
      {
         printf("%4.4X ",speed[i]);
         if(i%4 == 3)
            printf("\n");
      }
      printf("\n");
   }

   speed[1] = 1;		/* change B50 to 115,200 baud */
   speed[2] = 2;		/* change B75 to  57,600 baud */

   if(verbose)
   {
      printf("Updated %s\n",symname);
      for(i=0; i<16; i++)
      {
         printf("%4.4X ",speed[i]);
         if(i%4 == 3)
            printf("\n");
      }
      printf("\n");
   }

   if(ioctl(kmemfd, MIOC_WRITEKSYM, &rks) == -1)
   {
      perror("ioctl /dev/kmem:");
      exit(-1);
   }

   close(kmemfd);

   fprintf(stderr, "hispeed installed\n");
}


Subject: T18) How to setup  UUCP over TCP/IP between two UnixWare machines

Step 1. Edit /etc/uucp/Devices and uncomment the following line

CS  - - - CS

This then uses the connection server to make connections.


Adding ",eg" to the CS string, you can use the "e" =error-free protocol
instead of the much slower traditional "g" one.
As the TCP "line" can be granted as error-free, there is no need to use the
"g" protocol if both sides know the "e" way:


CS,eg  - - - CS

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
                                              

Step 4.  When the above steps are completed on both UnixWare
machines, use the following command to make sure that you can
UUCP to the remote system.  You should get "Conversation
Complete: Status SUCCEEDED" at the end of the uutry output.  If
not, something is not configured properly, or the remote machine
is not a UnixWare machine and you should use the other
configuration method outlined below to establish UUCP
communication.

/usr/lib/uucp/uutry -r  remote-sys-name

Subject: T19) How to setup  UUCP over TCP/IP between UnixWare  and
   another O/S running UUCP.

By conventions most machines support Uucp over TCP on port 540.

Step 1. Allow incoming connections on uucp port 540.

To perform these steps, you should be logged into the desktop as
the system owner and should have an xterm open where you have    
used the 'su' command to become root.

1.1     Set up the listener to listen on port 540 and test it.

1.1.1   Edit the /etc/inet/inetd.conf file and add the following
line to the end of it (all fields are delimited by tabs):

uucp    stream  tcp     nowait  nuucp   /usr/lib/uucp/uucico    uucico


This sets up a listener through the inetd port monitor to listen
for uucp and run uucico as user nuucp.

1.1.2   Stop and start the inetd service by issuing the following
commands:

sacadm -k -p inetd

sacadm -s -p inetd

1.1.3   Test the new listener by telnetting to port 540 as
follows:     
telnet localhost 540

You should get a prompt back that says, "Shere="
where  is the node name of your UnixWare machine.
You can just close this window, open a new window and 'su' to
root again.  Or, if you wait a few moments the connection will
just timeout and give you a '#' prompt back.

The 'Shere' line that is displayed is uucp on your machine
saying, "Here I am!  Send me some uucp commands."  If you don't
get the "Shere" then something is set up incorrectly.

Step 2.  Setup the outgoing uucp connection using the Connection Server.

In /etc/uucp/Devices put

CS  - - - CS

In /etc/uucp/Systems  put

node Any CS - node.domain.name,uucp in:--in: Logname word: passwd
           

Where node is the UUCP name
node.domain.name is a full domain name that TCP/IP can see
uucp is the service in /etc/inet/services (=540)
Logname is the login name
Passwd is the password.

Plus usual Permissions entries.


Step 3. Test the connection.

Assuming that the remote system is ready to accept uucp      
communication from this UnixWare machine on port 540,
we should get "Conversation Complete: Status SUCCEEDED"
at the end of a uutry.  Now uutry the system by
issuing the following command:

/usr/lib/uucp/uutry -r   name

Where  "name" is the name of the remote system as defined
in the /etc/uucp/Systems file.

If it doesn't work, something isn't configured correctly.  Make
sure that the remote system is ready to receive uucp
communication.  This often requires an entry in the remote
system's /etc/uucp/Systems or /etc/uucp/Systems.tcp file for your
local system.  (In other words, put the UnixWare's system name in
the remote machines Systems file(s).)   


Subject: T20) How do I get my serial communications working?

To obtain a document on how to trouble shoot serial communications,
ftp it from

	ftp.abs.net or ftp.novell.co.uk or ftp.novell.de or netlab1.usu.edu
(either /unixware or /pub/unixware)
	.../freebird/hints/Networking/serial-comms


Subject: T21) In UW1.x in order to use the 16550 UART chips in my serial card,
    I needed to use the asyhp driver. Is this still necessary in UW2?

In UnixWare 2 you should NOT use the 'asyhp' driver.
All functionality of the 1.x asyhp driver has been rolled into
the new 'asyc' driver so there is no need to modify the default
serial driver in UnixWare 2.  This is discussed in the man
pages for both asyc and asyhp.


Subject: T22) How can I debug outgoing modem connections?


Outgoing calls are managed by the connection server [cs(1M)].
Both cu(1), uucp(1), and ppp(1) use the connection server to
dial.

When you click on either 'dial' from the GUI device setup window
or double click on a system icon, you are running 'cu' and can
use this technique to debug your problem.

Many every day problems (such as the remote line being busy) can
be debugged using the connection server debug mode.

To activate cs debug mode, enter the following at the command
line as root:

   # ps -eaf | grep cs
   # kill -9 (the process id of the /usr/sbin/cs process)
   # /usr/sbin/cs -d

This will start a log in /var/adm/log/cs.debug.  

A good debugging technique is to have the 'cs -d' running and in
a separate terminal window, enter 'tail -f /var/adm/log/cs.debug'.
Then, in a separate window do your cu or uucp request.

You'll see what is being sent (e.g. atdt5551212) and what is
being expected (e.g.  CONNECT) as well as some technical details
about which line is being selected and so forth.

At some point you may want to turn cs debug mode off to save
space.

To do this, kill the currently running cs process as shown above
and restart cs using '/usr/sbin/cs' without the -d option.
Alternatively, you could continue to run cs in debug mode and
write a cron(1M) daemon that keeps the size of the
/var/adm/log/cs.debug file reasonable.
            
Subject: T23) How can I quickly setup outgoing uucp?

A tar file containing key /etc/uucp configuration files can be
found on the mail-server archive (ftp.novell.co.uk:
/pub/unixware/usle/hints/Mail/uucp.quick.tar.Z) . This will
setup a hayes compatible modem on COM1 for outgoing uucp only.
See the README file included for details.

Subject T24) How can I access a Comms port from DOS running under UnixWare?

From a shell prompt on a virtual console try:

                dos +acom2 (or +acom1)

or under X windows, from a shell prompt try:

                dos +acom2 +x (or +acom1)

from you desktop, in the applications folder, click
mouse button 3 on the DOS icon, and then select
Options, then select a COM port.  From there you
can invoke this options for a single session by
choosing Start, or you can have the current options
tied to that icon by choosing Apply.


All of the above will fail if another program
(like the port manager, connection manager, uucp or cu)
has the port locked.          

Subject: T25) Where do I find updates and patches for UnixWare 2?

These can be located from ftp.sco.com:/UW20

(The following is taken from the SCO announcment posting with their
permission):

CONNECTION INFORMATION  for updates and patches for UnixWare2

For anonymous ftp connection:
-----------------------------

Directory Name: /UW20

ftp to ftp.sco.com
Login name: ftp
Password:  your email address

Nameservice Note:

The wu-ftp software used on ftp.sco.com requires that two kinds of
DNS resource records for your site have been propagated to SCO's
nameserver:

A Name-to-address mapping  -and-   PTR Address-to-name mapping   

The lack of a propagated PTR record for your site is the most common
cause of problems with anonymous ftp to ftp.sco.com. PTR records
are also known as "pointer" records or "reverse" records.

For anonymous UUCP connection:
------------------------------

Directory name:  /usr/spool/uucppublic/UW20


For USA, Canada, Pacific Rim, Asia and Latin America customers:

Machine name:  sosco                                       
Login name:  uusls  (fourth character is the letter "l")
No password

List of modems available for UUCP transfer from sosco:

V32, V32bis                      5@   +408 425-3502
Telebit Trailblazer                   +408 429-1786


For Europe/Middle East/Africa customers there is a system located at
SCO EMEA (London):

Machine name:  scolon
Login name:  uusls
Password:  bbsuucp

List of modems available for UUCP transfer from scolon.sco.com:

Dowty Trailblazer  +44 (0) 1923 210911
V32                +44 (0) 1923 222681  


For SCO Online Support (SOS) BBS download:
------------------------------------------

NOTE:  Access to the UnixWare Supplements will be available in the
       near future on the SCO Online Support (SOS) System.


These supplements can be downloaded interactively via XMODEM, YMODEM,
ZMODEM or Kermit.  Follow the menu selections under "Toolchest" from
the main SOS menu.


List of modems available for interactive transfer from SOS:

V32, V32bis  8@                 +408 426-9495

Telebit Trailblazer             +408 426-9525    

Note:  telnet access to SOS is available by telneting to sos.sco.com


For customers with CompuServe Access:
-------------------------------------

Type "GO UNIXWARE"



For ftp via World Wide Web:
---------------------------

URL to open:  ftp://www.sco.com
                                  


Subject: T26) How can I set the machine to auto reboot on a panic ?

Change /etc/default/init from

PANICBOOT=NO

to 

PANICBOOT=YES

and remove the execute bit from /sbin/dumpcheck

	chmod -x /sbin/dumpcheck

Rebuild the kernel and reboot.
	/etc/conf/bin/idbuild -B
	/etc/shutdown -i6 -g60 -y

Subject: T27)  Are there any pitfalls when installing UnixWare on  a laptop
  with PCMCIA support?

(Martin Sohnius writes)

Yes, and yes.  :-)

Buy an Ositech Trumpcard "Jack of Diamonds" combined modem/ethernet card.
It's not cheap, but know to be the only one which works with UnixWare.  It
comes with a UnixWare driver in the box (which installs like a dream), and
according to the very good instructions in the README files, you can even
use it for a network install.

Don't install the nics package; the Ositech driver takes its place later.

You other question:  pitfalls.  It depends on the Thinkpad model.  Some of
them (notably the 755CX which I have, but also Pentium-upgraded other
models) fall over with the Machine Check Exception panic after the first
boot floppy.  Download the tf2069.tar file from the ftp server (*not* the
tf2069as.tar file -- that seems to be corrupt!) and create a new boot floppy
from it.  Follow the instructions in the *.txt file as to the special boot
parameter

	CR4_MCE=NO

You cannot use a CD-ROM in the Thinkpad proper (it's an IDE-ATAPI).  So,
unless you want to network install with your Ositech or with the "slip
install" in the USLE archive (takes forever!), you need a docking station
with a SCSI CD-ROM drive.  The SCSI adapter in "Dock 1" is a Future Domain
(driver name fdeb) and is factory set to IRQ 11.  Since UnixWare's default
is IRQ 5 for the fdeb driver, you must change it in the DCU (or set the IRQ
to 5 in the hardware).

Please, totally ignore the TID in the NetWire archive on 755E and docking
stations!  It's garbage.

Subject: T28) Are there any problem in getting UnixWare/NetWare connections
up and running?

Greg Smith (gsmith@westnet.com) writes:

One thing that I (and a number of other people) had problems with is
getting the UnixWare/NetWare connections up and running.  Specifically,
the NUC NLM module doesn't load correctly with older versions of NetWare
until a number of updates are taken care of.

I had so many problems with it that, after I solved all of them, I wrote a
guide on troubleshooting the initial problems for my own use before I
forgot any of it, and I packaged it up for others to use as well.  It's
about 5 pages long and available on my home page, 
URL http://www.westnet.com/~gsmith (This is also available
on ftp.novell.[co.uk|de]:/pub/unixware/usle/hints/UW2/uw2nw).

Subject: T29)  When installing the 2.02 update, an error appearead about
a bad entry on the contents file - how can this be fixed?


When trying to install the 2.02 update on to my 2.01AS system, 
partway through the following error appeared:

 bad entry read from contents file :     - problem: unknown ftype
 UX:pkginstall: ERROR: unable to merge package and system information

The install halted after the error.  I've also noticed that on system
startup, the console shows an error message somewhat similar, about a
problem merging contents or something.  What's the cause of the
problem?


The problem is in the file /var/sadm/install/contents.  Usually the very first
line is badly corrupt (no idea what combo of circumstances causes this,
though).  Delete that first line.

Subject: T30) How do I install the *.pkg.tar.Z files from the USLE archive?


	xxxx.pkg.tar.Z     A compressed tar archive of a binary in
			   pkgadd format

Where a file is suffixed with .gz this means that the GNU Zip
file compression utility has been used - to uncompress in this
case use gunzip.

The ".pkg" software package files follow the ABI (System V Application
Binary Interface) conventions for add-on
packages and are installed in /opt. It is wise to
change the default PATH setting to include /opt/bin in /etc/profile.

	PATH=$PATH:/opt/bin
	export PATH

If you do not have a /opt, you can create it with the subdirectories
/opt/bin, /opt/lib, /opt/man -- you could also use a symbolic link
to some other part of disk if you like (for example /usr/local) which
can be useful if you get short of free disk space.

To make the manual pages accessible to the /usr/ucb/man command
set the MANPATH environment variable to include /opt/man,
a typical MANPATH might be:

        MANPATH=/usr/share/man:/opt/man
        export MANPATH
                          
The packages (pkg.tar files) should be installed as follows:

1. Extract the tar archive into /tmp.

$ cd /tmp

If compressed (.Z) then

$ zcat package.tar|tar xvf -
$ su
# pkgadd -d `pwd`

Many of the utilities include desktop icons for point and click
operation:

2. Installing graphically

On UnixWare 1.x:
----------------
To install graphically on UnixWare (after you have installed the package)
        Select the System_Setup icon from the Desktop.
        Select Application_Setup from System_Setup
        Wait while the system catalogs the applications
        Select the package icon from Application_Setup to get to
            Application_Setup:package_name         
       Select the package icon and Finally click on the Install_to_desktop
        Selecting Applications from the Desktop you should
        then see the package icon.
                    
On UnixWare 2.x:

For UnixWare 2.0 and later, use the App_Installer utility in Admin_Tools
after doing the pkgadd.

	Select the Admin_Tools icon from the Desktop.
	Select the App_Installer icon from Admin_Tools
	Select the icon of the package from the "All Applications
		currently installed" window
	Select Show_Contents
	Select the installable icon and hit Copy_to_folder
	Select Apply, followed by Ok.



Subject: T31) How do I configure support for WWW virtual hosts, so that
one machine can have several IP addresses ?

(This answer based on a doc taken from www.uux.org - with some supplemental
notes added/changed ...)

Virtual host support is being used by the latest versions of many
WWW servers - such as NCSA 1.5 and the Apache server.
These  servers have a feature which allows you to have web pages for 
more than one domain on your system. So, for example, a  server
actually running on webserver.webinc.com could serve docs for another domain
such as www.uux.org. Each domain can have their own home page, so 
http://webserver.webinc.com and http://www.uux.org while both pointing 
at the same physical machine will return different documents.

This is actually quite easy to configure with UnixWare, it just isn't
documented anywhere. Until now.

On the Web Server side, all you really need to do is
add an appropriate < Virtual Host> section to your httpd.conf. Here is
ours (for NCSA 1.5):

< VirtualHost avirtual.ukb.novell.com>
ServerAdmin     < webmaster@avirtual.ukb.novell.com>
ServerName      avirtual.ukb.novell.com
ErrorLog        /var/opt/httpd/logs/avirtual/error_log
TransferLog     /var/opt/httpd/logs/avirtual/access_log
ResourceConfig  conf/avirtual.conf
</VirtualHost>

In the ResourceConfig you can specify a DocumentRoot and
All of your pages for a given virtual host need to be placed under its
DocumentRoot, most other directories such as cgi-bin/ and icons/ are
shared.

Now comes the harder (but not hard) part. 

The virtual host must have an entry in the DNS with a valid IP number 
under your site's control.  (It's no use attempting any of this if this
is not setup properly).

And you need an interface that responds to this IP address. There
are two ways to do this; either using "loopback" devices or "PPP" devices.

The trick is to fool the PPP or Loopback interface into routing packets 
aimed at it back to your ethernet card.

1) Adding the devices

1.1) Using PPP devices

First, to create a spare PPP interface, add a line like this to
/etc/confnet.d/inet/interface:

www:0:165.90.143.56:/dev/ppp:165.90.143.3 netmask 255.255.255.0:add_ppp:

The interface prefix isn't particularily important, I named it www since
we're going to be using this as web hosts. The second field is the unit
number, from 0-9. The third field is the IP address assigned to this
interface. The fourth field says this interface uses /dev/ppp and the
fifth field includes the paramaters we want to pass to ifconfig. The
second IP address is the address of your  REAL interface to the 'Net.

[Note- to restart the interface as root, do:
	sh /etc/inet/rc.restart
To see if the interface came up then do:
	ifconfig -a
You should see a line for www0 
SMC8K0: flags=23<UP,BROADCAST,NOTRAILERS>
        inet 164.99.11.176 netmask ffffffc0 broadcast 164.99.11.191
www0: flags=11<UP,POINTOPOINT>
        inet 164.99.11.177 --> 164.99.11.176 netmask ffffffc0
lo0: flags=49<UP,LOOPBACK,RUNNING>
        inet 127.0.0.1 netmask ff000000     ]

(Note that this usage of PPP devices does not seem to work with
UW2.1, although there is a new ifconfig alias feature which seems
potentially more useful)

1.2) Using Loopback devices

To use the loopback devices edit /etc/confnet.d/inet/interface and
add devices as follows, an example follows showing the maximum
supported by UnixWare 2.0x.

lo:0:localhost:/dev/loop::add_loop:
lo:1:198.68.61.21:/dev/loop::add_loop:
lo:2:198.68.61.22:/dev/loop::add_loop:
lo:3:198.68.61.23:/dev/loop::add_loop:
lo:4:198.68.61.24:/dev/loop::add_loop:
lo:5:198.68.61.25:/dev/loop::add_loop:
lo:6:198.68.61.26:/dev/loop::add_loop:
lo:7:198.68.61.27:/dev/loop::add_loop:
lo:8:198.68.61.28:/dev/loop::add_loop:
lo:9:198.68.61.29:/dev/loop::add_loop:
nflxe:0::/dev/nflxe_0:netmask 255.255.255.0 broadcast 198.68.61.255 -trailers::         

2) Setting up ARP entries

After adding lines for all of your virtual hosts, you will need to get
the world to recognize them. To do this we will preload the arp cache
with entries that point from the virtual interfaces to your ethernet
card's hardware address.

I added an entry to /etc/inet/config that looks like this: 

2:/usr/sbin/arp::y:/etc/inet/arptable:-f /etc/inet/arptable:

Note that I'm running it early. You want this entry in place before the
PPP interfaces are brought up. You will need to create the file
/etc/inet/arptable which consists of entries listing the hostname or IP
address you are faking followed by the hardware address of your ethernet
card.  Here's ours:

www.uux.org 0:0:c0:21:9e:27 pub

[Note; to found out your macaddr look in /etc/inet/macaddr,
You can try this by hand initially by creating the file
/etc/inet/arptable and then:
	arp -f /etc/inet/arptable ;
doing an arp -a should so the permanent published (in this example
i added lechlade.ukb.novell.com
# arp -a
yeti.ukb.novell.com (164.99.11.168) at 0:80:5f:48:52:5b
lechlade.ukb.novell.com (164.99.11.177) at 0:0:c0:fb:b6:68 permanent published
usg.ukb.novell.com (164.99.11.131) at 0:0:1b:50:ce:55  
]

Make sure you include the "pub" our your system won't announce the entry. 

3) Reboot, or restart 

That's it. Reboot and you will have a working virtual interface.
Note, no need to reboot if you use  sh /etc/inet/rc.restart above,
although it is wise to check that the procedure does survive a reboot.

Subject: T32) How do I setup the NFS automounter?

On the Client side, Create the file /etc/auto.direct

/var/mail      -hard,grpid,intr,rsize=1024,wsize=1024  windsor.ukb.novell.com:/var/mail
/rtmp   -hard,grpid,intr,nosuid,rsize=1024,wsize=1024   windsor.ukb.novell.com:/rtmp
# This example takes the resource from two servers so if one goes down
# the other will kick in.
/opt    -ro,soft,grpid,intr,rsize=1024,wsize=1024       usle.ukb.novell.com:/fs1/destiny windsor.ukb.novell.com:/export2/destiny
/fs/marlow/home      -rw,hard,grpid,intr,nosuid,rsize=1024,wsize=1024    marlow:/home 

Edit /etc/rc3.d/S22nfs and enable the automounter to use the /etc/auto.direct 
map (this is towards the end of the start section)


        # Mount all NFS files listed in /etc/vfstab
        /sbin/mountall -F nfs &

	# These modified for local use
        if [ -x /usr/lib/nfs/automount ]
        then
	  # only start the auto mounter if our main server is up
          /usr/sbin/ping windsor 1 | grep alive >/dev/null 2>&1
          if [ $? = 0 ]
          then
            /usr/lib/nfs/automount -tl 1800 /- /etc/auto.direct&
          else
            echo "Windsor is not up - not starting automounter"
          fi
        fi

        ;;
'stop')     

On the server side, edit /etc/dfs/dfstab

For example:

share -F nfs /rtmp&
share -F nfs -oro /export2/destiny &  
# this example restricts the sharing to just a couple of machines.
share -F nfs -o rw=london.ukb.novell.com:eaton.ukb.novell.com:carrera.ukb.novell.com /var/mail&

Subject: T33) How do I change the IP address and name of a UnixWare box?

Randy Seuss and Martin Sohnius write:

	uname -S new_node_name
	/etc/inet/menu

Which then takes you thru the screens necessary for assigning
IP addresses, routers, etc.  I believe that the above is
enough, PROVIDED you either reboot the system or at least run the
command

	# sh  /etc/rc2.d/S65loopback

(For more info as to why, look at the S65loopback script yourself.)
and then

	# /etc/inet/rc.restart


Subject T34)How can I read the size of installed memory in a UnixWare system?

At the command line as root, use the memsize(1M) or prtconf(1M)
commands.

In C you can use the sysi86(SI86MEM) call, for example:

#include <sys/sysi86.h>
#include <stdio.h>

main()
{
printf ("memsize = %ld \n", sysi86(SI86MEM));
}     


Subject T35) I have UnixWare 2.03 and have problems reading multiple files
from floppy (the machine has 32MB of RAM).

Apply ptf2202.tar from ftp.sco.com:/UW20/

                      
Subject T36)How do I found out the number of max processes a UnixWare machine
is set for?

	su
	/etc/conf/bin/idtune -g NPROC

idtune then prints out at most four values

	The current value of the tunable parameter

	The default value, from the Mtune entry

	The minimum valid value, from the Mtune entry

	The maximum valid value, from the Mtune entry


To increase the number of processes to say 1200

	/etc/conf/bin/idtune NPROC 1200

Subject: T37) I've lost the root password, what do I do now?


If you can login as the "system owner", then you can use tfadmin(1m)
to change root's password.  This works on both UnixWare 1.x and 2.x:

    $ /sbin/tfadmin passwd root   

or to delete the root password (remember to reset it afterwards)

    $ /sbin/tfadmin passwd -d root   

Otherwise you need to use the emergency boot floppy (an EBF).

 
Subject: T38) How to recover with an Emergency boot?

Peter Lord writes:

At some time or other, you will find yourself with a UnixWare machine
which either you can't log into or won't boot up. Their are many
possible causes for this but perhaps the most common include forgetting
passwords, configuring the kernel incorrectly and editing system files
by hand incorrectly.

One example (now laughable - but not at the time!) was when I wanted to
bring the system into single user mode for admin. I edited /etc/inittab
to switch the default run-level to 1. Later, I put the run-level back to
6 (not 3!). This left me with a machine which continually re-booted
itself!

Creating an emergency boot disk set is an essential admin task. On
UnixWare 2, create a disk set by :-

     emergency_disk diskette1

This will take a few minutes. Note that this disk set is unique for you
machine. Also, as it contains all your HBA drivers, make sure you create
it after your machine is stable and fully installed.

When booting with your disk set, a mini version of UnixWare is booted
from the floppies. You will be presented with a short menu allowing you
to repair disks, mount disks and enter a shell. In my example above, I
could enter the shell and edit /etc/inittab before rebooting.

As well as creating an emergency boot set, you can also create a backup
of your whole machine onto tape and restore this tape with the emergency
boot set. See the  emergency_rec program to create such a tape. 


Subject: T39) Where are the system messages and log files on UnixWare?
 
Peter Lord Writes:

As a UnixWare system administrator, you need to keep track of the
various messages that the system generates. But where are these
messages?

Console Messages

If you are using the graphical desktop, you may miss some messages
because they are written out to the console or your home virtual
terminal (VT).

You can switch from the graph VT to the home VT by pressing ALT-SYSRQ
together, then H. To get back to the graphical VT press ALT-SYSRQ F1. 

Operating system messages

Occasionally, the kernel will want to print some message out to you.
This may be some information, warning or error messages. There are a few
ways to read these messages :-

1. /dev/osm devices. As root, you may access the /dev/osm* devices to
view these messages. The command "cat /dev/osm1" will print out the messages to
date and the command "tail -f /dev/osm1" will print out the last few
messages and will continue to print out new ones. 

2. /var/adm/log/osmlog file. This file records the output of /dev/osm.
Old versions of this file (from previous boots) are kept in the same
directory. This file is usually readable by all. 

3. Msg_Monitor. This is a graphical tool which monitors the operating
system messages from the desktop (found in the Applications folder). This is
configurable (so, for example, you can set it up to de-iconify on
receipt of a new message).

System messages

Application programs also want to alert you to possible problems.
Usually these will either be generated at the console or through the
/dev/osm interface.

However, it is possible to collect these messages by severity into a log
file. In fact, all the messages from all the machines on the network may
be collected together into one file. This system is syslog.

The syslog daemon (syslogd(1)) is started from /etc/inet/config. Make
sure you have a line thus in this file :-

/etc/inet/config:8:/usr/sbin/syslogd::y:/etc/syslog.conf::

And the configuration file /etc/syslog.conf should look something like this :- 

*.err;kern.debug;daemon.notice;mail.crit;user.none      /var/adm/log/messages
*.alert;user.none                                       root
*.emerg;user.none                                       *
auth.info                                               /var/adm/log/authlog
*.debug                                                 @loghost

(Note in this example, loghost is an alias in /etc/hosts for the IS
monitoring machine)

Connection Server

The Connection server (cs(1)) is a daemon which establishes connections
for TLI/serial network services such as uucp, PPP etc. The log file for
the connection server is kept in /var/adm/log/cs.log.

However, if you are experiencing connection problems, the information in
this log file may not be detailed enough (for example, your uucp
connection is failing). The cs daemon can be run in debug mode to give
more information in the file  /var/adm/log/cs.debug by running cs with
the -d option.

Firstly, kill off the existing cs process (do a ps -edf | grep cs).
Secondly run cs -d (as root).  


Acknowledgements   
---------------

Thanks go to the following for their contributions (either directly
or on the netnews) in putting this FAQ together:

	Leo Smith, Bob Stewart, Martin Sohnius, Greg Smith, Mike West,
Dan Busarow, Randy Seuss, Jeff Lind, Tim Rice, David Stone, Peter Lord
(from whom I borrowed text from his healthcheck slides) and last 
but not least, the Novell  & SCO staff who put the tech info on 
the WWW.novell.com & ftp.sco.com sites.

