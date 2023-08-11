# 
# Makefile to build a custom+ SSO for SCO Skunkware 97
# rr@sco.com
#

HERE=`pwd`
CFG=-config cdmt.config
CDCFG=-config cdmt.cd.config

#all:: cdmt.config cdmt.cd.config sso ssoCD
all:: ssoTAPE 

# If we are exporting to the system from this SSO, then this 
# rule will wipe out the existing (installed) SSO, making it uninstalled
# and perhaps leaving custom databases in an awkward state.
# so be warned
ssoCD : input/default.prd cdmt.cd.config Makefile
	rm -rf $@	
	CDMT_DIR=$(HERE) cdmtParse  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)
ssoTAPE: input/default.prd cdmt.config Makefile
	rm -rf $@	
	CDMT_DIR=$(HERE) cdmtParse  $(CFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

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
	custom -p SKUNK97:default -L -z $(HERE)/archives/TAPE

# custom enable, this requires that it be "loaded", then we can populate 
# the /usr space. 
enable: /opt/P/SKUNK97
	custom -p SKUNK97:default -e

no_skunk really_clean_sys : disable remove clean_system
# custom disable, but dont remove
disable:
	custom -p SKUNK97:default -d
# really remove the files from /opt/?/SKUNK97
remove:
	custom -p SKUNK97:default -r
# remove SKUNK97 from the /opt area
clean_system::
	rm -rf /opt/?/SKUNK97 /var/opt/K/SKUNK97

# export the ssoCD to my machine
# do a quick install on my own machine
# start by disabling the skunk on my machine 
# only works if the perms in the ssoCD dir allow those binaries to be
# executed and read ...  to get this right run "make fixall"
export_CD:  ssoCD 
	-custom -p SKUNK97:default -d
	rm -rf /opt/?/SKUNK97 /var/opt/K/SKUNK97
	-mkdir -p /opt/P/SKUNK97/default /opt/K/SKUNK97 /var/opt/K/SKUNK97
	( cd ./ssoCD ; for i in opt/P/SKUNK97/default/5.0; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK97/*; do \
		mkdir -p /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK97/*/*; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )

# just a quick fix, for stuff we know we need to tweak ...
# dont run this on a readonly ssoCD 
fixup_perms fp quickfix: 
	find ./ssoCD -name "ccs" -exec chmod +x {} \;  
	chmod +x ./ssoCD/opt/K/SKUNK97/Xmcd/2.1/libdi.d/configure.sh 

# this is not quick at all ...
# and you must be root, should be done after a "make export" 
# and before make enable
fixall fix_all fixperms fixperm: 
	custom -p SKUNK97:default -v quick -x >/dev/null

# to test the prd database file
parse.prd parse prd :
	CDMT_DIR=$(HERE) cdmtParse -prd input/default.prd  $(CFG) 

# after a compress and parse
archCD : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)
arch : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

CMPNTS=\
./dist/x11/graphics/SkunkPix-1.0/input/Pix.cmpnt \
./dist/x11/graphics/gimp-0.99.10/input/Gimp.cmpnt \
./dist/x11/graphics/ImageMagick-3.8.8/input/IMGCK.cmpnt \
./dist/x11/savers/xlockmore-4.03/input/Xlock.cmpnt \
./dist/x11/savers/xscreensaver-2.06/input/Xsaver.cmpnt \
./dist/x11/apps/xfilemanager-0.4.1/input/XFM.cmpnt \
./dist/x11/apps/xinvest-2.4/input/Xinvest.cmpnt \
./dist/x11/apps/xsw-5.0.4/input/Xsw.cmpnt \
./dist/x11/apps/xtar-1.4/input/Xtar.cmpnt \
./dist/x11/apps/xquote-1.0.2/input/Xquote.cmpnt \
./dist/x11/games/xblackjack-2.2/input/Xbj.cmpnt \
./dist/x11/games/xboing-2.4/input/Xboing.cmpnt \
./dist/x11/games/xgalaga-1.6c/input/Xgal.cmpnt \
./dist/x11/games/xlincity-1.06/input/Xlincity.cmpnt \
./dist/x11/misc/rxvt-2.18/input/rxvt.cmpnt \
./dist/x11/misc/xfishtank/input/xfishtank.cmpnt \
./dist/x11/misc/astrolog-5.30/input/Astrolog.cmpnt \
./dist/x11/misc/xsnow-1.40/input/Xsnow.cmpnt \
./dist/x11/misc/xtartan-2.3/input/Xtartan.cmpnt \
./dist/x11/misc/xdaliclock-2.10/input/Xdaliclock.cmpnt \
./dist/x11/misc/xkeycaps-2.38/input/Xkey.cmpnt \
./dist/x11/viewers/ghostview-1.5/input/Ghostview.cmpnt \
./dist/x11/viewers/xpdf-0.7/input/Xpdf.cmpnt \
./dist/x11/viewers/xanim27064/input/Xanim.cmpnt \
./dist/x11/winman/AfterStep-1.0/input/ASTP.cmpnt \
./dist/textproc/gs5.02/input/GS.cmpnt \
./dist/fileutil/gifutils-1.0/input/gifutils.cmpnt \
./dist/shellutil/unzip-5.3/input/Unzip.cmpnt \
./dist/shellutil/zip-2.1/input/Zip.cmpnt \
./dist/net/Mosaic-2.7b4/input/Mosaic.cmpnt \
./dist/net/lynx2-7-1/input/Lynx.cmpnt \
./dist/net/ncftp-2.4.2/input/Ncftp.cmpnt \
./dist/textproc/sgml-tools-0.99.14/input/sgmltools.cmpnt \
./dist/net/wu-ftpd-2.4/input/wuftpd.cmpnt \
./dist/devtools/gcc-2.7.2.1/input/Gcc.cmpnt \
./dist/shellutil/gzip-1.2.4/input/GZIP.cmpnt \
./dist/fileutil/git-4.3.15/input/Git.cmpnt \
./dist/devtools/autoconf-2.12/input/Autoconf.cmpnt \
./dist/shells/bash-2.01/input/Bash.cmpnt \
./dist/devtools/bison-1.25/input/Bison.cmpnt \
./dist/fileutil/cpio-2.4.2/input/Cpio.cmpnt \
./dist/devtools/cvs-1.9/input/Cvs.cmpnt \
./dist/fileutil/diffutils-2.7/input/Diffutils.cmpnt \
./dist/fileutil/fileutils-3.15/input/Fileutils.cmpnt \
./dist/fileutil/findutils-4.1/input/Findutils.cmpnt \
./dist/devtools/flex-2.5.4/input/Flex.cmpnt \
./dist/shellutil/gawk-3.0.3/input/Gawk.cmpnt \
./dist/textproc/groff-1.10/input/Groff.cmpnt \
./dist/devtools/indent-1.9.1/input/Indent.cmpnt \
./dist/shellutil/less-332/input/Less.cmpnt \
./dist/shellutil/m4-1.4/input/M4.cmpnt \
./dist/devtools/make-3.75/input/Make.cmpnt \
./dist/fileutil/mtools-3.6/input/Mtools.cmpnt \
./dist/devtools/patch-2.4/input/Patch.cmpnt \
./dist/interp/python-1.4/input/Python.cmpnt \
./dist/devtools/rcs-5.7/input/Rcs.cmpnt \
./dist/libraries/readline-2.1/input/Readline.cmpnt \
./dist/shellutil/sh-utils-1.15/input/Shutils.cmpnt \
./dist/fileutil/tar-1.12/input/Tar.cmpnt \
./dist/textproc/texinfo-3.11/input/Texinfo.cmpnt \
./dist/shells/zsh-3.1.2/input/Zsh.cmpnt \
./dist/devtools/mkpkg-1.0/input/Mkpkg.cmpnt \
./dist/fileutil/makecd-1.0/input/MakeCD.cmpnt \
./dist/interp/tclX7.6.0/input/TclX.cmpnt \
./dist/interp/expect5.22/input/Expect.cmpnt \
./dist/interp/tcl7.6p2/input/Tcl.cmpnt \
./dist/interp/tk4.2p2/input/TK.cmpnt \
./dist/libraries/pthreads-1.60b5/input/Pthrds.cmpnt \
./dist/libraries/Glib-1.0/input/Glib.cmpnt \
./dist/libraries/Gutil-1.0/input/Gutil.cmpnt \
./dist/net/zircon-1.17p1/input/Zircon.cmpnt \
./dist/net/apache-1.2.1/input/Apache.cmpnt \
./dist/net/freeWAIS-sf-2.1/input/freeWAIS.cmpnt \
./dist/interp/perl-5.003/input/Perl5.cmpnt \
./dist/editors/ashe-1.3/input/XHTML.cmpnt \
./dist/net/xarchie-2.0.10/input/Xarchie.cmpnt \
./dist/net/xdir-2.0/input/XDir.cmpnt \
./dist/x11/graphics/xfig-3.2/input/Xfig.cmpnt \
./dist/audio/maplay-1.2/input/Maplay.cmpnt \
./dist/audio/sox-11.12/input/Sox.cmpnt \
./dist/audio/timidity-0.2i/input/Midi.cmpnt \
./dist/audio/xmmix-1.2/input/XMmix.cmpnt \
./dist/audio/xmcd-2.1/input/Xmcd.cmpnt \
./dist/x11/apps/xmorph-17jan97/input/Xmorph.cmpnt \
./dist/x11/viewers/xv-3.10a/input/XV.cmpnt \
./dist/video/mpeg_play-2.3/input/Mpeg_play.cmpnt \
./dist/video/mpeg_bits-1.0b/input/Mpeg_bits.cmpnt \
./dist/video/mpeg_blocks-1.0b/input/Mpeg_blocks.cmpnt \
./dist/video/mpeg_encode-1.5b/input/Mpeg_encode.cmpnt \
./dist/video/mpeg_stat-2.2b/input/Mpeg_stat.cmpnt
#./dist/misc/netpbm/input/Netpbm.cmpnt
#./dist/lib/xpm-3.4j/input/Xpm.cmpnt
#./dist/lib/Mesa-2.3/input/Mesa.cmpnt
#./dist/lib/gd1.2/input/GD.cmpnt

.PRECIOUS:$(CMPNTS)
$(CMPNTS) : cdmt.config 
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
	custom -p SKUNK97:default -d SKUNK97:Xmcd
	custom -p SKUNK97:default -r SKUNK97:Xmcd 
	custom -p SKUNK97:default -L SKUNK97:Xmcd -z $(HERE)/archives/TAPE
	custom -p SKUNK97:default -e SKUNK97:Xmcd
gds_try : 
	custom -p SKUNK97:default -d SKUNK97:gds
	custom -p SKUNK97:default -r SKUNK97:gds 
	custom -p SKUNK97:default -L SKUNK97:gds -z $(HERE)/archives/TAPE
	custom -p SKUNK97:default -e SKUNK97:gds
groff_try : 
	custom -p SKUNK97:default -d SKUNK97:groff
	custom -p SKUNK97:default -r SKUNK97:groff 
	custom -p SKUNK97:default -L SKUNK97:groff -z $(HERE)/archives/TAPE
	custom -p SKUNK97:default -e SKUNK97:groff

individual: make_ind.sh
	sh make_ind.sh $(CMPNTS)
