# 
# Makefile to build a custom+ SSO for SCO Skunkware 98
# rr@sco.com
#
# Must use SCO OpenServer Development System make rather than GNU make (!?)
#

HERE=`pwd`
CFG=-config cdmt/cdmt.tape.config
CDCFG=-config cdmt/cdmt.cd.config
FLCFG=-config cdmt/cdmt.cd.config

#all:: cdmt.tape.config cdmt.cd.config sso ssocd
#all:: ssoTAPE 
#all:: ssoFLOP
all:: ssocd 

# If we are exporting to the system from this SSO, then this 
# rule will wipe out the existing (installed) SSO, making it uninstalled
# and perhaps leaving custom databases in an awkward state.
# so be warned
ssocd : input/default.prd cdmt/cdmt.cd.config Makefile
	CDMT_DIR=$(HERE) cdmtParse  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)

ssoTAPE: input/default.prd cdmt/cdmt.tape.config Makefile
	CDMT_DIR=$(HERE) cdmtParse  $(CFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

ssoFLOP: input/default.prd cdmt/cdmt.floppy.config Makefile
	CDMT_DIR=$(HERE) cdmtParse  $(FLCFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(FLCFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(FLCFG)

compress:
	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)

archive:
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

#install ::
#	@echo To install the skunk SSO on this machine run 
#	@echo as root 
#	@echo make export enable 
#
# install the archives/TAPE onto my machine, two passes, Load and Enable

# must be root to do this
install:: load enable

# custom load is -L, -z is the image directory
export load:: archives/TAPE
	custom -p SKUNK98:default -L -z $(HERE)/archives/TAPE

# custom enable, this requires that it be "loaded", then we can populate 
# the /usr space. 
enable: /opt/P/SKUNK98
	custom -p SKUNK98:default -e

no_skunk really_clean_sys : disable remove clean_system
# custom disable, but dont remove
disable:
	custom -p SKUNK98:default -d
# really remove the files from /opt/?/SKUNK98
remove:
	custom -p SKUNK98:default -r
# remove SKUNK98 from the /opt area
clean_system::
	rm -rf /opt/?/SKUNK98 /var/opt/K/SKUNK98

# export the ssoCD to my machine
# do a quick install on my own machine
# start by disabling the skunk on my machine 
# only works if the perms in the ssoCD dir allow those binaries to be
# executed and read ...  to get this right run "make fixall"
export_CD:  ssocd 
	-custom -p SKUNK98:default -d
	rm -rf /opt/?/SKUNK98 /var/opt/K/SKUNK98
	-mkdir -p /opt/P/SKUNK98/default /opt/K/SKUNK98 /var/opt/K/SKUNK98
	( cd ./ssoCD ; for i in opt/P/SKUNK98/default/5.0; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK98/*; do \
		mkdir -p /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK98/*/*; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )

# just a quick fix, for stuff we know we need to tweak ...
# dont run this on a readonly ssoCD 
fixup_perms fp quickfix: 
	find ./ssoCD -name "ccs" -exec chmod +x {} \;  
	chmod +x ./ssoCD/opt/K/SKUNK98/Xmcd/2.1/libdi.d/configure.sh 

# this is not quick at all ...
# and you must be root, should be done after a "make export" 
# and before make enable
fixall fix_all fixperms fixperm: 
	custom -p SKUNK98:default -v quick -x >/dev/null

# to test the prd database file
parse.prd parse prd :
	CDMT_DIR=$(HERE) cdmtParse -prd input/default.prd  $(CFG) 

# after a compress and parse
archCD : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)
arch : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

CMPNTS=\
./audio/mpg123-0.59k/input/mpg123.cmpnt \
./audio/oss-980728/input/OSS.cmpnt \
./audio/sox-11.12/input/Sox.cmpnt \
./audio/timidity-0.2i/input/Midi.cmpnt \
./audio/xmcd-2.3/input/Xmcd.cmpnt \
./audio/xmmix-1.2/input/XMmix.cmpnt \
./db/addressbook-0.7/input/Addressbook.cmpnt \
./db/mktable-1.0/input/Mktable.cmpnt \
./db/msql-2.0.3/input/Msql.cmpnt \
./db/mysql-3.21.26/input/Mysql.cmpnt \
./devtools/autoconf-2.12/input/Autoconf.cmpnt \
./devtools/bison-1.25/input/Bison.cmpnt \
./devtools/cvs-1.9/input/Cvs.cmpnt \
./devtools/gcc-98q2/input/Gcc.cmpnt \
./devtools/gdb-4.17/input/Gdb.cmpnt \
./devtools/flex-2.5.4/input/Flex.cmpnt \
./devtools/getline-3.11/input/Getline.cmpnt \
./devtools/indent-1.9.1/input/Indent.cmpnt \
./devtools/make-3.76.1/input/Make.cmpnt \
./devtools/mkpkg-1.1/input/Mkpkg.cmpnt \
./devtools/mkvol-1.1/input/Mkvol.cmpnt \
./devtools/patch-2.5/input/Patch.cmpnt \
./devtools/rcs-5.7/input/Rcs.cmpnt \
./devtools/readline-2.1/input/Readline.cmpnt \
./devtools/SmallEiffel-0.91/input/SmallEiffel.cmpnt \
./editors/ashe-1.3/input/XHTML.cmpnt \
./editors/vile-7.3/input/Vile.cmpnt \
./editors/pico-3.96/input/Pico.cmpnt \
./editors/nedit-5.0.2/input/Nedit.cmpnt \
./editors/elvis-2.0/input/Elvis.cmpnt \
./editors/emacs-20.2/input/Emacs.cmpnt \
./editors/nvi-1.79/input/Nvi.cmpnt \
./editors/joe-2.8/input/Joe.cmpnt \
./editors/jed-0.98.7/input/Jed.cmpnt \
./editors/tags-1.0/input/Tags.cmpnt \
./editors/xcoral-3.14/input/Xcoral.cmpnt \
./editors/xemacs-20.4/input/Xemacs.cmpnt \
./editors/vim-5.1/input/Vim.cmpnt \
./emulators/Eterm-0.8pre6/input/Eterm.cmpnt \
./emulators/lxrun-0.9.0/input/Lxrun.cmpnt \
./emulators/rxvt-2.4.5/input/Rxvt.cmpnt \
./fileutil/cpio-2.4.2/input/Cpio.cmpnt \
./fileutil/diffutils-2.7/input/Diffutils.cmpnt \
./fileutil/file-3.22/input/File.cmpnt \
./fileutil/fileutils-3.16/input/Fileutils.cmpnt \
./fileutil/findutils-4.1/input/Findutils.cmpnt \
./fileutil/gifutils-1.0/input/gifutils.cmpnt \
./fileutil/git-4.3.17/input/Git.cmpnt \
./fileutil/glimpse-4.1/input/Glimpse.cmpnt \
./fileutil/makecd-1.0/input/MakeCD.cmpnt \
./fileutil/mc-4.1/input/mc.cmpnt \
./fileutil/mtools-3.8/input/Mtools.cmpnt \
./fileutil/tar-1.12/input/Tar.cmpnt \
./interp/expect-5.25/input/Expect.cmpnt \
./interp/perl-5.004_04/input/Perl.cmpnt \
./interp/python-1.5/input/Python.cmpnt \
./interp/tcl-8.0p2/input/Tcl.cmpnt \
./interp/tclx-8.0.2/input/TclX.cmpnt \
./interp/tk-8.0p2/input/TK.cmpnt \
./java/Acme-1.0.2/input/Acme.cmpnt \
./java/Djava-052097/input/Djava.cmpnt \
./java/jasmin-1.06/input/Jasmin.cmpnt \
./java/klassmaster-1.0/input/Klassmaster.cmpnt \
./java/vrwave-0.9/input/VRwave.cmpnt \
./libraries/FSUpthreads-3.5/input/FSUpthreads.cmpnt \
./libraries/Glib-1.3/input/Glib.cmpnt \
./libraries/ncurses-4.2/input/Ncurses.cmpnt \
./libraries/slang-1.2.2/input/Slang.cmpnt \
./mail/fetchmail-4.5.4/input/Fetchmail.cmpnt \
./mail/hypermail-1.02/input/Hypermail.cmpnt \
./mail/majordomo-1.94.4/input/Majordomo.cmpnt \
./mail/procmail-3.11pre7/input/Procmail.cmpnt \
./mail/mm-2.7/input/Metamail.cmpnt \
./mail/mutt-0.93.2/input/Mutt.cmpnt \
./mail/spambnc-1.00h/input/Spambnc.cmpnt \
./mail/xbuffy-3.3/input/XBuffy.cmpnt \
./net/Count-2.4/input/Count.cmpnt \
./net/apache-1.3.0/input/Apache.cmpnt \
./net/freeWAIS-sf-2.2.10/input/freeWAIS.cmpnt \
./net/httpanalyze-2.01/input/HttpAnalyze.cmpnt \
./net/irc-2.9.5/input/Irc.cmpnt \
./net/ldap-3.3/input/LDAP.cmpnt \
./net/lynx-2.8rel2/input/Lynx.cmpnt \
./net/ncftp-2.4.3/input/Ncftp.cmpnt \
./net/omniORB-2.5.0/input/omniORB.cmpnt \
./net/php-3.0RC3/input/PHP.cmpnt \
./net/squid-1.1.22/input/Squid.cmpnt \
./net/tftpd-1.0/input/Tftpd.cmpnt \
./net/wget-1.5.2/input/Wget.cmpnt \
./net/wu-ftpd-2.4/input/wuftpd.cmpnt \
./net/wwwtar-1.0/input/WWWtar.cmpnt \
./net/xarchie-2.0.10/input/Xarchie.cmpnt \
./net/xdir-2.0/input/XDir.cmpnt \
./net/zircon-1.18.113/input/Zircon.cmpnt \
./news/inn-2.0/input/INN.cmpnt \
./shells/tcsh-6.07/input/Tcsh.cmpnt \
./shells/zsh-3.1.4/input/Zsh.cmpnt \
./shellutil/bzip2-0.1pl2/input/Bzip2.cmpnt \
./shellutil/gawk-3.0.3/input/Gawk.cmpnt \
./shellutil/mawk-1.3.3/input/Mawk.cmpnt \
./shellutil/gzip-1.2.4/input/GZIP.cmpnt \
./shellutil/less-332/input/Less.cmpnt \
./shellutil/m4-1.4/input/M4.cmpnt \
./shellutil/sh-utils-1.15/input/Shutils.cmpnt \
./shellutil/unzip-5.3/input/Unzip.cmpnt \
./shellutil/zip-2.1/input/Zip.cmpnt \
./sysadmin/SarCheck-3.61lite/input/SarCheck.cmpnt \
./sysadmin/hog-1.0/input/Hog.cmpnt \
./sysadmin/johnd-1.1/input/Johnd.cmpnt \
./sysadmin/pkgtools-skw98/input/Pkgtools.cmpnt \
./sysadmin/rpm-2.4.5/input/Rpm.cmpnt \
./sysadmin/top-3.5beta5/input/Top.cmpnt \
./textproc/a2ps-4.10.1/input/A2ps.cmpnt \
./textproc/enscript-1.6.1/input/Enscript.cmpnt \
./textproc/groff-1.11/input/Groff.cmpnt \
./textproc/ispell-3.1.20/input/Ispell.cmpnt \
./textproc/gs-5.10/input/GS.cmpnt \
./textproc/par-1.50/input/Par.cmpnt \
./textproc/sgml-tools-1.0.6/input/sgmltools.cmpnt \
./textproc/tex-7.2a/input/TeX.cmpnt \
./textproc/texinfo-3.12/input/Texinfo.cmpnt \
./video/mpeg_bits-1.0b/input/Mpeg_bits.cmpnt \
./video/mpeg_blocks-1.0b/input/Mpeg_blocks.cmpnt \
./video/mpeg_encode-1.5b/input/Mpeg_encode.cmpnt \
./video/mpeg_play-2.3/input/Mpeg_play.cmpnt \
./video/mpeg_stat-2.2b/input/Mpeg_stat.cmpnt \
./x11/apps/xacc-1.0.17/input/Xacc.cmpnt \
./x11/apps/xfilemanager-0.4.1/input/XFM.cmpnt \
./x11/apps/xinvest-2.5.1/input/Xinvest.cmpnt \
./x11/apps/xmorph-17jan97/input/Xmorph.cmpnt \
./x11/apps/xpaint-2.5.4/input/Xpaint.cmpnt \
./x11/apps/xquote-1.1/input/Xquote.cmpnt \
./x11/apps/xtide-2.0b2/input/XTide.cmpnt \
./x11/apps/xsw-5.0.4/input/Xsw.cmpnt \
./x11/apps/xtar-1.4/input/Xtar.cmpnt \
./x11/games/crossfire-0.94.0/input/Crossfire.cmpnt \
./x11/games/mirrormagic-1.3/input/Mirror.cmpnt \
./x11/games/xblackjack-2.2/input/Xbj.cmpnt \
./x11/games/xboing-2.4/input/Xboing.cmpnt \
./x11/games/xconq-7.2.2/input/Xconq.cmpnt \
./x11/games/xdoom-980307/input/Xdoom.cmpnt \
./x11/games/xgalaga-2.0.34/input/Xgal.cmpnt \
./x11/games/LinCity-1.09/input/LinCity.cmpnt \
./x11/games/xpilot-3.7.1/input/Xpilot.cmpnt \
./x11/games/spellcast-1.0/input/Spellcast.cmpnt \
./x11/graphics/ImageMagick-4.0.7/input/IMGCK.cmpnt \
./x11/graphics/pixmaps-2.0/input/Pixmaps.cmpnt \
./x11/graphics/bitmap-x11r5/input/Bitmap.cmpnt \
./x11/graphics/freefonts-0.1/input/Freefonts.cmpnt \
./x11/graphics/GimpManual-1.0.0/input/GimpMan.cmpnt \
./x11/graphics/gimp-1.0/input/Gimp.cmpnt \
./x11/graphics/gnuplot-3.5/input/Gnuplot.cmpnt \
./x11/graphics/xfig-3.2/input/Xfig.cmpnt \
./x11/graphics/transfig-3.2/input/Transfig.cmpnt \
./x11/misc/astrolog-5.30/input/Astrolog.cmpnt \
./x11/misc/mathrec-1.1/input/Mathrec.cmpnt \
./x11/misc/xaos-3.0/input/XaoS.cmpnt \
./x11/misc/xdaliclock-2.10/input/Xdaliclock.cmpnt \
./x11/misc/xearth-1.0/input/Xearth.cmpnt \
./x11/misc/xfishtank/input/xfishtank.cmpnt \
./x11/misc/xkeycaps-2.42/input/Xkey.cmpnt \
./x11/misc/xsnow-1.40/input/Xsnow.cmpnt \
./x11/misc/xtartan-2.3/input/Xtartan.cmpnt \
./x11/savers/xlockmore-4.09/input/Xlock.cmpnt \
./x11/savers/xscreensaver-2.24/input/Xsaver.cmpnt \
./x11/viewers/Xswallow-1.0.11/input/Xswallow.cmpnt \
./x11/viewers/ghostview-1.5/input/Ghostview.cmpnt \
./x11/viewers/gv-3.5.8/input/GV.cmpnt \
./x11/viewers/xanim-2.70.7.0/input/Xanim.cmpnt \
./x11/viewers/xpdf-0.7a/input/Xpdf.cmpnt \
./x11/viewers/xv-3.10a/input/XV.cmpnt \
./x11/winman/fvwm-2.0.46/input/Fvwm.cmpnt \
./x11/winman/kde-1.0/input/Kde.cmpnt \
./x11/winman/WindowMaker-0.16.1/input/WindowMaker.cmpnt \
./x11/winman/AfterStep-1.0/input/ASTP.cmpnt
# ./x11/winman/enlightenment-0.13.3/input/Enlightenment.cmpnt \
# ./x11/misc/stacey-1.1/input/Stacey.cmpnt \
# ./audio/maplay-1.2/input/Maplay.cmpnt \
# ./net/Mosaic-2.7b4/input/Mosaic.cmpnt \
# ./audio/Xmixer-1.1/input/Xmixer.cmpnt \

.PRECIOUS:$(CMPNTS)
$(CMPNTS) : cdmt/cdmt.tape.config 
	cdmtParse -cmpnt $@
	cdmtCompress -cmpnt $@
	#cdmtArchive 


# some rules for building and test install of one cmpnt
# first run 
# make Xmcd arch 
# then 
# make Xmcd_try 
# 
# we disable, them remove, then load from the arch, then enable ... 
# this can be done for other cmpnts/packages as well
Xmcd_try : 
	custom -p SKUNK98:default -d SKUNK98:Xmcd
	custom -p SKUNK98:default -r SKUNK98:Xmcd 
	custom -p SKUNK98:default -L SKUNK98:Xmcd -z $(HERE)/archives/TAPE
	custom -p SKUNK98:default -e SKUNK98:Xmcd
gds_try : 
	custom -p SKUNK98:default -d SKUNK98:gds
	custom -p SKUNK98:default -r SKUNK98:gds 
	custom -p SKUNK98:default -L SKUNK98:gds -z $(HERE)/archives/TAPE
	custom -p SKUNK98:default -e SKUNK98:gds
groff_try : 
	custom -p SKUNK98:default -d SKUNK98:groff
	custom -p SKUNK98:default -r SKUNK98:groff 
	custom -p SKUNK98:default -L SKUNK98:groff -z $(HERE)/archives/TAPE
	custom -p SKUNK98:default -e SKUNK98:groff

individual: make_ind.sh
	sh make_ind.sh $(CMPNTS)

distfiles: make_dist.sh
	sh make_dist.sh $(CMPNTS)

undistfiles: make_undist.sh
	sh make_undist.sh $(CMPNTS)
