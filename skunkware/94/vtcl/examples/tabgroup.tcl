

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
# tabgroup.tcl - CHARM only test
# exercises VtAddTabGroup, VtremoveTabGroup
#    - only valid in CHARM, ignored in xm_wserver


proc testCharm {nm} {
    if { ! [ VtInfo -charm ] } {
        echo "$nm: This test exercises functionality specific to CHARM (08.03.94)"
	echo " i.e. VtAddTabGroup/VtRemoveTabGroup"
        echo "Test should be ignored for non CHARM use"
        VtClose
        exit 0
    }
}


proc addCB {cbs} {
	global pb1

	VtAddTabGroup $pb1
	VtSetValues $pb1 -label "Can Get Here Now!"
}

proc removeCB {cbs} {
	global pb1

	VtRemoveTabGroup $pb1
	VtSetValues $pb1 -label "Can't Get Here Again"
}

proc quitCB {cbs} {
	VtClose
}

set app [VtOpen tabgroup]
testCharm tabgroup   ;# See if wasting our time

set form [VtFormDialog $app.form]

set inner1 [VtForm $form.inner1 \
	-rightSide 50]
set text1 [VtText $inner1.text]
set pb1 [VtPushButton $inner1.pb1 \
	-label "Can't Get Here"]

set add [VtPushButton $form.add \
	-callback addCB \
	-topSide FORM \
	-leftSide 50 \
	-rightSide FORM]

set remove [VtPushButton $form.remove \
	-callback removeCB \
	-leftSide 50 \
	-topSide $add \
	-rightSide FORM]

set quit [VtPushButton $form.quit \
	-callback quitCB \
	-leftSide 50 \
	-topSide $remove \
	-bottomSide FORM \
	-rightSide FORM]

VtShow $form
VtMainLoop

