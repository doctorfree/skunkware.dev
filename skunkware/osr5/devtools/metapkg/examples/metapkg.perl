#! /usr/bin/metapkg -p
# mkcdmt control file for package: perl

# Requires at least version 2.0.1 of MetaPKG
want (2,0,1);
# Requires version 1.0.45or later of the CDMT backend
want ("cdmt", 1, 0, 5);
# Requires version 1.0.1 or later of the PKGADD backend
want ("pkgadd", 1, 0, 1);

define ("PERLVER", "5.8.7");
define ("VERSUFFIX", "Ba");
define ("PERLREL", "5.8");
define ("GWXDESC", "Supplemental Graphics, Web and X11 Libraries");
define ("PERLDESC", "Perl ${PERLVER}");
define ("PERLEXTDESC", "${PERLDESC} Extensions");

# Set various command line options
set ("product-code", "Perl");
set ("description", "${PERLDESC}");
set ("version", "${PERLVER}${VERSUFFIX}");
set ("component-mode", 1);
set ("all-early", 1);

ifndef ("PERLOS")
  error ("PERLOS not set - must be one of OSR5, OSR6 or UW7");
endif

ifeq ("PERLOS", "OSR5")
  define ("PERLOK", "1");
  define ("DEPVENDOR", "SCO:");
endif

ifeq ("PERLOS", "OSR6")
  define ("PERLOK", "1");
  define ("DEPVENDOR", "SCO:");
endif

ifeq ("PERLOS", "UW7")
  define ("PERLOK", "1");
  backend ("pkgadd");
  set ("pkgadd-category", "application");
  define ("PKGADD", "1");
  define ("DEPVENDOR", "");
else
  backend ("cdmt");
  set ("dont-harden-symlinks", 0);
  set ("dont-export-symlinks", 0);
endif

ifeq ("PERLOS", "OSR5")
  define ("PERLARCH", "i586-pc-sco3.2v5.0");
else
  define ("PERLARCH", "i586-pc-sysv5");
endif

ifneq ("PERLOK", "1")
  error ("PERLOS=${PERLOS} not recognised - must be one of OSR5, OSR6 or UW7");
endif

prepare ("Setting up") {
  script ("@@@@",
@@@@
origpwd=`pwd`

[ -z "$HANDOFFS" ] && {
  echo "ERROR: HANDOFFS environment variable not set. This must be set to"
  echo "       the directory that contains the common CQS/CCS scripts."
  exit 1
}

[ "$PERLOS" = "OSR5" ] && {
  for d in perl perlext; do
    [ -d $d/cntl ] || {
      mkdir $d/cntl
      cp -f $HANDOFFS/common/cqs.osr5 $d/cntl/cqs
      cp -f $HANDOFFS/common/badver.osr5 $d/cntl/badver
      cp -f $HANDOFFS/common/need646 $d/cntl/need646
      cp -f $HANDOFFS/common/needMP3 $d/cntl/needMP3
      chmod 755 $d/cntl/cqs $d/cntl/badver $d/cntl/need646 $d/cntl/needMP3
    }
  done
}

[ "$PERLOS" = "OSR6" ] && {
  for d in perl perlext; do
    [ -d $d/cntl ] || {
      mkdir $d/cntl
      cp -f $HANDOFFS/common/cqs.osr6 $d/cntl/cqs
      cp -f $HANDOFFS/common/badver.osr6 $d/cntl/badver
      chmod 755 $d/cntl/cqs $d/cntl/badver
    }
  done
}

do_desc() {
[ -n "$DEBUG" ] && set -x
  [ -f $1/cntl/cmpnt.desc ] || {
    cat > $1/cntl/cmpnt.desc <<EOF
CMPNTCHECK=$1
CMPNTNAME=$1
CMPNTDESC="$2"
EOF
    chmod 444 $1/cntl/cmpnt.desc
  }
}

[ "$PERLOS" = "UW7" ] || {
  do_desc perl "$PERLDESC"
  do_desc perlext "$PERLEXTDESC"
}

#
# Avoid a file namespace conflict
#
if [ -f perl/usr/man/man3/threads.3 ]; then
  mv -f perl/usr/man/man3/threads.3 perl/usr/man/man3/perlthreads.3
fi

if [ -f perl/usr/man/man3/threads.3.Z ]; then
  mv -f perl/usr/man/man3/threads.3.Z perl/usr/man/man3/perlthreads.3.Z
fi

if [ -f perl/usr/man/cat3/threads.3 ]; then
  mv -f perl/usr/man/cat3/threads.3 perl/usr/man/cat3/perlthreads.3
fi

if [ -f perl/usr/man/cat3/threads.3.Z ]; then
  mv -f perl/usr/man/cat3/threads.3.Z perl/usr/man/cat3/perlthreads.3.Z
fi

#
# Create this file if it doesn't exist
#
PIFILE=perlext/usr/lib/perl5/sco_perl/${PERLREL}/XML/SAX/ParserDetails.ini
if [ ! -f $PIFILE ]; then
  cat <<EOF > $PIFILE
[XML::SAX::PurePerl]
http://xml.org/sax/features/namespaces = 1

EOF
fi

#
# Create a file so the directory is exported and created
#
SITEDIR=perl/usr/lib/perl5/site_perl/${PERLREL}/${PERLARCH}
if [ ! -f $SITEDIR ]; then
  mkdir -p $SITEDIR
  cat <<EOF > $SITEDIR/README.SCO
This directory is intended for site-specific extensions
EOF
fi

#
# Convert the various hard links into symlinks so that mkcdmt gets a
# better chance at doing things right
#
if [ ! -h perl/usr/bin/perl ]; then
  rm -f perl/usr/bin/perl
  ln -s perl${PERLVER} perl/usr/bin/perl
fi

if [ ! -h perl/usr/bin/suidperl ]; then
  rm -f perl/usr/bin/suidperl
  ln -s perl${PERLVER} perl/usr/bin/suidperl
fi

if [ ! -h perl/usr/bin/pstruct ]; then
  rm -f perl/usr/bin/pstruct
  ln -s c2ph perl/usr/bin/pstruct
fi

if [ ! -h perl/usr/bin/psed ]; then
  rm -f perl/usr/bin/psed
  ln -s s2p perl/usr/bin/psed
fi

if [ ! -h perl/usr/man/man1/pstruct.1 ]; then
  rm -f perl/usr/man/man1/pstruct.1
  ln -s c2ph.1 perl/usr/man/man1/pstruct.1
fi

if [ ! -h perl/usr/man/man1/psed.1 ]; then
  rm -f perl/usr/man/man1/psed.1
  ln -s s2p.1 perl/usr/man/man1/psed.1
fi

@@@@ );
  auto_strip (TRUE, TRUE);
  auto_compress_texinfo ();
  auto_format_mansource ();
}

package ("/perl", "${PERLDESC}", "PERL") {
  file ("/usr/lib/perl5/${PERLREL}/${PERLARCH}/.packlist") {
    access(CLIENT);
  }

  ifeq ("PERLOS", "OSR5")
    file ("/usr/bin/sperl${PERLVER}") {
      owner ("root");
      group ("bin");
      mode (4711);
    }
  endif
}

package ("/perlext", "${PERLEXTDESC}", "PERLEXT") {
  remove ("/usr/bin/ptar");

  file ("/usr/lib/perl5/${PERLREL}/${PERLARCH}/perllocal.pod") {
    access(CLIENT);
    mode(644);
  }
}

component ("perl", "${METAPKG_VERSION}", "${PERLDESC}") {
  subpackage("PERL");
  ifeq ("METAPKG_BACKEND", "cdmt")
    upgrades ("^5\\\\.6\\\\.0.*");
    upgrades ("^5\\\\.6\\\\.1.*");
    upgrades ("^5\\\\.8\\\\.0.*");
    upgrades ("^5\\\\.8\\\\.1.*");
    upgrades ("^5\\\\.8\\\\.3.*");
    upgrades ("^5\\\\.8\\\\.4.*");
    upgrades ("^5\\\\.8\\\\.5.*");
    upgrades ("^5\\\\.8\\\\.6.*");
    upgrades ("^5\\\\.8\\\\.7A[a-z]");
  endif
  dependency ("${DEPVENDOR}gwxlibs", "${GWXDESC}");
}

component ("perlext", "${METAPKG_VERSION}", "${PERLEXTDESC}") {
  subpackage("PERLEXT");
  ifeq ("METAPKG_BACKEND", "cdmt")
    upgrades ("^5\\\\.6\\\\.0.*");
    upgrades ("^5\\\\.6\\\\.1.*");
    upgrades ("^5\\\\.8\\\\.0.*");
    upgrades ("^5\\\\.8\\\\.1.*");
    upgrades ("^5\\\\.8\\\\.3.*");
    upgrades ("^5\\\\.8\\\\.4.*");
    upgrades ("^5\\\\.8\\\\.5.*");
    upgrades ("^5\\\\.8\\\\.6.*");
    upgrades ("^5\\\\.8\\\\.7A[a-z]");
  endif
  dependency ("${DEPVENDOR}gwxlibs", "${GWXDESC}");
  dependency ("${DEPVENDOR}perl", "${PERLDESC}");
}

