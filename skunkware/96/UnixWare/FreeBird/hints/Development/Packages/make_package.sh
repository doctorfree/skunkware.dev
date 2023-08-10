#!/bin/sh
#
# script to generate a package
#

# there are many ways to automate package creation - here is my way.

# I first create a source tree.  This should include the install directory,
# the root directory and a pkginfo file as a minimum.  This should be in
# a subdirectory named the same as the package name.  Running this script
# will create a package in a file system format.  This can then be
# pkgtrans(1)'d to tape or floppies

# the first argument is the destination directory

if [ "$1" = "" ]
then
  destination=/tmp
else
  destination=$1
fi

here=`pwd`
pkg=`basename $here`

if [ ${destination}/${pkg} = ${here} ]
then
  echo "Can't put package in the same place !"
  exit
fi

if [ ! -d root ]
then
  echo "No root directory !"
fi

if [ -f install/i.save ]
then
  save=true
else
  save=false
fi

#
# generate a pkgmap file to stdout
#
# adjust the PSTAMP parameter

echo "Adjusting pkginfo"

fgrep -v PSTAMP pkginfo | fgrep -v EMAIL | fgrep -v VENDOR >/tmp/pkginfo$$
echo "VENDOR=Packaged & Released by ME!" >>/tmp/pkginfo$$
echo "EMAIL=Please report bugs/suggestions to me@mydomain" >>/tmp/pkginfo$$
echo "PSTAMP=`uname -n` `date  +%d/%m/%y-%H:%M`" >>/tmp/pkginfo$$
mv /tmp/pkginfo$$ pkginfo

echo "Generating prototype"

rm -f prototype
for file in pkginfo depend setinfo
do
  if [ -f $file ]
  then
    echo "i $file" >>prototype
  fi
done

if [ -d install ]
then
  cd install
  for f in `find * -type file -print`
  do
    echo "i ${f}=install/${f}" >>../prototype
  done
  cd ..
fi

pkgproto root=/ >>prototype
rm -f prototype.new

oldIFS=$IFS
IFS="
"
for line in `cat prototype`
do
  type=`echo $line | cut -f1 -d\ `
  class=`echo $line | cut -f2 -d\ `
  file=`echo $line | cut -f3 -d\ `
  file1st=`echo $file | cut -f1 -d\=`
  file2nd=`echo $file | cut -f2 -d\=`

    case $type in
    i|l|s) echo $line >>prototype.new
        ;;
    d)  line2=`grep "^$file1st d " /var/sadm/install/contents`
        if [ "$line2" = "" ]
        then
          perm=775
          own=root
          grp=root
        else
          perm='?'
          own='?'
          grp='?'
        fi
        echo "$type $class $file $perm $own $grp" >>prototype.new
        ;;
    f)  line2=`grep "^$file1st f " /var/sadm/install/contents`
        if [ "$line2" = "" ]
        then
          file $file2nd | egrep executable\|commands 2>&1 >/dev/null
          if [ $? = 0 ]
          then
            perm=555
          else
            file $file2nd | egrep text 2>&1 >/dev/null
            if [ $? = 0 ]
            then
              head -1 $file2nd | grep "^#!/" 2>&1 >/dev/null
              if [ $? = 0 ]
              then
                perm=555
              else
                perm=444
              fi
            else
              perm=444
            fi
  
          fi
          own=root
          grp=root
        else
          perm='?'
          own='?'
          grp='?'
        fi
        if [ $file1st = /usr/X/bin/X ]
        then
          perm=4555
        fi
        if [ $save = true ]
        then
          echo "e save $file $perm $own $grp" >>prototype.new
        else
          echo "$type $class $file $perm $own $grp" >>prototype.new
        fi
        ;;
    esac 
done

mv prototype.new prototype

IFS=$oldIFS

echo "Making the package"

# here you can choose between various options 

# compressed package not floppy compatable
#pkgmk -c -o -r`pwd` -d${destination} -f prototype $pkg

# compressed package floppy compatable
echo "pkgmk -c -o -r`pwd` -d${destination} -f prototype -l 2440 $pkg"
pkgmk -c -o -r`pwd` -d${destination} -f prototype -l 2440 $pkg

# un-compressed package floppy compatable
#pkgmk -o -r`pwd` -d${destination} -f prototype -l 2440 $pkg

# uncompressed package not floppy compatable
#pkgmk -o -r`pwd` -d${destination} -f prototype $pkg

echo "Cleaning up privileges for copying the package"

chmod -R 755 ${destination}/${pkg}
