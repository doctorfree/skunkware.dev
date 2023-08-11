#
# $Id: Makefile,v 0.2 1995/03/15 21:55:51 zhao Exp $
#
# Makefile for the entire XFORMs tree. 
#
#  usage: make [demo|install|clean]
#      demo: demo
#   install: copy the library and head file to standard directories.
#     clean: remove all .o files
#     empty: clean + removal of all demo executibles 
#

# all changes should be made in mkconfig.h 

SYSLIB=-lX11 -lm
SHELL=/bin/sh

FORMHEADER=forms.h
FORMLIB=libforms.a

include mkconfig.h
##### don't change anything after this line ####

demo: 
	@(cd DEMOS; make) 

install:
	cp FORMS/$(FORMLIB) $(LIB_DIR);chmod $(LIBMODE) $(LIB_DIR)/$(FORMLIB)
	cp DESIGN/fdesign $(BIN_DIR); chmod $(BINMODE) $(BIN_DIR)/fdesign
	cp fd2ps/fd2ps $(BIN_DIR); chmod $(BINMODE) $(BIN_DIR)/fd2ps
	-@if [ "$(SHARED_LIB)" != "" ]; then\
           cp FORMS/$(SHARED_LIB) $(LIB_DIR); \
           chmod $(LIBMODE) $(LIB_DIR)/$(SHARED_LIB);\
           if [ "$(SHARED_NAME)" != "" ]; then\
              $(LN) $(LIB_DIR)/$(SHARED_LIB) $(LIB_DIR)/$(SHARED_NAME);\
           fi \
        fi
	cp FORMS/$(FORMHEADER) $(HEADER_DIR);\
           chmod $(HEADERMODE) $(HEADER_DIR)/$(FORMHEADER)
	cp FORMS/xforms.5 $(MAN5_DIR);  chmod $(MANMODE) $(MAN5_DIR)/xforms.5
	cp DESIGN/fdesign.1 $(MAN1_DIR); chmod $(MANMODE) $(MAN1_DIR)/fdesign.1
	cp fd2ps/fd2ps.1 $(MAN1_DIR); chmod $(MANMODE) $(MAN1_DIR)/fd2ps.1
	@if [ ! -f $(MAN5_DIR)/forms.5 ]; then\
          ln -s $(MAN5_DIR)/xforms.5 $(MAN5_DIR)/forms.5;\
        fi
clean:
	(cd  DEMOS; make $@)
empty:
	(cd  DEMOS; make $@)
