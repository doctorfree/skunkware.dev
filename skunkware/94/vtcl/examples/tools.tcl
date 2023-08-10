

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


global DisplayTxt

#
# Initialize the Display Text area
#
proc InitDisplay {txt} {
     global DisplayTxt

     set DisplayTxt $txt
}

#
# and sleeps for a delayed number of seconds.
#
proc Display {delay args} {
     global DisplayTxt

     VtSetValues $DisplayTxt -value [join $args]
     if {$delay > 0} {sleep $delay}
}

#
# Just close the connection
#
proc QuitCB {cbs} {
	VtClose
}

#
# This closes the Dialog that the button was in. Actually, it destroys it.
#
proc CloseDialogCB {cbs} {
     set target [keylget cbs widget]
     VtDestroyDialog $target
}

#
# Makes a button with label set to label and the callback set
# to cb.
# 
# It returns the reference to the button.
#
proc MakeCenteredButton {name label cb} {

    set pb [VtPushButton $name -label $label -callback $cb \
	    -labelCenter]

    return pb
}

#------------------------------------------------------------
#
# This sets the key pair in the dialog's userData field
#
proc SetDialogKey {dlog key data} {
    WxSetVar $dlog $key $data
}

#
# does SetDialogKey, but on a cbs
#
proc SetDialogKeyCBS {cbs key data} {
    set dlog [keylget cbs dialog]
    SetDialogKey $dlog $key $data
}

#
# This gets the data associated with a key from the dialog's userData field
#
proc GetDialogKey {dlog key} {
    return [WxGetVar $dlog $key]
}

proc GetDialogKeyCBS {cbs key} {
    set dlog [keylget cbs dialog]

    return [GetDialogKey $dlog $key]
}


proc CBSGetWidgetShortName {cbs} {
	set w [keylget cbs widget]
	set wl [split $w .]
	set wi [expr "[llength $wl] - 1"]
	set short [lindex $wl $wi]
	return $short
}
