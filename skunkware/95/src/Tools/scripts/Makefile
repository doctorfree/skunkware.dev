DESTDIR=/usr/skunk

SCRIPTS= clouds colors cpiocopy dft dpio findandgrep findcstr mkicon mkstamp \
	nr2html top

all: $(SCRIPTS)

install: all
	-chmod 755 $(SCRIPTS)
	cp $(SCRIPTS) $(DESTDIR)/bin
	-chmod 444 $(SCRIPTS)

clean:
