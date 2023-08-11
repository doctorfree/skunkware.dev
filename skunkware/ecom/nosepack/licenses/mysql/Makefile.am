# -*- Makefile -*-

# Normally you do not need to remake the files here. But if you want
# to you will need the GNU texinfo utilities. To make a PostScript
# files you also need TeX and dvips. We use the teTeX distribution for
# both. And for the pdf file you will need pdftex.

# We avoid default automake rules because of problems with .dvi file
# and BSD makes

# If you know how to fix any of this more elegantly please mail
# david@mysql.com

TEXI2HTML_FLAGS =	-iso -number
DVIPS =			dvips
MAKEINFO =		@MAKEINFO@

noinst_SCRIPTS =	texi2html
info_TEXINFOS =		manual.texi

targets =		manual.txt manual.html
BUILT_SOURCES =		$(targets) manual_toc.html include.texi INSTALL-BINARY
EXTRA_DIST =		$(noinst_SCRIPTS) $(BUILT_SOURCES) MySQL-for-dummies mysqld_error.txt

all-local:		$(targets)

# The PostScript version is so big that is not included in the
# standard distribution. It is available for download from the home page.  
paper: manual_a4.ps manual_letter.ps

# The Makefile contains the previous version so we can not use that
include.texi:	../configure.in
	echo -n "@set mysql_version " > $@
	grep "AM_INIT_AUTOMAKE(mysql, " ../configure.in | \
	 sed -e 's;AM_INIT_AUTOMAKE(mysql, ;;' -e 's;);;' >> $@
	echo -n "@set default_port " >> $@
	grep "MYSQL_TCP_PORT_DEFAULT=" ../configure.in | \
	 sed -e 's;MYSQL_TCP_PORT_DEFAULT=;;' >> $@

mysql.info:	manual.texi include.texi
	cd $(srcdir) && $(MAKEINFO) --no-split -I $(srcdir) $<

manual.txt:	manual.texi include.texi
	cd $(srcdir) && \
	$(MAKEINFO) -I $(srcdir) --no-headers --no-split --output $@ $<

manual.html:	manual.texi include.texi $(srcdir)/texi2html
	cd $(srcdir) && @PERL@ texi2html $(TEXI2HTML_FLAGS) $<

# The texi2dvi gives a lot of harmless errors. Just ignore them unless
# you want to help with the typesetting part.
# This is the European papersize version
manual_a4.ps:	manual.texi include.texi
	TEXINPUTS=$(srcdir):$$TEXINPUTS \
	  MAKEINFO='$(MAKEINFO) -I $(srcdir)' \
	    $(TEXI2DVI) --batch --texinfo '@afourpaper' $<
	$(DVIPS) -t a4 manual.dvi -o $@

# This is the American papersize version
manual_letter.ps:	manual.texi include.texi
	TEXINPUTS=$(srcdir):$$TEXINPUTS \
	  MAKEINFO='$(MAKEINFO) -I $(srcdir)' \
	    $(TEXI2DVI) --batch $<
	$(DVIPS) -t letter manual.dvi -o $@

# Include images for the manual in the distribution
dist-hook:
	BD=`cd $(top_srcdir); pwd`; \
	if test ! -d $(distdir)/Img; then mkdir -p $(distdir)/Img; fi; \
	cp -p $(srcdir)/Img/*.gif $(srcdir)/Img/*.eps $(srcdir)/Img/*.txt \
		$(distdir)/Img;
	echo "PostScript and PDF versions suitable for printing" \
		> $(distdir)/manual.ps
	echo "are available from http://www.mysql.com/Manual/" \
		>> $(distdir)/manual.ps
	echo "or any mirror site" \
		>> $(distdir)/manual.ps

####################################################################
# From here everything is only for our automatic website updating. #
####################################################################
if LOCAL

local:		toweb text_files

toweb:		man_to_web wpages text_files

man_to_web:	$(web_images) $(W)/Manual/manual.html $(W)/Manual/html-manual.tar.gz

wpages:		$(texi_wpages) $(texi_readmes) $(gen_wpages) $(raw_wpages) \
		$(htmy_wpages) $(htmy_inc) $(web_images) \
		iwpages

iwpages:	
		perl -w generate-file-index.pl

text_files:	$(txt_files)

# This need updating when the website moves!
BASE	:= /net/www/d3/mysqlwww
W	:= $(BASE)/html
HTMY	:= $(W)/htmy
IMG	:= $(W)/Img
WL	:= $(BASE)/html_login
GW	:= perl -w generate-web-page.pl
GT	:= perl -w generate-text-files.pl
WD	:= SitePages/template1.html SitePages/template2.html generate-web-page.pl
DD	:= /my/masters/mysql/Docs/WWW/html/Downloads

txt_files :=	../INSTALL-SOURCE ../PUBLIC ../WIN-LICENSE ../MIRRORS INSTALL-BINARY

texi_readmes :=	$(W)/Contrib/00-README

texi_wpages :=	$(W)/links.html \
		$(W)/mirrors.html \
		$(W)/users.html \
		$(W)/Contrib/index.html \
		$(W)/what-is-mysql.html \
		$(W)/mysql-intro.html \
		$(W)/mysql-books.html

raw_wpages :=	$(W)/crash-me.html

gen_wpages :=	$(W)/doc.html \
		$(W)/download.html \
		$(W)/download_3.20.html \
		$(W)/download_3.21.html \
		$(W)/download_3.22.html \
		$(W)/download_3.23.html \
		$(W)/download_clients.html \
		$(W)/download_mysql++.html \
		$(W)/download_documents.html \
		$(W)/download_linux.html \
		$(W)/download_myodbc.html \
		$(W)/download_os2.html \
		$(W)/download_perl.html \
		$(W)/download_win.html \
		$(W)/info.html \
		$(W)/mail.html \
		$(W)/news.html \
		$(W)/Icons/index.html \
		$(W)/index.html \
		$(WL)/index.html

htmy_wpages :=	$(HTMY)/brows_feedback.htmy \
		$(HTMY)/browse.htmy \
		$(HTMY)/consults.htmy \
		$(HTMY)/crash-me-choose.htmy \
		$(HTMY)/crash-me-get.htmy \
		$(HTMY)/feedback.htmy \
		$(HTMY)/get_amex.htmy \
		$(HTMY)/get_consults.htmy \
		$(HTMY)/get_feedback.htmy \
		$(HTMY)/get_license.htmy \
		$(HTMY)/get_mysql_w32.htmy \
		$(HTMY)/license.htmy \
		$(HTMY)/mysql_w32.htmy \
		$(HTMY)/consultants_search.htmy \
		$(HTMY)/consultants_search_result.htmy

# mysql-w32.htmy is a symlink to mysql_w32.htmy

# These have special rules below
htmy_inc :=	$(HTMY)/new-header.htmy \
		$(HTMY)/new-trailer.htmy

rweb_images :=	mysql-logo.gif \
		tcxlogo3.gif \
		australia.gif austria.gif bulgaria.gif canada.gif \
		croatia.gif chile.gif czech-republic.gif \
		denmark.gif estonia.gif finland.gif france.gif \
		germany.gif great-britain.gif hungary.gif israel.gif \
		italy.gif japan.gif  netherlands.gif poland.gif \
		portugal.gif romania.gif russia.gif singapore.gif \
		south-africa.gif south-africa1.gif south-korea.gif \
		sweden.gif taiwan.gif usa.gif ukraine.gif \
		greece.gif switzerland.gif china.gif brazil.gif \
		spain.gif iceland.gif ireland.gif

web_images :=	$(addprefix $(IMG)/, $(rweb_images))

$(web_images) : $(IMG)/%.gif : Img/%.gif
	cp $? $@

# Update documentation on web site
$(W)/Manual/manual.html:	manual.texi manual.html \
				manual_a4.ps manual_letter.ps \
				manual.pdf
	cp -f manual.texi texi2html $(W)/Manual
	cp -f manual.html manual_toc.html $(W)/Manual
	cp -f manual_a4.ps manual_letter.ps $(W)/Manual
	cp -f manual.pdf $(W)/Manual
	gzip --best --force $(W)/Manual/*.ps
	WD=`pwd`; cd $(W)/Manual_chapter; \
		perl $$WD/texi2html $(TEXI2HTML_FLAGS) \
		-split_chapter $$WD/manual.texi

$(W)/Manual/html-manual.tar.gz:	manual.html
	cd $(W)/Manual/; gtar --create --gzip --file=$@ --directory=$(W) Manual_chapter

../INSTALL-SOURCE:	mysql.info generate-text-files.pl
	$(GT) $< "Installing" "Compatibility" > $@

INSTALL-BINARY:	mysql.info generate-text-files.pl
	$(GT) $< "Installing binary" "Installing source" > $@

../PUBLIC:	mysql.info generate-text-files.pl
	$(GT) $< "Public license" "Win license" > $@

../WIN-LICENSE:	mysql.info generate-text-files.pl
	$(GT) $< "Win license" "Function Index" > $@

../MIRRORS:	manual.texi generate-text-files.pl generate-mirror-listing.pl
	perl -w generate-mirror-listing.pl $< > $@

$(W)/Contrib/00-README:	mysql.info generate-text-files.pl
	$(GT) $< "Contrib" "Credits" > $@

$(W)/mirrors.html: RawNode/manual_Getting_MySQL.html $(WD)
	$(GW) $< $@ "" Mirrors mirrors.gif "" mirrors1

$(W)/links.html: RawNode/manual_Useful_Links.html $(WD)
	$(GW) $< $@ "" "Links" links.gif "" links1

$(W)/users.html:  RawNode/manual_Users.html $(WD)
	$(GW) $< $@ "" "MySQL Users" none.gif ""

$(W)/what-is-mysql.html: RawNode/manual_What-is.html $(WD)
	$(GW) $< $@ "" "What is MySQL" info.gif ""

$(W)/mysql-intro.html: RawNode/manual_Introduction.html $(WD)
	$(GW) $< $@ "" "MySQL Introduction" none.gif ""

$(W)/mysql-books.html: RawNode/manual_MySQL-Books.html $(WD)
	$(GW) $< $@ "" "MySQL Books" none.gif ""

$(W)/Contrib/index.html: RawNode/manual_Contrib.html $(WD)
	$(GW) $< $@ "" "MySQL Contributed source" none.gif "../"

$(W)/doc.html:		SitePages/doc.html $(WD)
	$(GW) $< $@ "" "MySQL Documentation" doc.gif "" doc1

#
# Here comes the pages that uses information from the files in the
# download directory. Not that dir string (the third arg) is a shell
# glob pattern that should give a list of directories.
#

$(W)/download.html:	SitePages/download.html $(WD)
	$(GW) $< $@ $(DD)"/MySQL-3.22/" "MySQL Downloads" download.gif "" download1

$(W)/download_3.20.html:	SitePages/download_3.20.html $(WD)
	$(GW) $< $@ $(DD)"/MySQL-3.20/" "MySQL 3.20 downloads" download.gif ""

$(W)/download_3.21.html:	SitePages/download_3.21.html $(WD)
	$(GW) $< $@ $(DD)"/MySQL-3.21/" "MySQL 3.21 downloads" download.gif ""

$(W)/download_3.22.html:	SitePages/download_3.22.html $(WD)
	$(GW) $< $@ $(DD)"/MySQL-3.22/" "MySQL 3.22 downloads" download.gif ""

$(W)/download_3.23.html:	SitePages/download_3.23.html $(WD)
	$(GW) $< $@ $(DD)"/MySQL-3.23/" "MySQL 3.23 downloads" download.gif ""

#
# Just normal variables again.
#
 
$(W)/download_clients.html:	SitePages/download_clients.html $(WD)
	$(GW) $< $@ "" "MySQL clients downloads" download.gif ""

$(W)/download_mysql++.html:	SitePages/download_mysql++.html $(WD)
	$(GW) $< $@ "" "MySQL++ C++ API downloads" download.gif ""

$(W)/download_documents.html:	SitePages/download_documents.html $(WD)
	$(GW) $< $@ "" "MySQL documents downloads" download.gif ""

$(W)/download_linux.html:	SitePages/download_linux.html $(WD)
	$(GW) $< $@ "" "MySQL linux downloads" download.gif ""

$(W)/download_myodbc.html:	SitePages/download_myodbc.html $(WD)
	$(GW) $< $@ "" "MySQL ODBC downloads" download.gif ""

$(W)/download_os2.html:	SitePages/download_os2.html $(WD)
	$(GW) $< $@ "" "MySQL OS2 downloads" download.gif ""

$(W)/download_perl.html:	SitePages/download_perl.html $(WD)
	$(GW) $< $@ "" "MySQL perl downloads" download.gif ""

$(W)/download_win.html:	SitePages/download_win.html $(WD)
	$(GW) $< $@ "" "MySQL Windows downloads" download.gif ""

$(W)/info.html:		SitePages/info.html $(WD)
	$(GW) $< $@ "" "MySQL Information" info.gif "" info1

$(W)/mail.html:		SitePages/mail.html $(WD)
	$(GW) $< $@ "" "Contacting us" none.gif ""

$(W)/news.html:		SitePages/news.html $(WD)
	$(GW) $< $@ "" "MySQL News" news.gif "" news1

$(W)/Icons/index.html:	SitePages/icon-index.html $(WD)
	$(GW) $< $@ "" "MySQL Icons" none.gif "../"

$(WL)/index.html:	SitePages/login-index.html $(WD)
	$(GW) $< $@ "" "MySQL for license/support customers" none.gif \
	"http://www.mysql.com/"

# This is also generated by the A-run-by-cron script
$(W)/index.html:	SitePages/main-index.html generate-web-page.pl
	$(GW) $< $@ "" "" "" "" "" "no_template"

$(HTMY)/new-header.htmy:	SitePages/template1.html generate-htmy-includes.pl
	perl -w generate-htmy-includes.pl $< $@

$(HTMY)/new-trailer.htmy:	SitePages/template2.html generate-htmy-includes.pl
	perl -w generate-htmy-includes.pl $< $@

$(htmy_wpages) : $(HTMY)/%.htmy : SitePages/%.htmy
	cp $< $@

$(raw_wpages) : $(W)/%.html : SitePages/%.html
	cp $< $@

# Fix: add --output-comment with some interesting info?
# Fix: remove the rsh when we have pdftex locally
# Fix: Error checking ...
# Fix: @image worked with a older version of pdftex. 
# Comment: We need to run pdftex 2 times to get the cross references right.
manual.pdf: manual.texi
	cat manual.texi | sed -e 's|@image{[^}]*} *||g' | rsh www2 -l mysql "cat > PDF-TeX-work/manual.texi"
	rcp include.texi mysql@www2:PDF-TeX-work/include.texi
	rcp Img/*.pdf mysql@www2:PDF-TeX-work/Img
	rsh www2 -l mysql "cd PDF-TeX-work; pdftex --interaction=nonstopmode '\input manual.texi'; pdftex --interaction=nonstopmode '\pdfcompresslevel=9' '\input manual.texi'"
	rcp mysql@www2:PDF-TeX-work/manual.pdf .

RawNode/%.html:	manual.texi texi2html
	if test ! -d RawNode; then mkdir RawNode; fi; \
	cd RawNode; rm -f *.html; \
	perl ../texi2html -Dweb -iso -split_node -empty_headers \
		-special_links "Manual_chapter/" ../manual.texi

endif
