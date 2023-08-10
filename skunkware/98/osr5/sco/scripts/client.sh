#!/bin/sh
# @(#) client.sh 1.0 93/12/04
# 93/12/04 John H. DuBois III
# Minimal shell script substitute for the real client program.
# Yes, the way of dealing with cat is lame.

Port=3502
Usage="Usage: client [-u username] host [service [arg ...]]"
if [ "$1" = -u ]
then
    username=$2
    shift
    shift
fi

if [ $# -lt 1 ]
then
    echo "No hostname specified."
    echo "$Usage"
    exit 1
fi
    
host=$1
shift

if [ $# -lt 1 ]
then
    service=LIST
else
    service=$1
    shift
fi

args="$service
$username"
# empty arg terminates argument list and avoids error if no args
for arg in "$@" ""
do
    args="$args
$arg"
done

tmpfile=client.$$

# Save stderr on fd 3 so that telnet can use it,
# and then dump it for everything else.
exec 3>&2
exec 2>/dev/null

# Echo service request parameters into telnet, and then cat tty input to it.
# Save pid in a tmpfile so that parent can kill cat if neccessary.
# Save pid first to ensure it is done before telnet terminates

# kill cat if it's still hanging around
# bsd 4.2 sh insists that read be done in a subshell to which the redirection
# is done; also, it hangs waiting for the cat, so the cat-killing must be
# done in a subshell with the telnet... thus, two levels of subshells.  eww.

sh -c "echo \$$ > $tmpfile; echo '$args'; exec cat" | \
(telnet "$host" $Port 2>&3; (read pid ; kill -9 $pid) < $tmpfile)

rm -f $tmpfile
