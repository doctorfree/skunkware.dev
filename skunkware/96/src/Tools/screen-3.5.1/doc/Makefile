# Generated automatically from Makefile.in by configure.
# Makefile for Screen documentation

srcdir = .
VPATH = .

prefix = /usr/local
infodir = $(prefix)/info

INSTALL = cp
INSTALL_DATA = $(INSTALL)
MAKEINFO = makeinfo
TEXI2DVI = texi2dvi

SHELL = /bin/sh

all: 

dvi screen.dvi: screen.texinfo mostlyclean
	$(TEXI2DVI) $(srcdir)/screen.texinfo

info screen.info: screen.texinfo
	$(MAKEINFO) $(srcdir)/screen.texinfo -o screen.info

install: screen.info
	-if test -f foo.info; then d=.; else d=$(srcdir); fi; \
	-for f in $$d/screen.info*; do $(INSTALL_DATA) $$f $(infodir)/$$f;done \
	if install-info --version >/dev/null 2>&1; then \
	  install-info --infodir=$(infodir) $$d/foo.info; \
	else true; fi
	
uninstall:
	rm -f $(infodir)/screen.info*

mostlyclean:
	-rm -f *.cp *.cps *.fn *.fns *.ky *.kys *.pg *.tp *.vr
	-rm -f *.log *.aux *.toc *~

clean distclean realclean clobber: mostlyclean
	-rm -f *.dvi
	-rm -f *.info*

check installcheck:

