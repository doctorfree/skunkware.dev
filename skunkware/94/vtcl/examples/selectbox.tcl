

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
# Example program for selection box
#

source tools.tcl

set flag one

proc quitCB {cbs} {
    VtClose
    exit 0
}

proc okCB { cbs} {
	 global answerBox

	 set cb_value [keylget cbs selection]
	 VtSetValues $answerBox -value "Selection: $cb_value"
}

proc popDownCB {cbs} {
	global answerBox

	set sbox [keylget cbs widget]

	set value [VtGetValues $sbox -selection]
	VtSetValues $answerBox -value "Selection: $value"

	VtHide $sbox
}

proc changeItemsCB { cbs} {
	 global flag

	 set sbox [keylget cbs widget]

	 if {$flag == "one"} {
		 VtSetValues $sbox -itemList {{four} {five} {six}}
		 set flag two
	 } else {
		 VtSetValues $sbox -itemList {{one} {two} {three}}
		 set flag one
	}

}


proc defaultCB {cbs} {

	set but [keylget cbs widget]

	set sb1 [VtSelectionDialog $but.default  \
					-title "Default Selection Box" \
					-itemList { {one}
						    {two}
						    {three}} \
					-okCallback okCB]
	VtShow $sb1
}

proc itemListCB {cbs} {

	set dialog [keylget cbs dialog]
	set sb [GetDialogKey $dialog itemListDialog]

	if {$sb == ""} {
		set sb [VtSelectionDialog $dialog.sb \
						-title "Changing Items" \
						-itemList { {one}
							    {two}
							    {three}} \
						-okCallback popDownCB \
						-autoDestroy False \
						-autoHide False \
						-cancelLabel CHANGE_LIST \
				                -cancelCallback changeItemsCB]
		SetDialogKey $dialog itemListDialog $sb
	}
	VtShow $sb
}

proc selectionCB {cbs} {

	set but [keylget cbs widget]

	set sb1 [VtSelectionDialog $but.default \
					-title "Setting Selection" \
					-itemList { {one}
						    {two}
						    {three}} \
					-selection two \
					-okCallback okCB]
	VtShow $sb1
}

proc defaultButtonCB {cbs} {

	set but [keylget cbs widget]

	set sb1 [VtSelectionDialog $but.default \
					-title "-defaultButton Cancel"\
					-okCallback okCB \
					-defaultButton CANCEL]
	VtShow $sb1
}

proc filenameCB {cbs} {

	set but [keylget cbs widget]

	set sb1 [VtSelectionDialog $but.default \
					-title "-filename animals"\
					-filename animals \
					-okCallback okCB ]
	VtShow $sb1
}


proc autoHideCB {cbs} {
	set dialog [keylget cbs dialog]
	set sb [GetDialogKey $dialog autoHideDialog]

	if {$sb == ""} {
		set sb [VtSelectionDialog $dialog.default  \
					-title "AutoHide False" \
					-itemList { {one}
						    {two}
						    {three}} \
					-cancelCallback popDownCB \
					-autoHide False \
					-autoDestroy False]

		SetDialogKey $dialog autoHideDialog $sb
	}
	VtShow $sb
}


#
# Start Program
#
#

set app [VtOpen selboxes]

set fn [VtStartForm $app.form -title "Selection Boxes"]

set rc [VtRowColumn $fn.rc1]
VtPushButton $rc.but1 -label "DEFAULT" \
		      -callback defaultCB
VtPushButton $rc.but2 -label "-itemList" \
		      -callback itemListCB
VtPushButton $rc.but3 -label "-selection" \
		      -callback selectionCB
VtPushButton $rc.but4 -label "-defaultButton CANCEL" \
                      -callback defaultButtonCB
VtPushButton $rc.but6 -label "-autoHide False" \
                      -callback autoHideCB
VtPushButton $rc.but7 -label "-filename animals" \
                      -callback filenameCB

set answerBox [VtText $rc.selection -readOnly]

VtPushButton $rc.but8 -label QUIT \
		      -callback quitCB

#
#keep info about itemlist and autohide dialog since they are not destroyed
#
SetDialogKey $fn itemListDialog ""
SetDialogKey $fn autoHideDialog ""

VtShow $fn
VtMainLoop

