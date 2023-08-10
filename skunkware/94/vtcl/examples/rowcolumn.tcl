

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
# a minimal test of the rowcolumn widget
#

proc quitCB {form cbs} {
    VtClose
}

proc toggleChangedCB {cbs} {
	global label

	set wl [split [lindex $cbs 0] .]
	set wi [expr "[llength $wl] - 1"]
	VtSetValues $label \
		-label "[lindex $wl $wi] Value: [lindex $cbs 1]"
}

set fn [VtOpen testtoggles]

set fn [VtStartForm $fn.toggles -title "Toggles" \
       -xmArgs "XmNmarginWidth 10
                XmNmarginHeight 10
	        XmNbackground green"]

set rc1 [VtRowColumn $fn.rc1 -packing NONE ]

set tog ""
foreach i {1 2 3} {
        set j [expr $i * 15]
   	set tog [VtToggleButton $rc1.tog$i -label "Toggle $i" \
		-valueChangedCallback toggleChangedCB \
		-xmArgs "XmNx $i XmNy $j"]
}

set rc2 [VtRowColumn $fn.rc2 -below $rc1 -packing COLUMN \
	 -xmArgs "XmNbackground pink" ]

foreach i {4 5 6} {
   	set tog [VtToggleButton $rc2.tog$i -label "Toggle $i" -value 1 \
		-valueChangedCallback toggleChangedCB]
}

set rc3 [VtRowColumn $fn.rc3 -below $rc2 -packing TIGHT ]

foreach i {7 8 9} {
   	set tog [VtToggleButton $rc3.tog$i -label "Toggle $i" -value 0 \
		-valueChangedCallback toggleChangedCB]
}

set label [VtLabel $fn.label -label "No Callback Yet" -below $rc3]

VtPushButton $fn.quit -callback "quitCB $fn" \
    -below $label \
    -leftSide FORM\
    -rightSide FORM\
    -topOffset 10\
    -leftOffset 5 \
    -rightOffset 5\
    -CHARM_topOffset 1\
    -CHARM_leftOffset 2\
    -CHARM_rightOffset 2

VtShow $fn
VtMainLoop

