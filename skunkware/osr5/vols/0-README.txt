skunkware/osr5/vols

These are tar archives of media images for SCO OpenServer 5 suitable for
installation using the SCO Software Manager (/etc/custom).

Download and extract into a convenient temporary directory
(e.g. "mkdir /tmp/foo ; cd /tmp/foo ; tar xf /path/to/foo-1.0-VOLS.tar")
then use custom to install from 'Media Image' files.

Interactively:
	custom 
	Menu: "Software" -> Install New...
	"From <yourhost>" Continue ...
	Media Device - Select "Media Images"  Continue...
	Enter Pathname of Directory you extracted tar archive into above  OK.

Can also be done from a command line:
	custom -p PRODUCT_NAME -i -z /path/to/vols/directory

Product Name  can sometimes be gleaned from component value in VOL.000.000 file
VOLS=/$dirpath_to_vols/VOL.000.000
cmpnt=`grep "component" < $VOLS | head -1 | cut -d= -f2 | cut -d: -f1`
pkg=`grep "component" < $VOLS | head -1 | cut -d= -f2 | cut -d: -f2`
custom -p $cmpnt:$pkg -i -z /$dirpath_to_vols

e.g. 
$ grep component /tmp/VOL.000.000 
 components=SKUNK98:Xmixer::1.1
$ custom -p SKUNK98:Xmixer::1.1 -i -z /tmp)
