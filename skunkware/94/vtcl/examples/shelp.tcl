

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
# Script to test the various options of the object class
#

source tools.tcl

proc shortCB  {target cbs} {

    set str [keylget cbs helpString]

    if {$str != ""} {
	VtSetValues $target -label $str
    } else {
	VtSetValues $target -label "Short Help"
    }
}

proc createObjects {parent shortLabel} {

    set butLabels { "Button 1" "Button 2" "Button 3" }
    foreach but $butLabels {
	VtPushButton $parent.$but \
	    -shortHelpString "Short Help for $but" \
	    -shortHelpCallback "shortCB $shortLabel"
    }

    VtPushButton $parent.exit -label Exit -callback QuitCB \
	-shortHelpString "Exits this script" \
	-shortHelpCallback "shortCB $shortLabel"

}

set ap [VtOpen ObjectTest]

set dlog [VtFormDialog $ap.dlog ]

set rc [VtRowColumn $dlog.rc -topSide FORM -leftSide FORM -rightSide FORM]

set sep [VtSeparator $dlog.sep -below $rc -leftSide FORM -rightSide FORM]

set shortLabel [VtLabel $dlog.shortLab -label "Short Help"\
	 -topSide NONE -bottomSide FORM -leftSide FORM -rightSide FORM\
	 -bottomOffset 2]

VtSetValues $rc -bottomSide $sep 
VtSetValues $sep -bottomSide $shortLabel -topSide NONE

createObjects $rc $shortLabel


VtShow $dlog

VtMainLoop

