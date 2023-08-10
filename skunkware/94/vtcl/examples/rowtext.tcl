

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
# This tests a typical use of rowcolumns
#

set app [VtOpen RowCol]

set dlog [VtFormDialog $app.form]

set rc [VtRowColumn $dlog.rc -packing TIGHT -vertical \
       -rightSide FORM -leftSide FORM -bottomSide FORM -background urgentColor]

foreach b  { Name Address Country Telephone } {
    VtLabel $rc.$b  -label "$b:"
    VtText $rc.Text$b
}

VtShow $dlog

VtMainLoop
