

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


# Test of text dialogs and widgets
# NOte that CHARM does not support scrolled text so 
#   CHARM testing will not display text scrollbars...

source tools.tcl

proc mkTextDialog {options cbs} {
     set target [keylget cbs widget]
     
     set dlog [VtFormDialog $target.txt -okCallback CloseDialogCB]

     set lab [VtLabel $dlog.echoLab  -label "Echo Area"]

     set echoTxt [VtText $dlog.echo \
			 -leftOffset 5 \
			 -CHARM_leftOffset 1 \
			 -below $lab -rightSide FORM -rows 2 \
			 -columns 40 \
			 -readOnly ]

     set sep [VtSeparator $dlog.sep \
			  -leftSide FORM -rightSide FORM \
			  -MOTIF_topOffset 5  -below $echoTxt]

     set lab [VtLabel $dlog.lab -below $sep -label "Test Text" \
				-MOTIF_topOffset 5]

     set additionalOpts [list  -below $lab -rightSide FORM -bottomSide FORM \
			       -leftOffset 5  \
			       -CHARM_leftOffset 1\
			       -userData $echoTxt]
     eval "VtText {$dlog.test} $options $additionalOpts"

     VtShow $dlog
}

proc addTest {parent label args} {
     VtPushButton $parent.$label -label $label -callback "mkTextDialog {$args}"
}

# general callback 
proc textCB {label cbs} {
     set target [keylget cbs widget]
     set value [keylget cbs value]
     set echoTxt [VtGetValues $target -userData]
     set echoTxt [lindex $echoTxt 0]

     VtSetValues $echoTxt -value "$label callback\nValue is: <$value>"
}

proc echoCB {cbs} {
     set target [keylget cbs widget]
     set value [keylget cbs value]
     set echoTxt [VtGetValues $target -userData]

     VtSetValues $echoTxt -value "Value is: <$value>"
}
          
set ap [VtOpen "text"]

set dlog [VtFormDialog $ap.form -title "Text Test" \
		       -okLabel Exit -okCallback QuitCB ]

set rc [VtRowColumn $dlog.rc -xmArgs "XmNbackground red" -rightSide FORM]

set lotsOfText ""
for {set i 0 } {$i < 100} {incr i} {
    set lotsOfText "$lotsOfText\nLots of Text that needs a scrollbar $i"
}

addTest $rc "No Echo" -noEcho -valueChangedCallback echoCB
addTest $rc "Read Only" -value "This is read only" -readOnly
addTest $rc "Horizontal ScrollBar" -horizontalScrollBar 1
addTest $rc "Vertical ScrollBar" -verticalScrollBar 1 -rows 5 \
				 -value $lotsOfText
addTest $rc "Both ScrollBars" -verticalScrollBar 1 -horizontalScrollBar 1 \
			      -rows 5 -value $lotsOfText
addTest $rc "Callback" -callback "textCB callback"
addTest $rc "All_Callbacks" -valueChangedCallback "textCB valueChanged" \
			-callback "textCB callback" \
			-activateCallback "textCB activate" \
			-losingFocusCallback "textCB losingFocus"

VtShow $dlog

VtMainLoop

