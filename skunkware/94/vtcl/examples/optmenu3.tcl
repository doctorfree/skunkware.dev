

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
# Test program for dynamic option menus using routines in tools.tcl
#
global mediaMenu densityMenu

proc quitCB {cbs} {
        VtClose
        exit 0
}


proc mediaCB {cbs} {
	global mediaMenu densityMenu

	set selection [WxOptionMenuGetSelected $mediaMenu]

	if {$selection == "floppy"} {
	      WxOptionMenuReplaceOptions $densityMenu [list 1440K 720K 100K] 1440K
	}

	if {$selection == "tape"} {
	     WxOptionMenuReplaceOptions $densityMenu [list 600MB 1000MB] 600MB
	}

	if {$selection == "hardDisk"} {
	   WxOptionMenuReplaceOptions $densityMenu [list 10MB 20MB 30MB 40MB] 10MB
	}
}



#
# Start Program
#

set app [VtOpen optionMenu]

set fn [VtFormDialog $app.form -title "Option Menus"]

set mediaMenu \
[WxOptionMenu $fn.mediaMenu Media: {floppy tape hardDisk} mediaCB tape]

set densityMenu \
[WxOptionMenu $fn.densityMenu Density: {} "" ""]

mediaCB {}

set quit [VtPushButton $fn.quit -callback quitCB \
                                -leftSide FORM \
				-rightSide FORM \
				-bottomSide FORM]

VtShow $fn
VtMainLoop

