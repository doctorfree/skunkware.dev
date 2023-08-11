#
# Makefile for generation of various file formats from SGML documents
#
# Written April, 1998 by Ronald Joe Record (rr@sco.com)

# Select which document you want formatted
# Choose between scoworld-one and scoworld-two

SCOWORLD=scoworld-two

# Select which formats you want output
# Choose one or more of html ps txt info rtf tex dvi

ALL=html ps rtf dvi

# Select which paper size you want. Options are letter and a4

#PAPEROPT=--papersize=letter
PAPEROPT=

# If you want debug output (intermediate files are not removed),
# set this to --debug 

DEBUG=

# If you want to include the more detailed getting started and syscall table
# in the output, set this to "-D version=online". If you want the more
# abbreviated output, leave it set to "-D version=usenix". The exact syntax
# of this type of conditional may vary from version to version of SGML-Tools.

VERSION=

# This is the SGML source document to process

SRCDOC1=../$(SCOWORLD).sgml
SRCDOC2=../lxrun.sgml
SRCDOC3=../example.sgml

MKDIR=mkdir
RM=rm -f

all: $(ALL)

html: html/$(SCOWORLD).html

html/$(SCOWORLD).html: $(SCOWORLD).sgml
	[ -d html ] || $(MKDIR) html
	-$(RM) html/$(SCOWORLD)*.html
	(cd html; sgmltools -b html $(DEBUG) $(VERSION) $(SRCDOC1))

html/lxrun.html: lxrun.sgml
	[ -d html ] || $(MKDIR) html
	-$(RM) html/lxrun*.html
	(cd html; sgmltools -b html $(DEBUG) $(VERSION) $(SRCDOC2))

html/example.html: example.sgml
	[ -d html ] || $(MKDIR) html
	-$(RM) html/example*.html
	(cd html; sgmltools -b html $(DEBUG) $(VERSION) $(SRCDOC3))

ps: ps/$(SCOWORLD).ps

ps/$(SCOWORLD).ps: $(SCOWORLD).sgml
	[ -d ps ] || $(MKDIR) ps
	-$(RM) ps/$(SCOWORLD)*
	(cd ps; sgmltools -b ps $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC1))

ps/lxrun.ps: lxrun.sgml
	[ -d ps ] || $(MKDIR) ps
	-$(RM) ps/lxrun*
	(cd ps; sgmltools -b ps $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC2))

ps/example.ps: example.sgml
	[ -d ps ] || $(MKDIR) ps
	-$(RM) ps/example*
	(cd ps; sgmltools -b ps $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC3))

txt: txt/$(SCOWORLD).txt

txt/$(SCOWORLD).txt: $(SCOWORLD).sgml
	[ -d txt ] || $(MKDIR) txt
	-$(RM) txt/$(SCOWORLD)*
	(cd txt; sgml2txt $(MANPAGE) $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC1))

txt/lxrun.txt: lxrun.sgml
	[ -d txt ] || $(MKDIR) txt
	-$(RM) txt/lxrun*
	(cd txt; sgml2txt $(MANPAGE) $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC2))

info: info/$(SCOWORLD).info

info/$(SCOWORLD).info: $(SCOWORLD).sgml
	[ -d info ] || $(MKDIR) info
	-$(RM) info/$(SCOWORLD)*
	(cd info; sgml2info $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC1))

info/lxrun.info: lxrun.sgml
	[ -d info ] || $(MKDIR) info
	-$(RM) info/lxrun*
	(cd info; sgml2info $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC2))

rtf: rtf/$(SCOWORLD).rtf

rtf/$(SCOWORLD).rtf: $(SCOWORLD).sgml
	[ -d rtf ] || $(MKDIR) rtf
	-$(RM) rtf/$(SCOWORLD)*
	(cd rtf; sgml2rtf $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC1))

rtf/lxrun.rtf: lxrun.sgml
	[ -d rtf ] || $(MKDIR) rtf
	-$(RM) rtf/lxrun*
	(cd rtf; sgml2rtf $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC2))

dvi: dvi/$(SCOWORLD).dvi

dvi/$(SCOWORLD).dvi: $(SCOWORLD).sgml
	[ -d dvi ] || $(MKDIR) dvi
	-$(RM) dvi/$(SCOWORLD)*
	(cd dvi; sgml2dvi $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC1))

dvi/lxrun.dvi: lxrun.sgml
	[ -d dvi ] || $(MKDIR) dvi
	-$(RM) dvi/lxrun*
	(cd dvi; sgml2dvi $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC2))

tex: tex/$(SCOWORLD).tex

tex/$(SCOWORLD).tex: $(SCOWORLD).sgml
	[ -d tex ] || $(MKDIR) tex
	-$(RM) tex/$(SCOWORLD)*
	(cd tex; sgml2latex --output=tex $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC1))

tex/lxrun.tex: lxrun.sgml
	[ -d tex ] || $(MKDIR) tex
	-$(RM) tex/lxrun*
	(cd tex; sgml2latex --output=tex $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC2))

# In case you prefer the HTML formatting of the latex2html translator
# by Nikos Drakos (note default HTML output is sgml2html from SGML-Tools
latex2html: latex2html/$(SCOWORLD).html latex2html/lxrun.html

latex2html/$(SCOWORLD).html: tex/$(SCOWORLD).tex
	-$(RM) latex2html/$(SCOWORLD)*
	latex2html -dir latex2html tex/$(SCOWORLD).tex

latex2html/lxrun.html: tex/lxrun.tex
	-$(RM) latex2html/lxrun*
	latex2html -dir latex2html tex/lxrun.tex

# The online rule produces a more detailed HTML output
online: online/$(SCOWORLD).html online/lxrun.html

online/$(SCOWORLD).html: $(SCOWORLD).sgml
	[ -d online ] || $(MKDIR) online
	-$(RM) online/$(SCOWORLD)*
	(cd online; sgml2html $(VERSION) $(SRCDOC1))

online/lxrun.html: lxrun.sgml
	[ -d online ] || $(MKDIR) online
	-$(RM) online/lxrun*
	(cd online; sgml2html $(VERSION) $(SRCDOC2))

# The test rule produces a simple test postscript output
test: test/test.sgml
	(cd test; sgml2ps --debug $(PAPEROPT) test.sgml)

log: clean
	$(MAKE) all 2>&1 | tee log

clean:
	rm -rf html ps rtf info txt tex dvi log online test

debug:
	rm -rf ps
	$(MAKE) ps DEBUG=--debug

