#!/bin/sh
#
# foo.sh - a shell script to demonstrate vim
#

for i in *
do
    [ "$i" = "bar.c" ] && {
        echo "Editing bar.c now"
    }
done
