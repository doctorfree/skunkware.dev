#! /usr/bin/metapkg -p
# mkcdmt control file for package: extshells
#
# Requires at least version 2.0.1 of MetaPKG
want (2,0,1);
# Requires version 1.0.5 or later of the CDMT backend
want ("cdmt", 1, 0, 5);
# Requires version 1.0.1 or later of the PKGADD backend
want ("pkgadd", 1, 0, 1);


define ("VIMVER", "6.3.0");
define ("VERSUFFIX", "Fa");
define ("XORGVER", "6.8.2");
define ("VIMDESC", "VIM - Vi IMproved");
define ("GWXDESC", "Supplemental Graphics, Web and X11 Libraries");
define ("XORGFONTSDESC", "X.org X11R${XORGVER} Core Fonts");
define ("XORGRTDESC", "X.org X11R${XORGVER} Runtime");

set ("product-code", "VIM");
set ("component-code", "vim");
set ("description", "${VIMDESC}");
set ("version", "${VIMVER}${VERSUFFIX}");
set ("component-mode", 0);
set ("flat-mode", 1);

ifndef ("VIMOS")
  error ("VIMOS not set - must be one of OSR5, OSR6 or UW7");
endif

ifeq ("VIMOS", "OSR5")
  define ("VIMOK", "1");
  define ("DEPVENDOR", "SCO:");
endif

ifeq ("VIMOS", "OSR6")
  define ("VIMOK", "1");
  define ("DEPVENDOR", "SCO:");
endif

ifeq ("VIMOS", "UW7")
  define ("VIMOK", "1");
  backend ("pkgadd");
  set ("pkgadd-category", "application");
  define ("PKGADD", "1");
  define ("DEPVENDOR", "");
  define ("FONTSNM", "xorgfonts");
  define ("XORGRTNM", "xorgrt");
else
  backend ("cdmt");
  define ("FONTSNM", "XORGFonts");
  define ("XORGRTNM", "XORGRT");
endif

ifndef ("VIMOK")
  error ("VIMOS=${VIMOS} not recognised - must be one of OSR5, OSR6 or UW7");
endif


prepare ("Setting up") {
  script ("@@@@",
@@@@
BINDIR=usr/bin
MAN1DIR=usr/man/man1

if [ -e $BINDIR/evview ]; then
  mv $BINDIR/evview $BINDIR/eview
fi

if [ -e $BINDIR/gvview ]; then
  mv $BINDIR/gvview $BINDIR/gview
fi

if [ -e $BINDIR/rgvview ]; then
  mv $BINDIR/rgvview $BINDIR/rgview
fi

if [ -e $BINDIR/rvview ]; then
  mv $BINDIR/rvview $BINDIR/rview
fi

if [ -e $MAN1DIR/evview.1 ]; then
  mv $MAN1DIR/evview.1 $MAN1DIR/eview.1
fi

if [ -e $MAN1DIR/gvview.1 ]; then
  mv $MAN1DIR/gvview.1 $MAN1DIR/gview.1
fi

if [ -e $MAN1DIR/rgvview.1 ]; then
  mv $MAN1DIR/rgvview.1 $MAN1DIR/rgview.1
fi

if [ -e $MAN1DIR/rvview.1 ]; then
  mv $MAN1DIR/rvview.1 $MAN1DIR/rview.1
fi

@@@@ );
  auto_strip (TRUE, TRUE);
  auto_compress_texinfo ();
  auto_format_mansource ();
}

package ("/", "${METAPKG_DESCRIPTION}", "VIM") {
}

component ("vim", "${METAPKG_VERSION}", "${METAPKG_DESCRIPTION}") {
  subpackage ("VIM");
  upgrades ("^6\\\\.1\\\\..*");
  upgrades ("^6\\\\.2\\\\.0.*");
  upgrades ("^6\\\\.2\\\\.0.*");
  upgrades ("^6\\\\.3\\\\.0[A-E][a-z]");
  dependency ("${DEPVENDOR}${XORGRTNM}", "${XORGRTDESC}");
  dependency ("${DEPVENDOR}${FONTSNM}", "${XORGFONTSDESC}");
  dependency ("${DEPVENDOR}gwxlibs", "${GWXDESC}");
}
