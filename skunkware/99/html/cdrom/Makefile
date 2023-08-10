#
# Makefile for generating the CD-ROM pages
#

PAGES=devtools.html editors.html relnotes.html shells.html shutils.html \
	index_web.html x11winman.html x11.html x11viewers.html textproc.html \
	fileutil.html interp.html x11apps.html x11games.html x11servers.html \
	mailnews.html net.html audiovis.html packages_a.html credits.html \
	links.html index_cd.html sysadmin.html emulators.html \
        java.html uw7.html faq.html whatsnew.html

TOPAGES=relnotes.html index_web.html packages_a.html \
	links.html credits.html index_cd.html faq.html whatsnew.html

DIRS=sysadmin devtools editors shells shutils \
	x11/winman x11 x11/viewers x11/apps x11/games x11/servers textproc \
	fileutil interp mailnews net audiovis emulators uw7 java

all: $(PAGES)

install: all
	( for d in $(DIRS) ; do \
	  [ -d ../../$$d ] || mkdir ../../$$d ; \
	  [ -h ../../$$d/gif ] && rm -f ../../$$d/gif ; \
	  b=`echo $$d | sed -e "s/\///"` ; \
	  rm -f ../../$$d/index.html ; \
	  echo "cp $$b.html ../../$$d/index.html" ; \
	  cp $$b.html ../../$$d/index.html ; \
	  H=`pwd` ; \
	  cd ../../$$d ; \
	  ln -s ../gif gif ; \
	  rm -f $$b.html ; \
	  echo "ln -s index.html $$b.html" ; \
	  ln -s index.html $$b.html ; \
	  cd $$H ; \
	  done )
	( for p in $(TOPAGES) ; do \
	  rm -f ../../$$p ; \
	  echo "cp $$p ../../$$p" ; \
	  cp $$p ../../$$p ; \
	  done )
	( for g in ../gif/* ; do \
	  [ -d ../../gif ] || mkdir ../../gif ; \
	  rm -f ../$$g ; \
	  echo "cp $$g ../$$g" ; \
	  cp $$g ../$$g ; \
	  done )
	( cd ../.. ; rm -f index.html ; ln -s index_cd.html index.html )

clean:
	rm -f $(PAGES)
	rm -f *.bak *~ ../src/*~

devtools.html: ../src/devtools.tmpl
	../util/genskunk cd ../src/devtools devtools packages_a emulators/emulators ..

emulators.html: ../src/emulators.tmpl
	../util/genskunk cd ../src/emulators emulators devtools/devtools editors/editors ..

editors.html: ../src/editors.tmpl
	../util/genskunk cd ../src/editors editors emulators/emulators shells/shells ..

relnotes.html: ../src/relnotes.tmpl
	../util/genskunk cd ../src/relnotes relnotes NONE devtools/devtools .

shells.html: ../src/shells.tmpl
	../util/genskunk cd ../src/shells shells editors/editors shutils/shutils ..

shutils.html: ../src/shutils.tmpl
	../util/genskunk cd ../src/shutils shutils shells/shells x11/winman/winman ..

faq.html: ../src/faq.tmpl
	../util/genskunk cd ../src/faq faq NONE NONE .

index_web.html: ../src/sk97home.tmpl
	@rm -f index_web.html
	../util/genskunk web ../src/sk97home sk97home NONE NONE .
	@mv sk97home.html index_web.html

index_cd.html: ../src/sk97home.tmpl
	@rm -f index_cd.html
	../util/genskunk cd ../src/sk97home sk97home NONE NONE .
	@mv sk97home.html index_cd.html

x11winman.html: ../src/x11winman.tmpl
	../util/genskunk cd ../src/x11winman x11winman shutils/shutils x11/viewers/viewers ../..

x11.html: ../src/x11.tmpl
	../util/genskunk cd ../src/x11 x11 x11/winman/winman textproc/textproc ..

x11viewers.html: ../src/x11viewers.tmpl
	../util/genskunk cd ../src/x11viewers x11viewers x11/winman/winman textproc/textproc ../..

textproc.html: ../src/textproc.tmpl
	../util/genskunk cd ../src/textproc textproc x11/viewers/viewers fileutil/fileutil ..

fileutil.html: ../src/fileutil.tmpl
	../util/genskunk cd ../src/fileutil fileutil textproc/textproc interp/interp ..

interp.html: ../src/interp.tmpl
	../util/genskunk cd ../src/interp interp fileutil/fileutil x11/apps/apps ..

x11apps.html: ../src/x11apps.tmpl
	../util/genskunk cd ../src/x11apps x11apps interp/interp x11/games/games ../..

x11games.html: ../src/x11games.tmpl
	../util/genskunk cd ../src/x11games x11games x11/apps/apps x11/servers/servers ../..

x11servers.html: ../src/x11servers.tmpl
	../util/genskunk cd ../src/x11servers x11servers x11/games/games mailnews/mailnews ../..

mailnews.html: ../src/mailnews.tmpl
	../util/genskunk cd ../src/mailnews mailnews x11/servers/servers net/net ..

net.html: ../src/net.tmpl
	../util/genskunk cd ../src/net net x11/games/games audiovis/audiovis ..

audiovis.html: ../src/audiovis.tmpl
	../util/genskunk cd ../src/audiovis audiovis net/net sysadmin/sysadmin ..

sysadmin.html: ../src/sysadmin.tmpl
	../util/genskunk cd ../src/sysadmin sysadmin audiovis/audiovis packages_a ..

packages_a.html: ../src/packages_a.tmpl
	../util/genskunk cd ../src/packages_a packages_a audiovis/audiovis devtools/devtools .

java.html: ../src/java.tmpl
	../util/genskunk cd ../src/java java packages_a uw7/uw7 ..

uw7.html: ../src/uw7.tmpl
	../util/genskunk cd ../src/uw7 uw7 java/java devtools/devtools ..

links.html: ../src/links.tmpl
	../util/genskunk cd ../src/links links index credits .

whatsnew.html: ../src/whatsnew.tmpl
	../util/genskunk cd ../src/whatsnew whatsnew index credits .

credits.html: ../src/credits.tmpl
	../util/genskunk cd ../src/credits credits packages_a devtools/devtools .

