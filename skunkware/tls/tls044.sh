:
#	@(#) postscript 23.3 91/10/07 
#
#	Copyright (C) 1989-1991 The Santa Cruz Operation, Inc.
#		All Rights Reserved.
#	The information in this file is provided for the exclusive use of
#	the licensees of The Santa Cruz Operation, Inc.  Such users have the
#	right to use, modify, and incorporate this code into other products
#	for purposes authorized by the license agreement provided they include
#	this notice and the associated copyright notice with any such product.
#	The information in this file is provided "AS IS" without warranty.
#
#	lp interface for postscript printer
#     arg1 is print job id
#     arg2 is login of user who submitted job
#     arg3 is title ???
#     arg4 is the number of copies to print
#     arg5 is a list of the -o options passed
#     arg6... are paths to files to be printed
#

#  Modifications"
#  93/12/19 Terry B. Rhodes (tbr@88open.org)
#
#
#  this program attempts to find a %! (as in %!PS-Adobe) in the
#  first non-blank line of the file.  If it does it assumes the
#  file is raw postscript and prints it as such. Otherwise the
#  file is treated as text and an appropriate postscript header
#  is added.  This all works fine unless the %! doesnt really
#  describe a postscript file or unless you want the actual
#  postscript program to print instead of be interpreted.
#  In these cases you should use the
#
#		-o raw
#
#  option to get textual output of the submitted file.
#
#
#  -o options not supported include , nofilebreak, length, width,
#      lpi, cpi, stty
#
#  this probably should have all these, fonts and other nice options
#  too, wouldn't be too hard to add.
#

# usage: FileIsPostscript FILEPATH
#
# if %! appears in the first non-blank line of the file
# we assume the file is a postscript program
# Many programs only scan the first 4 chars of the first line
# this doesnt appear good enough for dos/windows driver output
#
FileIsPostscript()
{
Z="`awk <$1 2>/dev/null '
   {
   if ( NF < 1)
      { next; }
   if ( index($0, "%!") != 0 )
      { printf("true"); }
   exit
   }
'`"
$DEBUG && awk <$1 2>/dev/null '
   {
	print $0
   if ( NF < 1)
      { next; }
   if ( index($0, "%!") != 0 )
      { printf("true"); }
   exit
   }
' >>/tmp/$PRINTER.out

[ "$Z" = "true" ] && return 0
return 1
}



PrintBannerPages()
{
# nhead gets the value of BANNERS or 1 by default
nhead=`sed -n 's/^BANNERS=//p' /etc/default/lpd`
[ "$nhead" -eq 0 ] && nhead=1
[ "$nhead" -gt 5 ] && nhead=0

if [ "$nhead" -gt 0 ]
then
	# get the local system id
	if test -r /etc/systemid
	then
		sysid=`sed 1q /etc/systemid`
	else
		sysid=`uname -n`
	fi
		
	# user = fifth field of /etc/passwd
	user=`sed -n "s/^$USER:.*:.*:.*:\(.*\):.*:.*$/\1/p" /etc/passwd`
	# todays date
	tdate=`date`
	
	while [ "$nhead" -gt 0 ]
	do
		echo "%!"
		echo "/i{72 mul}def"
		echo "/m{moveto}def"
		echo "/s{show}def"
		echo "/o{true charpath stroke}def"
		echo "/rct{moveto dup neg 3 1 roll 0 exch rlineto"
		echo "  0 rlineto 0 exch rlineto closepath}def"
		echo "6.5 i 1.1 i 0.95 i 8.9 i rct 0.0 setgray stroke"
		echo "6.5 i 1.1 i 0.95 i 8.9 i rct 0.8 setgray fill"
		echo "/Helvetica-Bold findfont 45 scalefont setfont"
		echo "1.0 setgray ($USER) 1.0 i 9.5 i m s"
		echo "0.0 setgray ($USER) 1.0 i 9.5 i m o"
		echo "/Helvetica findfont 20 scalefont setfont"
		echo "($user) 1.0 i 9.0 i m s"
		echo "(Request id: $JOBID) 1.0 i 8.5 i m s"
		echo "(Copies: $NUMCOPIES) 1.0 i 8.0 i m s"
		echo "(Options: $OPTIONS) 1.0 i 7.5 i m s"
		echo "(Machine: $sysid) 1.0 i 7.0 i m s"
		echo "(Date: $tdate) 1.0 i 6.5 i m s"
		[ "$TITLE" ] && 
			echo "(Title: $TITLE) 1.0 i 6.0 i m s"
		echo "showpage"
	
		nhead=`expr $nhead - 1`
	done  
fi
}


# main()

#stty exta clocal hupcl cs8 cread icanon ixon icrnl 0<&1
#stty exta -opost onlcr tab3 ixon -echo ixany -ixoff -parity -hupcl 0<&1
#stty 9600 clocal hupcl cs8 cread icanon ixon ixoff icrnl 0<&1
stty ixon ixoff 0<&1


# print job defaults
MODE=port  # print in portrait mode
RAW=false  # process file as text file

PRTBANNER=true
nhead=`sed -n 's/^BANNERS=//p' /etc/default/lpd`
[ "$nhead" -eq 0 ] && PRTBANNER=false


# DEBUG=true
DEBUG=false

PRINTER=`basename $0`

$DEBUG && date >>/tmp/$PRINTER.out
$DEBUG && echo "$*" >>/tmp/$PRINTER.out

JOBID="$1" ; shift
$DEBUG && echo "JOBID is $JOBID" >>/tmp/$PRINTER.out
USER="$1" ; shift
$DEBUG && echo "USER is $USER" >>/tmp/$PRINTER.out
TITLE="$1" ; shift
$DEBUG && echo "TITLE is $TITLE" >>/tmp/$PRINTER.out
NUMCOPIES="$1" ; shift
[ "$NUMCOPIES" -lt 1 ] && NUMCOPIES=1
$DEBUG && echo "NUMCOPS is $NUMCOPIES" >>/tmp/$PRINTER.out
OPTIONS="$1" ; shift
$DEBUG && echo "OPTIONS is $OPTIONS" >>/tmp/$PRINTER.out
FILES="$*"
$DEBUG && echo "FILES is $FILES" >>/tmp/$PRINTER.out


for OPTION in $OPTIONS
do
	case $OPTION in
		[Rr]aw | RAW | [Gg] )  RAW=true ;;
		[Ll]and*2 | LAND*2 | [Ll]2 )  MODE=land2 ;;
		[Ll]and* | LAND* | [Ll] )  MODE=land ;;
		[Pp]ort* | PORT* | [Pp] )  MODE=port ;;
      [Bb]an* | BAN* | [Bb] )     PRTBANNER=true ;;
      [Nn]o[Bb]an | NOBAN* | [Nn][Bb] )   PRTBANNER=false ;;

		# these are tbr options
		132 )	MODE=land ;;
		sideways ) MODE=land ;;
	esac
done
export MODE


# the default text to postscript filter.
TEXTFILTER=/usr/spool/lp/bin/text2post


#Set up the default filter.
if [  -x "${LOCALPATH}/lp.cat" ]
then
	LPCAT="${LOCALPATH}/lp.cat 0"
else
	LPCAT="cat"
fi

#If we are not using an output filter, use the default one.
[ -z "${FILTER}" ] && FILTER="${LPCAT}"


# this all appears to support drain.output, which is not needed ???
# ${SPOOLDIR:=/usr/spool/lp}
# ${LOCALPATH:=${SPOOLDIR}/bin}

DRAIN=""
[ -x "${LOCALPATH}/drain.output" ] && DRAIN="${LOCALPATH}/drain.output 1"


echo "\004\c"						# M003

$DEBUG && echo "FILTER is $FILTER" >>/tmp/$PRINTER.out
$DEBUG && echo "TEXTFILTER is $TEXTFILTER" >>/tmp/$PRINTER.out

$PRTBANNER && PrintBannerPages


i=1; FF=false
while [ $i -le $NUMCOPIES ]
do
	for FILE in $FILES
	do
		PRINTRAW=$RAW
		if FileIsPostscript $FILE
		then
			$DEBUG && echo "$FILE is a postscript file" >>/tmp/$PRINTER.out

			# switch the semantics on postscript files
			# so -o raw prints the postscript code
			PRINTRAW=true ; $RAW && PRINTRAW=false
		fi
			
		if $PRINTRAW
		then
			$DEBUG && echo "Printing $FILE in raw mode" >>/tmp/$PRINTER.out
			0<${FILE} eval ${FILTER} 2>&1
		else
			$DEBUG && echo "Printing $FILE in text mode" >>/tmp/$PRINTER.out
			$FF && echo "\014"
			0<${FILE} eval ${FILTER} 2>&1 | $TEXTFILTER
		fi
	done

	i=`expr $i + 1` ; FF=true
done 
echo "\004\c"							# M003

#Draining characters might be necessary.
${DRAIN}

exit 0
