


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


proc quitCB {cbs} {
    VtClose
    exit 0
}


proc turnCB {cbs} {
        global s1
	global flag
        
	if {$flag == "vert"} {
		VtSetValues $s1  -length 2  -vertical
		set flag horz
	} else {
		VtSetValues $s1  -length 4  -horizontal
		set flag vert
	}
}


#
# Start Program
#
#
set app [VtOpen testseps]


set fn [VtStartForm $app.separators -title "Separators SetValue"  \
       -xmArgs "XmNmarginWidth 10
                XmNmarginHeight 20"]


set lab1 [VtLabel $fn.lab1 -label "Demo: SetValues" \
		  -topSide FORM \
		  -topOffset 20 \
		  -CHARM_topOffset 0]

set s1 [VtSeparator $fn.s1 -length  2 -below $lab1  -vertical \
                  -leftSide FORM \
		  -rightSide FORM \
		  -leftOffset 50 \
		  -rightOffset 50 \
		  -topOffset 20 \
		  -CHARM_leftOffset 5 \
		  -CHARM_rightOffset 5 \
		  -CHARM_topOffset 1]

set flag horz

set turnButton \
[VtPushButton $fn.but -callback "turnCB" \
    -label "Turn it" \
    -below $s1 \
    -leftSide FORM\
    -rightSide FORM\
    -topOffset 30\
    -leftOffset 5 \
    -rightOffset 5\
    -CHARM_topOffset 1\
    -CHARM_leftOffset 2\
    -CHARM_rightOffset 2]

VtPushButton $fn.quit -callback quitCB  \
    -below $turnButton \
    -leftSide FORM\
    -rightSide FORM\
    -topOffset 10\
    -leftOffset 5 \
    -rightOffset 5\
    -CHARM_topOffset 1\
    -CHARM_leftOffset 2\
    -CHARM_rightOffset 2

VtManage $fn
VtMainLoop

