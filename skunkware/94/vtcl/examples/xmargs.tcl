

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



proc quitCB {cbs} {
	VtClose
}

proc pbCB {cbs} {
	global tog i

	incr i
	VtSetValues $tog -xmArgs [list XmNlabelString "setvalsCB $i"]
}

set i 0

set app [VtOpen xmargs]

set form [VtFormDialog $app.form]

set tog [VtToggleButton $form.tog \
	-xmArgs "XmNset 1 XmNlabelString create"]

VtSetValues $tog -xmArgs [list XmNlabelString setvals]

set pb [VtPushButton $form.pb \
	-callback pbCB \
	-label "Do SetVals on xmArgs"]

set quit [VtPushButton $form.quit \
	-callback quitCB \
	-label "Exit"]

VtShow $form
VtMainLoop

