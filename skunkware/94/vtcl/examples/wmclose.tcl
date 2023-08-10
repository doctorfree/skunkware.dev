

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
# Test the wmCloseCallback  ( WM_DELETE_WINDOW )
#   Should give popup dialog in response to WmClose

# Response to WM Close
proc wmCloseCB {cbs} {
     set dialog [keylget cbs dialog]
     
     set dd [VtMessageDialog $dialog.msg \
	     -message "You've selected the close item"]
     VtShow $dd
}

# Clean exit applet
proc ExitCB { cbd } { VtClose; exit 0 }


set app [VtOpen CloseMe]

set dlog [VtMessageDialog $app.msg -message "Try the close item" \
			  -wmCloseCallback wmCloseCB \
			  -wmDecoration ALL \
			  -ok -okLabel Exit -okCallback ExitCB  ]

VtShow $dlog
VtMainLoop
