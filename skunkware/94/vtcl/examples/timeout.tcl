

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


global t
set t 0

source tools.tcl

proc Exit {cbs} {
    VtClose
}

proc timeout {label cbs} {
    global t

    set id [VtAddTimeOut -callback "timeout $label" -interval 500]
    VtSetValues $label -label "Time out called $t times\nTimer ID is $cbs" \
	-userData $id
    incr t
}

proc Start {cbs} {
    set id [GetDialogKeyCBS $cbs id]
    set label [GetDialogKeyCBS $cbs label]

    if {$id != ""} {return}

    set id [VtAddTimeOut -callback "timeout $label" -interval 500]

    SetDialogKeyCBS $cbs id $id

    set but [GetDialogKeyCBS $cbs Stop]
    VtSetSensitive $but 1

    set but [GetDialogKeyCBS $cbs Start]
    VtSetSensitive $but 0
}

proc Stop {cbs} {
    set id [GetDialogKeyCBS $cbs id]

    VtRemoveTimeOut $id

    SetDialogKeyCBS $cbs id ""

    set but [GetDialogKeyCBS $cbs Stop]
    VtSetSensitive $but 0

    set but [GetDialogKeyCBS $cbs Start]
    VtSetSensitive $but 1
}


set ap [VtOpen TimeOut]

set dlog [VtFormDialog $ap.dlg ]

set lab [VtLabel $dlog.lab -label "Waiting for start...."]

set sep [VtSeparator $dlog.sep -leftSide FORM -rightSide FORM]

set rc [VtRowColumn $dlog.rc -rightSide FORM -leftSide FORM -horizontal]

foreach b {Start Stop Exit} {
    set but [VtPushButton $rc.$b -label $b -callback $b]
    SetDialogKey $dlog $b $but
}

SetDialogKey $dlog label $lab
SetDialogKey $dlog id ""

# Get the Stop button and desensitize it
set but [GetDialogKey $dlog Stop]
VtSetSensitive $but 0

VtShow $dlog


VtMainLoop
