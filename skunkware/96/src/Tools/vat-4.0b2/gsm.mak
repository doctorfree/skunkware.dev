# Copyright 1992 by Jutta Degener and Carsten Bormann, Technische
# Universitaet Berlin.  See the accompanying file "COPYRIGHT" for
# details.  THERE IS ABSOLUTELY NO WARRANTY FOR THIS SOFTWARE.

APPVER=4.0

!include <win32.mak>

# Machine dependent flags you must configure to port

SASR	= -DSASR
######### Define SASR if >> is a signed arithmetic shift (-1 >> 1 == -1)

#MULHACK = -DUSE_FLOAT_MUL
######### Define this if your host multiplies floats faster than integers,
######### e.g. on a SPARCstation.

#FAST	= -DFAST
######### Define together with USE_FLOAT_MUL to enable the GSM library's
######### approximation option for incorrect, but good-enough results.

# LTP_CUT	= -DLTP_CUT
LTP_CUT	=
######### Define to enable the GSM library's long-term correlation 
######### approximation option---faster, but worse; works for
######### both integer and floating point multiplications.
######### This flag is still in the experimental stage.

# Where do you want to install libraries, binaries, a header file
# and the manual pages?
#
# Leave INSTALL_ROOT empty (or just don't execute "make install") to
# not install gsm and toast outside of this directory.

INSTALL_ROOT	=

# Where do you want to install the gsm library, header file, and manpages?
#
# Leave GSM_INSTALL_ROOT empty to not install the GSM library outside of
# this directory.

GSM_INSTALL_ROOT = $(INSTALL_ROOT)
GSM_INSTALL_LIB = $(GSM_INSTALL_ROOT)/lib
GSM_INSTALL_INC = $(GSM_INSTALL_ROOT)/inc
GSM_INSTALL_MAN = $(GSM_INSTALL_ROOT)/man/man3


# Where do you want to install the toast binaries and their manpage?
#
# Leave TOAST_INSTALL_ROOT empty to not install the toast binaries outside
# of this directory.

TOAST_INSTALL_ROOT	  = $(INSTALL_ROOT)
TOAST_INSTALL_BIN = $(TOAST_INSTALL_ROOT)/bin
TOAST_INSTALL_MAN = $(TOAST_INSTALL_ROOT)/man/man1

#  Other tools

SHELL		= /bin/sh
LN		= ln
BASENAME 	= basename
AR		= ar
ARFLAGS		= cr
RMFLAGS		=
FIND		= find
COMPRESS 	= compress
COMPRESSFLAGS 	= 
# RANLIB 	= true
RANLIB	 	= ranlib

#
#    You shouldn't have to configure below this line if you're porting.
# 


# Local Directories

ROOT	= .
ADDTST	= $(ROOT)\add-test
TST	= $(ROOT)\tst
MAN	= $(ROOT)\man
BIN	= $(ROOT)\bin
SRC	= $(ROOT)\src
LIBD	= $(ROOT)\lib
TLS	= $(ROOT)\tls
INC	= $(ROOT)\inc

# Flags

# DEBUG	= -DNDEBUG
######### Remove -DNDEBUG to enable assertions.

CFLAGS	= $(CCFLAGS) $(SASR) $(DEBUG) $(MULHACK) $(FAST) $(LTP_CUT) \
	$(CCINC) -I$(INC)
######### It's $(CC) $(CFLAGS)

LFLAGS	= $(LDFLAGS) $(LDINC)
######### It's $(LD) $(LFLAGS)


# Targets

LIBGSM	= $(LIBD)\gsm.lib

TOAST	= $(BIN)\toast.exe
UNTOAST	= $(BIN)\untoast.exe
TCAT	= $(BIN)\tcat.exe

# Headers

GSM_HEADERS =	$(INC)/gsm.h

HEADERS	=	$(INC)/proto.h		\
		$(INC)/unproto.h	\
		$(INC)/config.h		\
		$(INC)/private.h	\
		$(INC)/gsm.h		\
		$(INC)/toast.h		\
		$(TLS)/taste.h

# Sources

GSM_SOURCES =	$(SRC)/add.c		\
		$(SRC)/code.c		\
		$(SRC)/debug.c		\
		$(SRC)/decode.c		\
		$(SRC)/long_term.c	\
		$(SRC)/lpc.c		\
		$(SRC)/preprocess.c	\
		$(SRC)/rpe.c		\
		$(SRC)/gsm_destroy.c	\
		$(SRC)/gsm_decode.c	\
		$(SRC)/gsm_encode.c	\
		$(SRC)/gsm_explode.c	\
		$(SRC)/gsm_implode.c	\
		$(SRC)/gsm_create.c	\
		$(SRC)/gsm_print.c	\
		$(SRC)/gsm_option.c	\
		$(SRC)/short_term.c	\
		$(SRC)/table.c

TOAST_SOURCES = $(SRC)/toast.c 		\
		$(SRC)/toast_lin.c	\
		$(SRC)/toast_ulaw.c	\
		$(SRC)/toast_alaw.c	\
		$(SRC)/toast_audio.c	\
		$(SRC)/getopt.c

SOURCES	=	$(GSM_SOURCES)		\
		$(TOAST_SOURCES)	\
		$(ADDTST)/add_test.c	\
		$(TLS)/bitter.c		\
		$(TLS)/bitter.dta	\
		$(TLS)/taste.c		\
		$(TLS)/sweet.c		\
		$(TST)/cod2lin.c	\
		$(TST)/cod2txt.c	\
		$(TST)/gsm2cod.c	\
		$(TST)/lin2cod.c	\
		$(TST)/lin2txt.c

# Object files

GSM_OBJECTS =	$(SRC)/add.obj		\
		$(SRC)/code.obj		\
		$(SRC)/debug.obj		\
		$(SRC)/decode.obj		\
		$(SRC)/long_term.obj	\
		$(SRC)/lpc.obj		\
		$(SRC)/preprocess.obj	\
		$(SRC)/rpe.obj		\
		$(SRC)/gsm_destroy.obj	\
		$(SRC)/gsm_decode.obj	\
		$(SRC)/gsm_encode.obj	\
		$(SRC)/gsm_explode.obj	\
		$(SRC)/gsm_implode.obj	\
		$(SRC)/gsm_create.obj	\
		$(SRC)/gsm_print.obj	\
		$(SRC)/gsm_option.obj	\
		$(SRC)/short_term.obj	\
		$(SRC)/table.obj

TOAST_OBJECTS =	$(SRC)/toast.obj 	\
		$(SRC)/toast_lin.obj	\
		$(SRC)/toast_ulaw.obj	\
		$(SRC)/toast_alaw.obj	\
		$(SRC)/toast_audio.obj	\
		$(SRC)/getopt.obj

OBJECTS =	 $(GSM_OBJECTS) $(TOAST_OBJECTS)

# Manuals

GSM_MANUALS =	$(MAN)/gsm.3		\
		$(MAN)/gsm_explode.3	\
		$(MAN)/gsm_option.3	\
		$(MAN)/gsm_print.3

TOAST_MANUALS =	$(MAN)/toast.1

MANUALS	= 	$(GSM_MANUALS) $(TOAST_MANUALS) $(MAN)/bitter.1

# Other stuff in the distribution

STUFF = 	ChangeLog			\
		INSTALL			\
		MACHINES		\
		MANIFEST		\
		Makefile		\
		README			\
		$(ADDTST)/add_test.dta	\
		$(TLS)/bitter.dta	\
		$(TST)/run


# Install targets

GSM_INSTALL_TARGETS =	\
		$(GSM_INSTALL_LIB)/libgsm.a		\
		$(GSM_INSTALL_INC)/gsm.h		\
		$(GSM_INSTALL_MAN)/gsm.3		\
		$(GSM_INSTALL_MAN)/gsm_explode.3	\
		$(GSM_INSTALL_MAN)/gsm_option.3		\
		$(GSM_INSTALL_MAN)/gsm_print.3

TOAST_INSTALL_TARGETS =	\
		$(TOAST_INSTALL_BIN)/toast		\
		$(TOAST_INSTALL_BIN)/tcat		\
		$(TOAST_INSTALL_BIN)/untoast		\
		$(TOAST_INSTALL_MAN)/toast.1


# Default rules

.c.obj:
		$(cc) $(cdebug) $(cflags) $(cvars) $(CFLAGS) -Fo$@ $<

# Target rules

all:		$(LIBGSM)
		@-echo $(ROOT): Done.

everything:	$(LIBGSM) $(TOAST) $(TCAT) $(UNTOAST)

tst:		$(TST)/lin2cod $(TST)/cod2lin $(TOAST) $(TST)/test-result
		@-echo tst: Done.

addtst:		$(ADDTST)/add $(ADDTST)/add_test.dta
		$(ADDTST)/add < $(ADDTST)/add_test.dta > /dev/null
		@-echo addtst: Done.

misc:		$(TLS)/sweet $(TLS)/bitter 	\
			$(TST)/lin2txt $(TST)/cod2txt $(TST)/gsm2cod
		@-echo misc: Done.

install:	toastinstall gsminstall
		@-echo install: Done.


# The basic API: libgsm

$(LIBGSM):	$(LIBD) $(GSM_OBJECTS)
		-del $(LIBGSM)
		lib -nologo -machine:i386 -out:$(LIBGSM) $(GSM_OBJECTS)


# Toast, Untoast and Tcat -- the compress-like frontends to gsm.

$(TOAST):	$(BIN) $(TOAST_OBJECTS) $(LIBGSM) $(OBJ_GETOPT)
		$(cc) -nologo -o $@ $(LFLAGS) $(TOAST_OBJECTS) $(OBJ_GETOPT) $(LIBGSM) $(LDLIB)

$(UNTOAST):	$(BIN) $(TOAST)
		-del $(UNTOAST)
		copy $(TOAST) $(UNTOAST)

$(TCAT):	$(BIN) $(TOAST)
		-del $(TCAT)
		copy $(TOAST) $(TCAT)


# The local bin and lib directories

$(BIN):
		if [ ! -d $(BIN) ] ; then mkdir $(BIN) ; fi

$(LIBD):
		if [ ! -d $(LIBD) ] ; then mkdir $(LIBD) ; fi


# Installation

gsminstall:
		-if [ x"$(GSM_INSTALL_ROOT)" != x ] ; then	\
			make $(GSM_INSTALL_TARGETS) ;	\
		fi

toastinstall:
		-if [ x"$(TOAST_INSTALL_ROOT)" != x ]; then	\
			make $(TOAST_INSTALL_TARGETS);	\
		fi

gsmuninstall:
		-if [ x"$(GSM_INSTALL_ROOT)" != x ] ; then	\
			rm $(RMFLAGS) $(GSM_INSTALL_TARGETS) ;	\
		fi

toastuninstall:
		-if [ x"$(TOAST_INSTALL_ROOT)" != x ] ; then 	\
			rm $(RMFLAGS) $(TOAST_INSTALL_TARGETS);	\
		fi

$(TOAST_INSTALL_BIN)/toast:	$(TOAST)
		-rm $@
		cp $(TOAST) $@
		chmod 755 $@

$(TOAST_INSTALL_BIN)/untoast:	$(TOAST_INSTALL_BIN)/toast
		-rm $@
		ln $? $@

$(TOAST_INSTALL_BIN)/tcat:	$(TOAST_INSTALL_BIN)/toast
		-rm $@
		ln $? $@

$(TOAST_INSTALL_MAN)/toast.1:	$(MAN)/toast.1
		-rm $@
		cp $? $@
		chmod 444 $@

$(GSM_INSTALL_MAN)/gsm.3:	$(MAN)/gsm.3
		-rm $@
		cp $? $@
		chmod 444 $@

$(GSM_INSTALL_MAN)/gsm_option.3:	$(MAN)/gsm_option.3
		-rm $@
		cp $? $@
		chmod 444 $@

$(GSM_INSTALL_MAN)/gsm_explode.3:	$(MAN)/gsm_explode.3
		-rm $@
		cp $? $@
		chmod 444 $@

$(GSM_INSTALL_MAN)/gsm_print.3:	$(MAN)/gsm_print.3
		-rm $@
		cp $? $@
		chmod 444 $@

$(GSM_INSTALL_INC)/gsm.h:	$(INC)/gsm.h
		-rm $@
		cp $? $@
		chmod 444 $@

$(GSM_INSTALL_LIB)/libgsm.a:	$(LIBGSM)
		-rm $@
		cp $? $@
		chmod 444 $@


# Distribution

dist:		gsm-1.0.tar.Z
		@echo dist: Done.

gsm-1.0.tar.Z:	$(STUFF) $(SOURCES) $(HEADERS) $(MANUALS)
		(	cd $(ROOT)/..;				\
			tar cvf - `cat $(ROOT)/gsm-1.0/MANIFEST	\
				| sed '/^#/d'`			\
		) | $(COMPRESS) $(COMPRESSFLAGS) > $(ROOT)/gsm-1.0.tar.Z

# Clean

uninstall:	toastuninstall gsmuninstall
		@-echo uninstall: Done.

semi-clean:
		-rm $(RMFLAGS)  */*.o			\
			$(TST)/lin2cod $(TST)/lin2txt	\
			$(TST)/cod2lin $(TST)/cod2txt	\
			$(TST)/gsm2cod 			\
			$(TST)/*.*.*
		-$(FIND) . \( -name core -o -name foo \) \
			-print | xargs rm $(RMFLAGS)

clean:	semi-clean
		-rm $(RMFLAGS) $(LIBGSM) $(ADDTST)/add		\
			$(TOAST) $(TCAT) $(UNTOAST)	\
			$(ROOT)/gsm-1.0.tar.Z


# Two tools that helped me generate gsm_encode.c and gsm_decode.c,
# but aren't generally needed to port this.

$(TLS)/sweet:	$(TLS)/sweet.o $(TLS)/taste.o
		$(LD) $(LFLAGS) -o $(TLS)/sweet \
			$(TLS)/sweet.o $(TLS)/taste.o $(LDLIB)

$(TLS)/bitter:	$(TLS)/bitter.o $(TLS)/taste.o
		$(LD) $(LFLAGS) -o $(TLS)/bitter \
			$(TLS)/bitter.o $(TLS)/taste.o $(LDLIB)


# Run $(ADDTST)/add < $(ADDTST)/add_test.dta to make sure the
# basic arithmetic functions work as intended.

$(ADDTST)/add:	$(ADDTST)/add_test.o
		$(LD) $(LFLAGS) -o $(ADDTST)/add $(ADDTST)/add_test.o $(LDLIB)


# Various conversion programs between linear, text, .gsm and the code
# format used by the tests we ran (.cod).  We paid for the test data,
# so I guess we can't just provide them with this package.  Still,
# if you happen to have them lying around, here's the code.
# 
# You can use gsm2cod | cod2txt independently to look at what's
# coded inside the compressed frames, although this shouldn't be
# hard to roll on your own using the gsm_print() function from
# the API.


$(TST)/test-result:	$(TST)/lin2cod $(TST)/cod2lin $(TOAST) $(TST)/run
			( cd $(TST); ./run ) 

$(TST)/lin2txt:		$(TST)/lin2txt.o $(LIBGSM)
			$(LD) $(LFLAGS) -o $(TST)/lin2txt \
				$(TST)/lin2txt.o $(LIBGSM) $(LDLIB)

$(TST)/lin2cod:		$(TST)/lin2cod.o $(LIBGSM)
			$(LD) $(LFLAGS) -o $(TST)/lin2cod \
				$(TST)/lin2cod.o $(LIBGSM) $(LDLIB)

$(TST)/gsm2cod:		$(TST)/gsm2cod.o $(LIBGSM)
			$(LD) $(LFLAGS) -o $(TST)/gsm2cod \
				$(TST)/gsm2cod.o $(LIBGSM) $(LDLIB)

$(TST)/cod2txt:		$(TST)/cod2txt.o $(LIBGSM)
			$(LD) $(LFLAGS) -o $(TST)/cod2txt \
				$(TST)/cod2txt.o $(LIBGSM) $(LDLIB)

$(TST)/cod2lin:		$(TST)/cod2lin.o $(LIBGSM)
			$(LD) $(LFLAGS) -o $(TST)/cod2lin \
				$(TST)/cod2lin.o $(LIBGSM) $(LDLIB)
