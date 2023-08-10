

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



proc Check {val exp} {
    if ![cequal $val $exp] {
        error "@$val@ != @$exp@"
    }
}

proc DoSet w {
    WxSetVar $w one ONE-$w
    WxSetVar $w two TWO-$w
    WxSetVar $w three(1) THREE-1-$w
    WxSetVar $w three(2) THREE-2-$w
    WxSetVar $w three(3) THREE-3-$w
}

proc DoGet w {
    Check [WxGetVar $w one] ONE-$w
    Check [WxGetVar $w two] TWO-$w
    Check [WxGetVar $w three(1)] THREE-1-$w
    Check [WxGetVar $w three(2)] THREE-2-$w
    Check [WxGetVar $w three(3)] THREE-3-$w
}

proc DoRef w {
    set names [lsort [array names [WxWidgetVarRef $w three]]]
    Check $names {1 2 3}
    foreach i $names {
        lappend vals [WxGetVar $w three($i)]
    }
    Check $vals [list THREE-1-$w THREE-2-$w THREE-3-$w]
}

# cmdtrace on [open cmd.log w]

DoSet a.b.c
DoGet a.b.c
DoRef a.b.c

DoSet a.b.d
DoGet a.b.d
DoRef a.b.d
