# 
# hess@sco.com
# Makefile to build a custom+ SSO for skunkware

HERE=`pwd`
CDCFG=-config cdmt.cd.config
CFG=$(CDCFG)

all:: ssoCD

# If we are exporting to the system from this SSO, then this 
# rule will wipe out the existing (installed) SSO, making it uninstalled
# and perhaps leaving custom databases in an awkward state.
ssoCD : input/default.prd cdmt.cd.config Makefile
	rm -rf $@	
	CDMT_DIR=$(HERE) cdmtParse  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)

install ::
	@echo To install the skunk SSO on this machine run 
	@echo as root 
	@echo make export enable 

# export the ssoCD to my machine
# must be root to do this
enable:
	custom -p SKUNK:default -e
disable:
	custom -p SKUNK:default -d

# do a quick install on my own machine
# start by disabling the skunk on my machine 
# only works if the perms in the ssoCD dir allow those binaries to be
# executed and read ...  to get this right run "make fixall"
export:  
	find ./ssoCD -name "ccs" -exec chmod +x {} \;  
	-custom -p SKUNK:default -d
	rm -rf /opt/?/SKUNK /var/opt/K/SKUNK
	-mkdir -p /opt/P/SKUNK/default /opt/K/SKUNK /var/opt/K/SKUNK
	( cd ./ssoCD ; for i in opt/P/SKUNK/default/5.0; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK/*; do \
		mkdir -p /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK/*/*; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )

# just a quick fix, for stuff we know we need to tweak ...
fixup_perms fp quickfix: 
	find ./ssoCD -name "ccs" -exec chmod +x {} \;  
	chmod +x ./ssoCD/opt/K/SKUNK/xmcd/1.4/libdi.d/configure.sh 

# this is not quick at all ...
# and you must be root, should be done after a "make export" 
# and before make enable
fixall fix_all fixperms fixperm: 
	custom -p SKUNK:default -v quick -x >/dev/null

parse.prd parse prd :
	cdmtParse -prd input/default.prd  $(CFG) 

# rules to update individual components, used during development...
GROFF=../Tools/groff-1.09
groff:
	CDMT_DIR=$(HERE) cdmtParse $(CFG) -cmpnt $(GROFF)/$@.cmpnt 
	CDMT_DIR=$(HERE) cdmtCompress $(CFG) -cmpnt $(GROFF)/$@.cmpnt 

ACM=../Games/acm-4.7
acm:
	CDMT_DIR=$(HERE) cdmtParse $(CFG) -cmpnt $(ACM)/$@.cmpnt 
	CDMT_DIR=$(HERE) cdmtCompress $(CFG) -cmpnt $(ACM)/$@.cmpnt 

#gcc gdb tools groff perl fresco::
#	CDMT_DIR=$(HERE) cdmtParse $(CFG) -cmpnt input/$@.cmpnt 
#	CDMT_DIR=$(HERE) cdmtCompress $(CFG) -cmpnt input/$@.cmpnt 
#Emacs Ispell: 
#	CDMT_DIR=$(HERE) cdmtParse  $(CFG)  -cmpnt $(GNU)/input/$@.cmpnt
#	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)  -cmpnt $(GNU)/input/$@.cmpnt
#xmcd : 
#	CDMT_DIR=$(HERE) cdmtParse  $(CFG)  -cmpnt $(XMCD)/input/$@.cmpnt
#	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)  -cmpnt $(XMCD)/input/$@.cmpnt
#
arch : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)
