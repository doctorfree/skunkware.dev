

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
# allows browsing of a pixmap directory
#

source tools.tcl

global pDir
global lst

proc selectCB {parent cbs} {  
	global pDir
	global icon icon2 icon3

	set file "$pDir/[keylget cbs selectedItemList]"
  	echo "File is " $file "\n"

	if {! [info exists icon]} {
		set fn [VtFormDialog $parent.picture -modeless \
		       -wmDecoration {TITLE BORDER} ]
		VtLabel $fn.Label -labelCenter -leftSide FORM -rightSide FORM
		set icon [VtLabel $fn.icon -pixmap $file]
		VtLabel $fn.Pixmap -labelCenter -leftSide FORM -rightSide FORM
		set icon2 [VtPushButton $fn.icon2 -pixmap $file ]
		VtLabel $fn.ip \
			 -label "Insensitive Pixmap" \
			 -labelCenter -leftSide FORM -rightSide FORM
		set icon3 [VtPushButton $fn.icon3 -pixmap $file -sensitive 0]
		VtManage $fn
	}
	
	VtSetValues $icon -pixmap $file
	VtSetValues $icon2 -pixmap $file
	VtSetValues $icon3 -pixmap $file
}

proc setPDirCB {cbs} {
	global pDir
	global lst

	set dir [keylget cbs value]
  	echo "Dir is " $dir "\n"
	
	set ret [catch {cd $dir} errMsg]
	if {$ret != 0} {
		echo "\n\nError: $errMsg\n"
		return
	}
	set pDir $dir
	set files [glob  *]

	VtSetValues $lst -itemList $files
}

set pDir "/usr/include/X11/bitmaps/xdt_p_large"
#set pDir "/u/gko/X11/WidgetServer/ms/wstcl/tests"


set ap [VtOpen pixmaps]

set fn [VtFormDialog $ap.form -okLabel Exit -okCallback QuitCB ]

VtLabel $fn.lab -label "Directory to browse"

VtText $fn.txt -value $pDir -columns 50 -callback setPDirCB

cd $pDir
set files [glob  *.px]

set lst [VtList $fn.list \
		-itemList "$files" \
		-rows 8\
		-callback "selectCB $fn" \
		-leftOffset 6 -leftSide FORM \
		-rightSide FORM \
		-topOffset 5 -bottomSide FORM ]

VtShow $fn

VtMainLoop
