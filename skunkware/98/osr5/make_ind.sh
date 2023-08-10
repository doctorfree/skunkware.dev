#!/bin/sh
H=`pwd` 

for i in $*
do
    d=`dirname $i`
    cd $d/..
    p=`pwd`
    b=`basename $p`
    [ -f /skunkware/vols/$b-VOLS.tar ] && {
        cd $H
        continue
    }
    rm -rf archives sso
    sh MakeSSO
    rm -rf sso
    if [ -d archives/FLOPPY ]
    then
        cd archives/FLOPPY
    else
        cd archives/TAPE
    fi
    tar cf /skunkware/vols/VOLS.tar V*
    cd ../..
    rm -rf archives
    cd $H
done
