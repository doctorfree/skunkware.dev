

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
# a minimal test of the radiobox widget
#

source tools.tcl

proc quitCB {cbs} {
    VtClose
}

proc toggleChangedCB {cbs} {
	global label label2 label3 rc1 rc2

	set short [CBSGetWidgetShortName $cbs]
	set val [keylget cbs set]
	VtSetValues $label -label "Widget: $short  Value: $val"
	set cb1 [VtGetValues $rc1 -value]
	VtSetValues $label2 -label "Checkbox1: $cb1"
	set cb2 [VtGetValues $rc2 -value]
	VtSetValues $label3 -label "Checkbox2: $cb2"
}

proc nextToggle {name label last} {
    if {$last == ""} {
	set tog [VtToggleButton $name -label $label -value 1 \
		-callback toggleChangedCB \
		     -xmArgs "XmNbackground red"]
    } else {
   	set tog [VtToggleButton $name -label $label \
		-callback toggleChangedCB \
		     -xmArgs "XmNbackground red"]
    }

    return $tog
}

set app [VtOpen "testradiobox"]

set fn [VtStartForm $app.form -title "Radio Box Test" \
       -xmArgs "XmNmarginWidth 10
                XmNmarginHeight 10
	        XmNbackground green"]

set rc1 [VtRadioBox $fn.rc1 -borderWidth 2]

set tog ""
foreach i {1 2 3} {
    set tog [nextToggle $rc1.tog$i "Toggle $i" $tog]
}

set rc2 [VtRadioBox $fn.rc2 -below $fn.rc1 \
	-borderWidth 2]

foreach i {4 5 6} {
    set tog [nextToggle $rc2.tog$i "Toggle $i" $tog]
}

set label [VtLabel $fn.label -label "No Callback Yet" -below $rc2]
set label2 [VtLabel $fn.label2 -label "No Callback Yet" -below $label]
set label3 [VtLabel $fn.label3 -label "No Callback Yet" -below $label2]

VtPushButton $fn.quit -callback quitCB \
    -below $label3 \
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

