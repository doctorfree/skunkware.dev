#!/bin/sh
H=`pwd` 

for i in $*
do
    d=`dirname $i`
    cd $d/..
    p=`pwd`
    b=`basename $p`
    [ -d usr ] && DIRS=usr
    [ -d etc ] && DIRS="$DIRS etc"
    [ -d lib ] && DIRS="$DIRS lib"
    [ "$DIRS" ] && {
        tar cf - $DIRS | gzip -9 > $b-dist.tar.gz
        rm -rf $DIRS
    }
    cd $H
done
