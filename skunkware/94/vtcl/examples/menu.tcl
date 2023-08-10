

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
# a minimal test of the menubar and pulldown widgets
#
# use the object option allowDuplicateName to make separator with
# identical names.
#
source "tools.tcl"

set menuList1 {
    {pd File F}
        {bt "New..." N "Ctrl<Key>N" "Ctrl+N" }
        {bt  Exit    E "Ctrl<Key>E" "Ctrl+E" QuitCB}
    {pd Edit E}
        {bt Cut   C "Ctrl<Key>X" "Ctrl+X" }
        {bt Copy  o "Ctrl<Key>C" "Ctrl+C" }
        {bt Paste P "Ctrl<key>V" "Ctrl+V" }
    {sp}
    {bt Delete D "<key>Delete" Delete }
    {pd View  V}
        {bt Some  S "Ctrl<Key>S" "Ctrl+S" }
        {bt Parts P ""	   }
    {pd Printer  P}
        {bt "New Printer"  N  }
        {sp}
        {tb "Good Printer" "" "" "" toggleChangedCB  0}
        {tb "Bad Printer"  "" "" "" toggleChangedCB  1}
        {tb "Ugly Printer" "" "" "" toggleChangedCB  0}
    {pd Test  T}
        {bt "Sensitive Target..." }
        {bt "Make UnSensitive" "" "" "" "setSenCB 0" }
        {bt "Make Sensitive"   "" "" "" "setSenCB 1" }
}

set menuList2 {
    {pd File    F}
        {bt Exit    E "Ctrl<Key>E" "Ctrl+E" QuitCB}
    {pd Edit    E}
        {bt Cut     C "Ctrl<Key>X" "Ctrl+X" }
        {bt Copy    o "Ctrl<Key>C" "Ctrl+C" }
        {bt Paste   P "Ctrl<Key>V" "Ctrl+V"}
        {sp}
        {bt Delete  D "<Key>Delete"      Delete  }
        {pd View    V}
        {bt Some    S "Ctrl<Key>S" "Ctrl+S" }
        {cs Parts   P}
            {bt Chicken C}
            {bt Duck    D}
            {cs Moose   M}
                {bt Ear  E}
                {bt Nose N}
            {sc}
        {sc}
        {bt Any     A "Ctrl<Key>A" "Ctrl+A" }
    {hp Custom  C ""	                }
        {bt Help1   	                }
        {bt Help2    	                }
        {bt Help3    	                }
}


#------------------------------------------------------------

proc setSenCB {state cbs} {
    set dlog [keylget cbs dialog]

    set button [WxMenuGetButton $dlog "Sensitive Target..."]
    VtSetSensitive $button $state
}

proc toggleChangedCB {cbs} {
    set target [keylget cbs widget]
    set dlog [keylget cbs dialog]

    set name [VtGetValues $target -label]
    set tstate [VtGetValues $target -set]

    set label [WxGetVar $dlog label]

    VtSetValues $label -label "You toggled $name, it's set to <$tstate>"
}

#
# Set the label to the name of the menu item that 
# got activated
#
proc genericCB {cbs} {
    set target [keylget cbs widget]
    set dlog   [keylget cbs dialog]
    set label [WxGetVar $dlog label]

    set name [VtGetValues $target -label]

    VtSetValues $label -label "Menu Item Selected is : $name"
}
set fn [VtOpen testmenu]
set dlog [VtFormDialog $fn.form -title "Menu Test"]

# Create the menu bar
set menubar [VtMenuBar $dlog.mb -helpMenuItemList {ON_VERSION INDEX TUTORIAL} ]
WxMenu $dlog $menubar $menuList1 "genericCB"

set form [VtForm $dlog.form -leftSide FORM -below $menubar]

set topLabel [VtLabel $form.topLabel \
	      -label "This top menu is an example of using the default help" \
	      -font medPlainFont]

set label  [VtLabel $form.label -label "No Callback Yet" \
	    -MOTIF_topOffset 10 \
	    -labelLeft \
	    -font largeBoldFont]


WxSetVar $dlog label $label

set bottomLabel [VtLabel $form.bottomLabel \
		 -label "This bottom menu is an example of a custom help" \
		 -MOTIF_topOffset 30 \
		 -font medPlainFont]

# Create the second  menu bar this one has a custom help menu
set menubar2 [VtMenuBar $dlog.mb2]
WxMenu $dlog $menubar2 $menuList2 "genericCB"

VtSetValues $form -bottomSide $menubar2
VtSetValues $menubar2 \
    -leftSide FORM -topSide NONE -bottomSide FORM -rightSide FORM

VtShow $dlog
VtMainLoop

