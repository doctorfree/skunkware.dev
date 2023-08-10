CTRBDESTDIR=/usr/skunk

CFLAGS	= -O

TARGET	= ProgramName
SRCS	= CFileNames.c
OBJS	= $(SRCS:.c=.o)

all: man2html

man2html: man2html.pl
	cp man2html.pl man2html
	chmod 755 man2html

install: all
	cp man2html $(CTRBDESTDIR)/bin

clean clobber:
	rm -f man2html

install.man:
	scoinst -c -m 444 doc/man2html.doc.html $(CTRBDESTDIR)/man/cat.html/man2html.html
