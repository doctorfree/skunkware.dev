#!/bin/sh

# sample script to process ipassign form and pass it on 
# to another process. this script does some simple error
# checking

echo Content-type: text/html
echo

echo "<TITLE>IP Address Request Response</TITLE>"
echo "<h1>IP Address Request Response</h1>"
echo "<p>"

F1=`echo $QUERY_STRING|cut -f1 -d"&"`
F2=`echo $QUERY_STRING|cut -f2 -d"&"`
F3=`echo $QUERY_STRING|cut -f3 -d"&"`
F4=`echo $QUERY_STRING|cut -f4 -d"&"`
F5=`echo $QUERY_STRING|cut -f5 -d"&"`
F6=`echo $QUERY_STRING|cut -f6 -d"&"`
F7=`echo $QUERY_STRING|cut -f7 -d"&"`

EMAIL=`echo $F1|cut -f2 -d"="`
REQ=`echo $F2|cut -f2 -d"="`
NET=`echo $F3|cut -f2 -d"="`
MACHINE=`echo $F4|cut -f2 -d"="`
MAC=`echo $F5|cut -f2 -d"="`
DESC=`echo $F6|cut -f2 -d"="`

TMP=`echo $EMAIL| sed -e 's/\+/_/g'`
EMAIL=$TMP
TMP=`echo $DESC| sed -e 's/\+/ /g'`
DESC=$TMP
TMP=`echo $REQ| sed -e 's/\+/ /g'`
REQ=$TMP
TMP=`echo $NET| sed -e 's/\+/ /g'`
NET=$TMP


if [ "$EMAIL" = "XXXXX@groupwise.novell.co.uk" ]
then
	echo "<p><em>Sorry, you did not specify a valid email address."
	echo "No request has been sent."
	echo "<p>Go back a page and fill in a valid email address field "
	echo "and resubmit.</em>"
	exit 0
fi



if [ "$REQ" = "Assign" ]
then
	FAULT=0
	if [ "$DESC" = "" ]
	then
		echo "<p><em>Sorry, you did not specify descriptive text.<br>"
		FAULT=1
	fi
	if [ "$MACHINE" = "" ]
	then
		echo "<em>Sorry, you did not specify a machine name.<br>"
		FAULT=1
	fi

	if [ "$FAULT" -eq 1 ]
	then
		echo "<p>No request has been sent."
		echo "<p>Go back a page and fill in the fields "
		echo "and resubmit.</em>"
		exit 0
	fi

fi

echo "<p>The response to your request will be sent to:\n\t<pre>   <em>$EMAIL</em></pre>"


echo "<hr>"
echo "<p>The request submitted was as follows:<p>"
echo "<p>Request type	:<em>$REQ</em><p>"
echo "Network:\t<em>$NET</em><p>"
echo "Machine name:\t<em>$MACHINE</em><p>"
echo "MAC address:\t<em>$MAC</em><p>"
echo "Description:\t<em>$DESC</em><p>"
echo "<hr>"


TMPF=/tmp/ipass.$$
echo "From: $EMAIL" >$TMPF
echo "Subject: $REQ" >>$TMPF
echo  >> $TMPF
echo "Return-address: $EMAIL" >>$TMPF

if [ "$REQ" != "GetEntry" ]
then
echo "net: $NET" >>$TMPF
echo "owner: $DESC" >>$TMPF
echo "name: $MACHINE" >>$TMPF

		
else
	case $NET in
	UKB*) DOM=.ukb.novell.com ;;
	UKW*) DOM=.ukw.novell.com;;
	UKH*) DOM=.ukw.novell.com;;
	*) DOM="";;
	esac
echo "name: $MACHINE$DOM" >>$TMPF
fi
echo "mac: $MAC" >>$TMPF

cat $TMPF| assignip.daemon

rm $TMPF
exit 0
