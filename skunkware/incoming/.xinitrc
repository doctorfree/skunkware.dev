# Window Maker default X session startup script 

PATH=$PATH:/usr/local/bin:/usr/local/kde/bin:/usr/sco/bin:/usr/java/bin:/usr/ucb
KDEDIR=/usr/local/kde
export PATH KDEDIR

# If you login from xdm, uncomment this to make error messages appear
# in the console window.
#
# tail -f $HOME/.xsession-errors > /dev/console
#
# choose a window manager
#

defaultwm=kde
#set the window manager to $1 if it was supplied
windowmgr=${1:-$defaultwm}

#start the respective window managers
case ${windowmgr} in
     cde|CDE)
           WINDOWMANAGER=/usr/dt/bin/Xsession
           ;;
     kde|kwm|kdestart)
           WINDOWMANAGER=startkde
           ;;
     fvwm|fvwm2)
           WINDOWMANAGER=fvwm2
           ;;
     fvwm95)
           WINDOWMANAGER=fvwm95
           ;;
     mwm)
           WINDOWMANAGER=mwm
           ;;
     pmwm|Panorama)
           WINDOWMANAGER=pmwm
           ;;
     twm)
           WINDOWMANAGER=twm
           ;;
     wmaker|WindowMaker)
           WINDOWMANAGER=wmaker
           ;;
     *)    WINDOWMANAGER=$windowmgr   # default for unknown wm's
           ;;
esac

# This turns my mouse sprite into a little sizzling fire trail but there seems
# to be a bug wrt KDE and changing desktops where it restores the background
# of the previous desktop on the current one. Pretty cool though.
#
# runcafire input/magic2.cafirerc -back colormaps/green-r.col > /dev/null 2>&1 &
#
exec $WINDOWMANAGER

