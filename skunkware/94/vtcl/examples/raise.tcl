

# ---------------------------------------------------------------------
# Copyright 1994 by SCO, Inc.
# Permission to use, copy, modify, distribute, and sell this software
# and its documentation for any purpose is hereby granted without fee,
# provided that the above copyright notice appear in all copies and that
# both that copyright  notice  and  this  permission  notice  appear  in
# supporting documentation, and that the name  of  SCO  not  be used  in
# advertising or publicity pertaining  to distribution of  the  software
# without   specific,   written  prior   permission.    SCO   makes   no
# representations  about  the  suitability  of  this  software  for  any
# purpose.  It is provided "as is" without express or implied warranty.
# ---------------------------------------------------------------------


#
# Create two information dialog and raise them using
# buttons in the main form
# Note VtRaise is a Noop in CHARM
#


proc testNotCharm {nm} {
    if { [ VtInfo -charm ] } {
        VtClose
        echo "$nm: This test exercises functionality not avail in CHARM (08.03.94)"
	echo "i.e. VtRaise"
        echo "Test should be ignored for CHARM use"
        exit 0
    }
}

proc raiseCB {dlog cbs} {
    VtRaiseDialog $dlog
}


proc quitCB {cbs} {
	VtClose
}

set app [VtOpen raise]
testNotCharm raise

set dlog [VtFormDialog $app.form]

# create two info boxes
set info1 [VtInformationDialog $dlog.info1 -message "Info Box A" -hidden 0]
set info2 [VtInformationDialog $dlog.info2 -message "Info Box B" -hidden 0]

set lab [VtLabel $dlog.lab \
	 -label "Raise the dialogs by \npressing on either buttons"]

VtPushButton $dlog.b1 -label "Raise A" -callback "raiseCB $info1"
VtPushButton $dlog.b2 -label "Raise B" -callback "raiseCB $info2" 
VtPushButton $dlog.b3 -label "Raise Me" -callback "raiseCB $dlog"
VtSeparator  $dlog.s -leftSide FORM -rightSide FORM
VtPushButton $dlog.q  -label "Quit"     -callback quitCB \
	-leftSide FORM \
	-bottomSide FORM \
	-rightSide FORM


VtShow $dlog

VtMainLoop
