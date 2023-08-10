

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
#
# Demo for separator widget.
#
#
proc nextHorzSep {name length last top_wid} {

    if {$last == ""} {
        set sep [VtSeparator $name -length $length -below $top_wid \
		      -topOffset 20 \
		      -CHARM_topOffset 1]
    } else {
        set sep [VtSeparator $name -length $length -below $last]
    }

    return $sep
}

proc nextVertSep {name length last top_wid} {
    if {$last == ""} {
	set sep [VtSeparator $name -vertical  -length $length  \
			   -below $top_wid \
			   -topOffset 10 \
		           -CHARM_topOffset 0]
    } else {
	set sep [VtSeparator $name -vertical  -length $length  \
			   -below $top_wid \
			   -leftSide $last  \
			   -topOffset 10 \
		           -CHARM_topOffset 0]
    }
    return $sep
}

proc nextVertLab {name label last top_wid left_wid} {
    if {$last == ""} {
	set lab [VtLabel $name -label $label   \
	             -leftSide $left_wid    \
	             -below $top_wid    \
	             -topOffset 10      \
	             -leftOffset 10     \
		     -CHARM_topOffset 0 \
		     -CHARM_leftOffset 0]

    } else {
	set lab [VtLabel $name -label $label \
	             -leftSide $left_wid     \
	             -below $last   \
	             -leftOffset 10 \
		     -CHARM_topOffset 0 \
		     -CHARM_leftOffset 0]

    }
    return $lab
}



proc nextHorzLab {name label last top_wid left_wid} {

    if {$last == ""} {
        set lab [VtLabel $name -label $label \
	             -leftSide $left_wid    \
	             -below $top_wid    \
		     -leftOffset 5 \
		     -topOffset 10 \
		     -CHARM_topOffset 0 \
		     -CHARM_leftOffset 1]
    } else {
        set lab [VtLabel $name -label $label \
	             -leftSide $last      \
	             -below $top_wid  \
		     -leftOffset 5 \
		     -topOffset 10 \
		     -CHARM_topOffset 0 \
		     -CHARM_leftOffset 1]
    }
    return $lab
}

proc nextLab {name label last top_wid left_wid} {
    if {$last == ""} {
	set lab [VtLabel $name -label $label  \
                       -below $top_wid \
		       -leftSide $left_wid \
		       -leftOffset 10 \
		       -topOffset 10 \
		       -rightSide FORM \
		       -rightOffset 20 \
		       -CHARM_leftOffset 0 \
		       -CHARM_rightOffset 1 \
		       -CHARM_topOffset 1]

    } else {
	set lab [VtLabel $name -label $label  \
                       -below $last \
		       -leftSide $left_wid \
		       -rightSide FORM \
		       -rightOffset 20 \
		       -leftOffset 20 \
		       -topOffset 5 \
		       -CHARM_leftOffset 0 \
		       -CHARM_rightOffset 1 \
		       -CHARM_topOffset 1]
    }

}

set app [VtOpen testseparators]

set fn [VtStartForm $app.separators -title "Separators"  \
       -xmArgs "XmNmarginWidth 10
                XmNmarginHeight 10"]

set lab1 [VtLabel $fn.lab1 -label "Demo: Separator widgets" \
		  -topSide FORM \
		  -topOffset 20 \
		  -CHARM_topOffset 0]

set hsep ""
foreach i {10 12 14 16 } {
    set hsep [nextHorzSep $fn.hs$i $i $hsep $lab1]
}

set vsep ""
foreach i {10 12 14 16} {
    set vsep [nextVertSep $fn.vs$i $i $vsep $hsep]
}

set vlab ""
foreach i {S E P A R A2 T O R2} {
    set vlab [nextVertLab $fn.vl$i [cindex $i 0] $vlab $hsep $vsep]
}

set hlab ""
foreach i {E P A R A2 T O R2} {
    set hlab [nextHorzLab $fn.hl$i [cindex $i 0] $hlab $hsep $fn.vlS]
}

set ss [VtSeparator $fn.ss -horizontal -length 12 \
		      -leftSide $fn.vlE \
		      -below $fn.hlP \
		      -leftOffset 10 \
		      -CHARM_leftOffset 2]
set ssx [VtSeparator $fn.ssx -vertical -length 10 \
		      -leftSide $fn.vlP \
		      -below $ss \
		      -leftOffset 10 \
		      -CHARM_leftOffset 1]

set label1 "Two kinds of Separators"
set label2 "are demoed.  Look in the "
set label3 "menus as well             "

set lab ""
foreach i {1 2 3} {
    set lab [nextLab $fn.label$i [set label$i] $lab $ss $ssx]
}

if 0 {
set l1 [VtLabel $fn.l1 -label "Two kinds of Separators" \
                       -below $ss \
		       -leftSide $ssx \
		       -leftOffset 10 \
		       -topOffset 10 \
		       -rightSide FORM \
		       -rightOffset 20 \
		       -CHARM_leftOffset 0 \
		       -CHARM_rightOffset 1 \
		       -CHARM_topOffset 1]

set l2 [VtLabel $fn.l2 -label "are demoed.  Look in the " \
                       -below $l1 \
		       -leftSide $ssx \
		       -rightSide FORM \
		       -rightOffset 20 \
		       -leftOffset 20 \
		       -topOffset 5 \
		       -CHARM_leftOffset 0 \
		       -CHARM_rightOffset 1 \
		       -CHARM_topOffset 1]

set l3 [VtLabel $fn.l3 -label "menus as well." \
                       -below $l2 \
		       -leftSide $ssx \
		       -leftOffset 20 \
		       -topOffset 5 \
		       -CHARM_leftOffset 1 \
		       -CHARM_rightOffset 1 \
		       -CHARM_topOffset 1]


}

if 0 {
}
VtManage $fn
VtMainLoop

