

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
# Test tablist resource in CHARM - same resource ignored in xm
# Reverse buttons toggles order of tablist
#

proc testCharm {nm} {
    if { ! [ VtInfo -charm ] } {
        echo "$nm: This test exercises functionality specific to CHARM (08.03.94)"
	echo " i.e. -tablist option on formDialogs"
        echo "Test should be ignored for non CHARM use"
        VtClose
        exit 0
    }
}

proc quitCB {cbs} {
    VtClose
}

proc reverseCB {cbs} {
	global fn text rc lst

	if {[keylget cbs set]} {
		VtSetValues $fn -tabList [list $text $rc $lst]
	} {
		VtSetValues $fn -tabList [list $lst $rc $text]
	}
}

set fn [VtOpen "TestTabList"]

# See if we're wasting our time 
testCharm tablist

set fn [VtFormDialog $fn.form -title "TabList Test"]

set rev [VtToggleButton $fn.reverse -label Reverse -callback reverseCB \
	-topSide FORM -leftSide FORM]
set quit [VtPushButton $fn.quit -label Exit -callback quitCB -leftSide $rev \
	-topSide FORM -rightSide FORM]

set sep [VtSeparator $fn.sep -leftSide FORM -topSide $rev -rightSide FORM]

set lst [VtList $fn.list \
		-itemList {"one" "two" "three"} \
		-rows 6\
		-leftSide FORM -topSide $sep ]

set rc [VtRowColumn $fn.rc -leftSide $lst -rightSide FORM -topSide $sep]

set label1 [VtLabel $rc.label1 -label "label1" ]
set pushb1 [VtPushButton $rc.pushb1 -label "pushb1" ]

set text [VtText $fn.text -rows 1 -value "text" \
	-leftSide FORM -topSide $lst -rightSide FORM]

VtShow $fn
VtMainLoop

