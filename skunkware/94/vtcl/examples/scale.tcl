

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
# Interactive test program for scale widget.
#
#

global scale1 scale2

proc quitCB {cbs} {
    VtClose
    exit 0
}


proc setFields {form} {
	global scale1 scale2 

	set value [VtGetValues $scale1 -value]
	set min [VtGetValues $scale1 -min]
	set max [VtGetValues $scale1 -max]

	VtSetValues $form.min_txt -value $min
	VtSetValues $form.max_txt -value $max
	VtSetValues $form.value_txt -value $value
}


proc valueCB {option cbs} {

	global scale1 scale2

	set widget_value [keylget cbs value]
	VtSetValues $scale1 $option $widget_value
	VtSetValues $scale2 $option $widget_value
}

proc scaleCB {option form cbs} {
	valueCB $option $cbs
	setFields $form
}


proc showValueCB {option cbs} {

	global scale1 scale2

	#
        #toggle button uses "set" not "value"
	#
	set widget_value [keylget cbs set]

	VtSetValues $scale1 $option $widget_value
	VtSetValues $scale2 $option $widget_value
}


#
# Start Program
#
set app [VtOpen scales]

set fn [VtStartForm $app.form -title Scales ]

set scale1 \
[VtScale $fn.scale_horz \
		-callback "scaleCB -value $fn" \
		-horizontal \
		-min 10 \
		-max 100 \
		-value 50 \
		-topSide FORM \
		-leftSide FORM]

set scale2 \
[VtScale $fn.scale_vert \
		-callback "scaleCB -value $fn" \
		-vertical \
		-min 10 \
		-max 100 \
		-value 50 \
		-leftSide FORM \
		-topOffset 20 \
	        -CHARM_topOffset 0 \
		-topSide $fn.scale_horz ]

set title_lab \
[VtLabel $fn.title_lab -label "Title:" \
		-topSide FORM \
		-leftSide $scale1 \
		-leftOffset 60  \
		-topOffset  10  \
	        -CHARM_topOffset 0 \
		-CHARM_leftOffset 7]

set title_txt \
[VtText $fn.title_txt \
	       -callback "valueCB -title" \
	       -columns 15 \
	       -topSide FORM  \
               -leftSide $title_lab \
	       -rightSide FORM \
	       -topOffset  10  \
	       -CHARM_topOffset 0]

set value_lab \
[VtLabel $fn.value_lab -label "Value:" \
		-rightSide $title_txt\
		-leftSide $scale1 \
		-topSide $fn.title_txt  \
		-labelRight]

set value_txt \
[VtText $fn.value_txt \
	       -callback "valueCB -value" \
	       -columns 3 \
	       -leftSide $value_lab \
	       -topSide $title_txt]

set min_lab \
[VtLabel $fn.min_lab -label "Min:" \
		-leftSide $scale1 \
		-rightSide $value_txt \
		-topSide $value_txt \
		-labelRight]

set min_txt \
[VtText $fn.min_txt \
	       -callback "valueCB -min" \
	       -columns 3 \
               -leftSide $min_lab \
	       -topSide $value_txt]

set max_lab \
[VtLabel $fn.max_lab -label "Max:" \
		-leftSide $scale1 \
		-rightSide $fn.min_txt \
		-topSide $fn.min_txt \
		-labelRight]

set max_txt \
[VtText $fn.max_txt \
	       -callback "valueCB -max" \
	       -columns 3 \
               -leftSide $max_lab \
	       -topSide $min_txt]


set showValue \
[VtToggleButton $fn.showValue -label "showValue" \
		-value 1 \
	        -callback "showValueCB -showValue" \
	        -topSide $max_txt \
		-leftSide $max_lab \
	        -CHARM_topOffset 1]

set quit \
[VtPushButton $fn.quit -callback quitCB  \
    -topSide $fn.showValue \
    -leftSide $fn.max_lab \
    -topOffset 10\
    -CHARM_topOffset 1]

setFields $fn

VtShow $fn
VtMainLoop

