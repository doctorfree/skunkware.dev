#
#
# Flags that might be overriden by top makefile
#

CC=cc
CCFLAG=-O
LDFLAG=-O -s 
SYSLIB=-lX11 -lm

SHELL=/bin/sh

include ../mkconfig.h

#
# Flags the compiler will see
#

CFLAGS=$(CCFLAG) -I../FORMS $(XINCLUDE) -Ifd
LDFLAGS = $(LDFLAG) 
LIBS=-L../FORMS -lforms $(SYSLIB)
GLLIBS=-L../FORMS -lforms -lGL -lXext $(SYSLIB)


#
DEMOSO= freedraw.o demo.o colsel.o borderwidth.o xyplotover.o\
	pushme.o yesno.o pushbutton.o buttonall.o demo05.o \
	demo06.o touchbutton.o \
        colsel1.o ldial.o fdial.o\
	fbrowse1.o flclock.o menu.o free1.o \
	goodies.o boxtype.o sldinactive.o sld_radio.o \
	positioner.o arrowbutton.o sldsize.o sliderall.o symbols.o \
	demo27.o browserall.o browserop.o multilabel.o \
	fbrowse.o choice.o demo33.o timer.o fonts.o \
	counter.o chartstrip.o chartall.o minput.o minput2.o longlabel.o \
	secretinput.o objinactive.o rescale.o ndial.o xyplotall.o xyplotactive.o\
	colbrowser.o pup.o pmbrowse.o invslider.o wwwl.o  \
	preemptive.o objreturn.o freedraw_leak.o lalign.o canvas.o\
	iconify.o cursor.o objpos.o strsize.o timerprec.o ll.o \
	inputall.o group.o butttypes.o
#

DEMOS= ${DEMOSO:.o=} 

all: demoprep ${DEMOS} newbutton 

${DEMOS}: 
	-$(CC) -c $(CFLAGS) $@.c
	-$(CC) $(LDFLAGS) $@.o  -o $@ $(LIBS)

demotest:demotest.o
	-$(CC) $(LDFLAGS) -o $@ demotest.o -lGL -lXext $(LIBS)

newbutton: newbutton.o crossbut.o crossbut.h
	-$(CC) $(LDFLAGS) -o $@ newbutton.o crossbut.o $(LIBS)

gl: gl.o 
	-$(CC) $(LDFLAGS) -o $@ $?  $(GLLIBS)
glwin:glwin.o 
	-$(CC) $(LDFLAGS) -o $@ $?  $(GLLIBS)

nnn: nnn.o crossbut.o crossbut.h
	-$(CC) $(LDFLAGS) -o $@ nnn.o crossbut.o $(LIBS)

clean:
	-rm -f  *.o core a.out *~

empty: clean
	-rm -f $(DEMOS) newbutton nnn elog mlog gl glwin demotest
	-rm -f old*
	-rm -f fd/*bak


demoprep:
	-@if [ "$(SHARED_NAME)" != "" ]; then\
           cd ../FORMS;       \
           if [ -f $(SHARED_LIB) ]; then \
                $(LN) $(SHARED_LIB) $(SHARED_NAME);\
           fi;\
        fi

