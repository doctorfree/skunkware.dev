

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
# a minimal test of the toggle button widget
#

proc quitCB {form cbs} {
    VtClose
}

proc toggleChangedCB {cbs} {
	global label

	set wl [split [keylget cbs widget] .]
	set wi [expr "[llength $wl] - 1"]
	VtSetValues $label \
		-label "[lindex $wl $wi] Value: [keylget cbs set]"
}

proc nextToggle {name label value} {
   	set tog [VtToggleButton $name -label $label -value $value \
		-valueChangedCallback toggleChangedCB \
		     -CHARM_mnemonic [cindex $label 0] \
		     -xmArgs "XmNbackground red"]

    return $tog
}

set fn [VtOpen "testtoggles"]

set fn [VtFormDialog $fn.toggles -title "Toggles" \
       -xmArgs "XmNmarginWidth 10
                XmNmarginHeight 10
	        XmNbackground green"]

set rc1 [VtRowColumn $fn.rc1 -borderWidth 1]

foreach i {1 2 3} {
    set tog [nextToggle $rc1.tog$i "$i Toggle" 0]
}

set form1 [VtForm $fn.form1 -borderWidth 2]

foreach i {4 5 6} {
    set tog [nextToggle $form1.tog$i "Toggle $i" 1]
}

set label [VtLabel $fn.label -label "No Callback Yet" -below $form1]

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

