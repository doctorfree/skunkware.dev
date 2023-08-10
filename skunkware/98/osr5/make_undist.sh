#!/bin/sh
H=`pwd` 

for i in $*
do
    d=`dirname $i`
    cd $d/..
    p=`pwd`
    b=`basename $p`
    [ -f $b-dist.tar.gz ] && {
        [ -d usr ] && rm -rf usr
        [ -d etc ] && rm -rf etc
        gzcat $b-dist.tar.gz | tar xf - 
        rm -f $b-dist.tar.gz
    }
    cd $H
done
