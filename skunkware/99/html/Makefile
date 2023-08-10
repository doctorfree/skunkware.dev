#
# Makefile to create all the HTML source code, both for the CD and for
# the on-line version

all: cd www

clean:
	(cd cdrom; make clean)
	(cd web; make clean)

cd:
	(cd cdrom; make)

www:
	(cd web; make)

install: cd
	(cd cdrom; make install)
