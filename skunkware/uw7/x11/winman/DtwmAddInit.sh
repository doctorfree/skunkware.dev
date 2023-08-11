#!/bin/sh
#
# DtwmAddInit.sh - back up your current $HOME/.dt configuration files
#                  that would be overwritten and install mine
# Written by Ron Record (rr@sco.com) 21-Sep-1997
#

BLIST=
ARCH=DtwmAddInit.tar.gz
BACK=DtwmBackInit.tar

DTFILES=".dt/dtwmrc \
.dt/appmanager/Vim \
.dt/appmanager/Calendar \
.dt/appmanager/Gimp \
.dt/types/fp_dynamic/Applicat1.fp \
.dt/types/fp_dynamic/Gimp1.fp \
.dt/types/user-prefs.dt \
.dt/types/Vim.dt \
.dt/types/Term.fp \
.dt/types/Calendar. \dt
.dt/types/Calendar.fp \
.dt/types/Help.fp \
.dt/types/Help.dt \
.dt/types/Gimp.dt"

cd $HOME

for i in $DTFILES
do
    [ -f $i ] && BLIST="$BLIST $i"
done

[ "$BLIST" ] && tar cf $HOME/$BACK $BLIST

if [ -f $ARCH ] 
then
    gzcat $ARCH | tar xf -
else
    echo "$ARCH not found."
    echo "Retrieve $ARCH and rerun this script."
    [ "$BLIST" ] && {
        echo "I am reinstalling your originals."
        tar xf $HOME/$BACK
        rm -f $HOME/$BACK
    }
fi
