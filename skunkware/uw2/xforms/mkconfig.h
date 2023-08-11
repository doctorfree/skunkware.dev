# unixware

CC=cc
CCFLAG=-O 
LDFLAG=-O -s
AR=ar rs
RANLIB=touch
XINCLUDE=-I/usr/X/include
SYSLIB=-L/usr/X/lib -lX11 -lnsl -lm

# where the library should be installed
#TOP_LIBDIR=/usr
TOP_LIBDIR=/usr/local
BIN_DIR=/usr/local/bin

LIB_DIR=$(TOP_LIBDIR)/lib
LIBMODE=644

HEADER_DIR=$(TOP_LIBDIR)/include
HEADERMODE=644

BINMODE=711

MAN5_DIR=$(TOP_LIBDIR)/man/man5
MAN1_DIR=$(TOP_LIBDIR)/man/man1
MANMODE=644

# name and header of the library
FORMLIB=libforms.a
FORMHEADER=forms.h

# make shared lib: $(MKSHLIB) -o $(SHARED_LIB) *.o
SHARED_LIB=libforms.so.0.86
SHARED_NAME=libforms.so
MKSHLIB=ld -G -h $(SHARED_LIB) -o $(SHARED_LIB) `ls *.o | grep -v gl.o` ulib/*.o \
        ../xpm-3.4g/lib/libXpm.a 

LN=ln -fs

