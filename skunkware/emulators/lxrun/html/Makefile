#
# Makefile for generation of various file formats from lxrun.sgml
#
# Written April, 1998 by Ronald Joe Record (rr@sco.com)

# Select which formats you want output
# Choose one or more of html ps txt info rtf tex dvi

ALL=html ps txt info rtf tex dvi

# Select which paper size you want. Options are letter and a4

PAPEROPT=--papersize=letter

# If you want debug output (intermediate files are not removed),
# set this to --debug 

DEBUG=

# If you want to include the more detailed getting started and syscall table
# in the output, set this to "-D version=online". If you want the more
# abbreviated output, leave it set to "-D version=usenix". The exact syntax
# of this type of conditional may vary from version to version of SGML-Tools.

VERSION=-D version=usenix

# This is the SGML source document to process

SRCDOC=../lxrun.sgml

MKDIR=mkdir
RM=rm -rf

all: $(ALL)

html: html/lxrun.html

html/lxrun.html: lxrun.sgml
	-$(RM) html
	-$(MKDIR) html
	(cd html; sgml2html $(DEBUG) $(VERSION) $(SRCDOC))

ps: ps/lxrun.ps

ps/lxrun.ps: lxrun.sgml
	-$(RM) ps
	-$(MKDIR) ps
	(cd ps; sgml2latex --output=ps $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC))

txt: txt/lxrun.txt

txt/lxrun.txt: lxrun.sgml
	-$(RM) txt
	-$(MKDIR) txt
	(cd txt; sgml2txt $(MANPAGE) $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC))

info: info/lxrun.info

info/lxrun.info: lxrun.sgml
	-$(RM) info
	-$(MKDIR) info
	(cd info; sgml2info $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC))

rtf: rtf/lxrun.rtf

rtf/lxrun.rtf: lxrun.sgml
	-$(RM) rtf
	-$(MKDIR) rtf
	(cd rtf; sgml2rtf $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC))

dvi: dvi/lxrun.dvi

dvi/lxrun.dvi: lxrun.sgml
	-$(RM) dvi
	-$(MKDIR) dvi
	(cd dvi; sgml2latex --output=dvi $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC))

tex: tex/lxrun.tex

tex/lxrun.tex: lxrun.sgml
	-$(RM) tex
	-$(MKDIR) tex
	(cd tex; sgml2latex --output=tex $(DEBUG) $(VERSION) $(PAPEROPT) $(SRCDOC))

# In case you prefer the HTML formatting of the latex2html translator
# by Nikos Drakos (note default HTML output is sgml2html from SGML-Tools
latex2html: latex2html/lxrun.html

latex2html/lxrun.html: tex/lxrun.tex
	-$(RM) latex2html
	latex2html -dir latex2html tex/lxrun.tex

# The online rule produces a more detailed HTML output
online: online/lxrun.html

online/lxrun.html: lxrun.sgml
	-$(RM) online
	-$(MKDIR) online
	(cd online; sgml2html $(VERSION) -D version=online $(SRCDOC))

# The test rule produces a simple test postscript output
test: test/test.sgml
	(cd test; sgml2latex --output=ps --debug $(PAPEROPT) test.sgml)

log: clean
	$(MAKE) all > log 2>&1

clean:
	rm -rf html ps rtf info txt tex dvi log online test

debug:
	rm -rf ps
	$(MAKE) ps DEBUG=--debug

