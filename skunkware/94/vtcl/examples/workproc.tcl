

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


global stopA
global stopB

set stopA 0
set stopB 0

proc explodeCB {cbs} {
    echo "explosion about to occur...\n\n"
    VtRemoveWorkProc 333
}

proc quitCB {cbs} {
    VtClose
}

proc workCB {data id} {
    global stopA
    global stopB

    if {$data == "A" && $stopA == 1} {
	VtRemoveWorkProc $id
	set stopA 0
    }

    if {$data == "B" && $stopB == 1} {
	VtRemoveWorkProc $id
	set stopB 0
    }
    
    echo "hello " $data "\n"
    sleep 1
}

proc startWorkCB {data cbs} {
    global stopA
    global stopB

    set stop$data 0
    VtAddWorkProc "workCB $data"
}

proc stopWorkCB {data cbs} {
    global stopA
    global stopB

    set stop$data 1
}

set ap [VtOpen "test"]

set fn [VtStartForm .work]

set start [VtPushButton $fn.start \
	   -label "Start A" -callback "startWorkCB A"]

set stop [VtPushButton $fn.stop \
	   -label "Stop A" -callback "stopWorkCB A" \
	      -leftSide $start -alignTop $start ]


set start1 [VtPushButton $fn.start1 \
	   -label "Start B" -callback "startWorkCB B"\
	      -below $start -leftSide FORM ]

set stop1 [VtPushButton $fn.stop1 \
	   -label "Stop B" -callback "stopWorkCB B" \
	      -leftSide $start1 \
	      -alignTop $start1]

set explode [VtPushButton $fn.explode \
	   -label "This call VtRemoveWorkProc with a bad id"\
	       -callback explodeCB \
	      -below $start1 -leftSide FORM]

VtPushButton $fn.quit \
    -label "Quit" -callback quitCB\
    -below $explode \

VtShow $fn

VtMainLoop
