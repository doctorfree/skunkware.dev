#
# Makefile for generating the ON-LINE pages
#

PAGES=devtools.html editors.html relnotes.html shells.html shutils.html \
	index_web.html x11winman.html x11.html x11viewers.html textproc.html \
	fileutil.html interp.html x11apps.html x11games.html x11servers.html \
	mailnews.html net.html audiovis.html packages_a.html credits.html \
	links.html index_cd.html sysadmin.html packages_p.html emulators.html \
        java.html uw7.html faq.html whatsnew.html

TOPAGES=packages_p.html relnotes.html index_web.html packages_a.html \
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
	( cd ../.. ; rm -f index.html ; ln -s index_web.html index.html )

clean:
	rm -f $(PAGES)
	rm -f *.bak *~ ../src/*~

devtools.html: ../src/devtools.tmpl
	../util/genskunk web ../src/devtools devtools packages_a emulators/emulators /skunkware

emulators.html: ../src/emulators.tmpl
	../util/genskunk web ../src/emulators emulators devtools/devtools editors/editors /skunkware

editors.html: ../src/editors.tmpl
	../util/genskunk web ../src/editors editors emulators/emulators shells/shells /skunkware

relnotes.html: ../src/relnotes.tmpl
	../util/genskunk web ../src/relnotes relnotes NONE devtools/devtools /skunkware

shells.html: ../src/shells.tmpl
	../util/genskunk web ../src/shells shells editors/editors shutils/shutils /skunkware

shutils.html: ../src/shutils.tmpl
	../util/genskunk web ../src/shutils shutils shells/shells x11/winman/winman /skunkware

whatsnew.html: ../src/whatsnew.tmpl
	../util/genskunk web ../src/whatsnew whatsnew NONE NONE .

faq.html: ../src/faq.tmpl
	../util/genskunk web ../src/faq faq NONE NONE .

index_web.html: ../src/sk97home.tmpl
	@rm -f index_web.html
	../util/genskunk web ../src/sk97home sk97home NONE NONE /skunkware
	@mv sk97home.html index_web.html

index_cd.html: ../src/sk97home.tmpl
	@rm -f index_cd.html
	../util/genskunk cd ../src/sk97home sk97home NONE NONE /skunkware
	@mv sk97home.html index_cd.html

x11winman.html: ../src/x11winman.tmpl
	../util/genskunk web ../src/x11winman x11winman shutils/shutils x11/viewers/viewers /skunkware

x11.html: ../src/x11.tmpl
	../util/genskunk web ../src/x11 x11 x11/winman/winman textproc/textproc /skunkware

x11viewers.html: ../src/x11viewers.tmpl
	../util/genskunk web ../src/x11viewers x11viewers x11/winman/winman textproc/textproc /skunkware

textproc.html: ../src/textproc.tmpl
	../util/genskunk web ../src/textproc textproc x11/viewers/viewers fileutil/fileutil /skunkware

fileutil.html: ../src/fileutil.tmpl
	../util/genskunk web ../src/fileutil fileutil textproc/textproc interp/interp /skunkware

interp.html: ../src/interp.tmpl
	../util/genskunk web ../src/interp interp fileutil/fileutil x11/apps/apps /skunkware

x11apps.html: ../src/x11apps.tmpl
	../util/genskunk web ../src/x11apps x11apps interp/interp x11/games/games /skunkware

x11games.html: ../src/x11games.tmpl
	../util/genskunk web ../src/x11games x11games x11/apps/apps x11/servers/servers /skunkware

x11servers.html: ../src/x11servers.tmpl
	../util/genskunk web ../src/x11servers x11servers x11/games/games mailnews/mailnews /skunkware

mailnews.html: ../src/mailnews.tmpl
	../util/genskunk web ../src/mailnews mailnews x11/servers/servers net/net /skunkware

net.html: ../src/net.tmpl
	../util/genskunk web ../src/net net x11/games/games audiovis/audiovis /skunkware

audiovis.html: ../src/audiovis.tmpl
	../util/genskunk web ../src/audiovis audiovis net/net sysadmin/sysadmin /skunkware

sysadmin.html: ../src/sysadmin.tmpl
	../util/genskunk web ../src/sysadmin sysadmin audiovis/audiovis packages_a /skunkware

packages_a.html: ../src/packages_a.tmpl
	../util/genskunk web ../src/packages_a packages_a audiovis/audiovis devtools/devtools /skunkware

packages_p.html: ../src/packages_p.tmpl
	../util/genskunk web ../src/packages_p packages_p audiovis/audiovis uw7/uw7 /skunkware

java.html: ../src/java.tmpl
	../util/genskunk web ../src/java java packages_p uw7/uw7 /skunkware

uw7.html: ../src/uw7.tmpl
	../util/genskunk web ../src/uw7 uw7 java/java devtools/devtools /skunkware

links.html: ../src/links.tmpl
	../util/genskunk web ../src/links links index credits /skunkware

credits.html: ../src/credits.tmpl
	../util/genskunk web ../src/credits credits packages_a devtools/devtools /skunkware

