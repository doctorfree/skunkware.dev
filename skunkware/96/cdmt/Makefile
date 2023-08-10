# 
# Makefile to build a custom+ SSO for SCO Skunkware 96
# rr@sco.com
#

HERE=`pwd`
CFG=-config cdmt.config
CDCFG=-config cdmt.cd.config

#all:: cdmt.config cdmt.cd.config sso ssoCD
all:: ssoTAPE 

# If we are exporting to the system from this SSO, then this 
# rule will wipe out the existing (installed) SSO, making it uninstalled
# and perhaps leaving custom databases in an awkward state.
# so be warned
ssoCD : input/default.prd cdmt.cd.config Makefile
	rm -rf $@	
	CDMT_DIR=$(HERE) cdmtParse  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CDCFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)
ssoTAPE: input/default.prd cdmt.config Makefile
	rm -rf $@	
	CDMT_DIR=$(HERE) cdmtParse  $(CFG)
	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

compress:
	CDMT_DIR=$(HERE) cdmtCompress  $(CFG)

archive:
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)

#install ::
#	@echo To install the skunk SSO on this machine run 
#	@echo as root 
#	@echo make export enable 
#
# install the archives/TAPE onto my machine, two passes, Load and Enable

# must be root to do this
install:: load enable

# custom load is -L, -z is the image directory
export load:: archives/TAPE
	custom -p SKUNK96:default -L -z $(HERE)/archives/TAPE

# custom enable, this requires that it be "loaded", then we can populate 
# the /usr space. 
enable: /opt/P/SKUNK96
	custom -p SKUNK96:default -e

no_skunk really_clean_sys : disable remove clean_system
# custom disable, but dont remove
disable:
	custom -p SKUNK96:default -d
# really remove the files from /opt/?/SKUNK96
remove:
	custom -p SKUNK96:default -r
# remove SKUNK96 from the /opt area
clean_system::
	rm -rf /opt/?/SKUNK96 /var/opt/K/SKUNK96

# export the ssoCD to my machine
# do a quick install on my own machine
# start by disabling the skunk on my machine 
# only works if the perms in the ssoCD dir allow those binaries to be
# executed and read ...  to get this right run "make fixall"
export_CD:  ssoCD 
	-custom -p SKUNK96:default -d
	rm -rf /opt/?/SKUNK96 /var/opt/K/SKUNK96
	-mkdir -p /opt/P/SKUNK96/default /opt/K/SKUNK96 /var/opt/K/SKUNK96
	( cd ./ssoCD ; for i in opt/P/SKUNK96/default/5.0; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK96/*; do \
		mkdir -p /$$i ; \
	done )
	( cd ./ssoCD ; for i in opt/K/SKUNK96/*/*; do \
		ln -s $(HERE)/$$i /$$i ; \
	done )

# just a quick fix, for stuff we know we need to tweak ...
# dont run this on a readonly ssoCD 
fixup_perms fp quickfix: 
	find ./ssoCD -name "ccs" -exec chmod +x {} \;  
	chmod +x ./ssoCD/opt/K/SKUNK96/Xmcd/2.0/libdi.d/configure.sh 

# this is not quick at all ...
# and you must be root, should be done after a "make export" 
# and before make enable
fixall fix_all fixperms fixperm: 
	custom -p SKUNK96:default -v quick -x >/dev/null

# to test the prd database file
parse.prd parse prd :
	CDMT_DIR=$(HERE) cdmtParse -prd input/default.prd  $(CFG) 

# after a compress and parse
archCD : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CDCFG)
arch : 
	CDMT_DIR=$(HERE) cdmtArchive -f $(CFG)



fresco: ../X11/Fresco/fresco.cmpnt
acm : ../Games/acm-4.7/acm.cmpnt
xpilot : ../Games/xpilot-3.3.1/xpilot.cmpnt
gds : ../Tools/gds/gds.cmpnt
groff: ../Tools/groff-1.09/groff.cmpnt
Xmcd: ../X11/xmcd-2.0/dist/input/Xmcd.cmpnt
xsw: ../X11/xsw/xsw.cmpnt
XV: ../X11/xv-3.10a/dist/input/XV.cmpnt
Perl: ../Tools/perl-5.002/dist/input/Perl.cmpnt

CMPNTS=../X11/Fresco/fresco.cmpnt \
	../Games/acm-4.7/acm.cmpnt \
	../Games/xpilot-3.3.1/xpilot.cmpnt \
	../Tools/gds/gds.cmpnt \
	../Tools/groff-1.09/groff.cmpnt \
	../X11/xmcd-2.0/dist/input/Xmcd.cmpnt \
	../Tools/perl-5.002/dist/input/Perl.cmpnt \
	../X11/xsw/xsw.cmpnt \
	../X11/xv-3.10a/dist/input/XV.cmpnt

.PRECIOUS:$(CMPNTS)
$(CMPNTS) : cdmt.config 
	cdmtParse -cmpnt $@
	cdmtCompress -cmpnt $@
	#cdmtArchive 


# some rules for building and test install of one cmpnt
# first run 
# make Xmcd arch 
# then 
# make Xmcd_try 
# 
# we disable, them remove, then load from the arch, then enable ... 
# this can be done for other cmpnts/packages as well
Xmcd_try : 
	custom -p SKUNK96:default -d SKUNK96:Xmcd
	custom -p SKUNK96:default -r SKUNK96:Xmcd 
	custom -p SKUNK96:default -L SKUNK96:Xmcd -z $(HERE)/archives/TAPE
	custom -p SKUNK96:default -e SKUNK96:Xmcd
gds_try : 
	custom -p SKUNK96:default -d SKUNK96:gds
	custom -p SKUNK96:default -r SKUNK96:gds 
	custom -p SKUNK96:default -L SKUNK96:gds -z $(HERE)/archives/TAPE
	custom -p SKUNK96:default -e SKUNK96:gds
groff_try : 
	custom -p SKUNK96:default -d SKUNK96:groff
	custom -p SKUNK96:default -r SKUNK96:groff 
	custom -p SKUNK96:default -L SKUNK96:groff -z $(HERE)/archives/TAPE
	custom -p SKUNK96:default -e SKUNK96:groff


