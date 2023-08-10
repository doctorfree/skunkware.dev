#!/bin/sh
# Sample shell script to illustrate how to front
# end two different binary versions of Xemacs
# one for UnixWare2.0 and one for UnixWare 1.x.
# this allows us to share the same binaries across the
# network running various 2.0 and 1.1 machines.

REL=`uname -v|cut -f1 -d"."`
if [ "$REL" = "1" ]
then
	exec /opt/bin/1.1bin/Xemacs $@
else
	exec /opt/bin/2.0bin/Xemacs $@
fi
exit 1


