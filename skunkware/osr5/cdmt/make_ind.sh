#!/bin/sh
H=`pwd` 

for i in $*
do
    d=`dirname $i`
    cd $d/..
    rm -rf archives sso
    sh MakeSSO
    rm -rf sso
    cd archives/TAPE
    tar cf ../../VOLS.tar V*
    cd $H
done
