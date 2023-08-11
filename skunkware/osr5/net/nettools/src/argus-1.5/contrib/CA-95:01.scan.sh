#!/bin/csh -f
#
# This example involves advanced concepts in TCP networking.
# We make this available to the experienced network manager and network
# security manager.  Please do not try this at home.
#
# This script can be used to detect possible IP spoof attacks from an
# Argus data FILE.  WARNING!!!  This simple filter can generate "false
# positive" reports, but should be effective in detecting attempts to
# develop TCP connection with spoofed IP source addresses.
# You may have to discriminate potential "false positives" from actual
# IP spoof attacks using this technique.
#
# The type of attack that is tested is the simple attack strategy
# described in CERT advisory CA-95:01 "IP spoofing attacks and
# hijacked terminal connections".  This attack strategy is characterized
# as a source address forgery attack, with TCP sequence number discovery.
# This combination allows for source IP address spoofing of TCP
# connections.
#
# The script works by running ra(1), with the appropriate command line
# arguments for selecting potentially suspect network transactions.
#
# The filter that ra(1) uses, matches for TCP Argus status records that
# use the external router's as its source MAC address, but have an
# internal IP address as the source IP network address.  This is a
# reliable filter that should detect all occurrences of the simple type
# of IP spoof attack described in CA-95:01.
#
# A suspect attack scenario will involve at least 2 Argus records.  One
# of the records will be a TIMED_OUT Multiroute TCP connection.
# This status record is the transaction that is used to probe the
# host to discover a working sequence number for the "spoof" connection.
# The second will be a CLOSED, RESET, or TIMED_OUT Multiroute TCP
# connection, that will represent the actual spoofed connection.
#
# With such a simple detection scheme, you should anticipate that there
# will be conditions where legitimate internal TCP traffic will be 
# included in the filter output.  These reports do not constitute
# "false positives".   You will be looking for occurrences of two
# connections reported, with the same source and destination IP addresses,
# the external routers MAC address as the source address, one connection
# being reported as TIMED_OUT with a SYN and SYN_SENT indicator, and the
# second connection reporting a SYN, SYN_SENT, CON_ESTABLISHED and either
# TIMED_OUT, CLOSED, or RESET state.  In this situation,  there should be
# high confidence that an IP spoof attack has occurred. 
#
# Because of the various timeout conditions, the two status records will
# not necessarily be reported "in order".  But careful inspection of the
# two Argus status record start_times, should show that the "probe" record
# precedes the "spoof" attempt. 
#
# Technical Note:
#
# When trying to analyze for how "false positives" might occur in 
# this scenario, one condition is possible.  In some network
# configurations, the external router performs a reDIRect service for
# internal traffic.  This generally occurs when an internal network relys
# on static "default" routing as its principle routing strategy, and in
# this case a part of many legitimate internal TCP connections will involve
# the external router.  As a result, the routers MAC address will appear
# as the source MAC address in a part of the connection's datagrams, but
# the datagrams will have a local IP source address.
#
# When this situation occurs, and the Argus server experiences a high
# load, and subsequently drops a significant number of packets, "false
# positives" may occur.   When Argus drops large numbers of packets,
# many TCP connections will be reported without the SYN and SYN_SENT 
# conditions being seen.  Without these indicators being seen in the majority
# of local TCP connection status reports, the reliability of this detection
# scheme decreases.   In no way would we want to insure that this
# is a totally fool-proof method for detecting CA-95:01 attacks.  If
# you do suspect, however,  that a connection maybe spoofed, you should use
# investigate the matter thoroughly.
#
#
# We hope that you find this example helpful.
#
#
# FILE - name of the Argus FILE saved from a conr script once an hour
# DIR - archive DIRectory the FILE is saved to
# FREE_SPACE - free space on partition
# ARGUS_ADMIN - users to be notified via mail
# SPOOF_FILTER - Argus spoof filter
# SPOOF_OUTPUT - Argus spoof output FILE
#
set FILE=argus.`date +%m.%d.%H`:00
set DIR=/usr/argus/archive
set FREE_SPACE=`df /archive | tail -1 | awk '{ print $4 }'`
set ARGUS_ADMIN=dante
set SPOOF_FILTER="CA-95:01"
set SPOOF_OUTPUT=spoof.out
#
cd $DIR
if ( ${FREE_SPACE} <= 20000 ) then
   echo `hostname` has only ${FREE_SPACE} blocks left in ${DIR} \
      | /usr/ucb/mail -s "SPACE-PROBLEM" ${ARGUS_ADMIN}
endif
if ( ! -e ${DIR}/${FILE} | ${DIR}/${FILE} ) then
   echo "Argus data FILE empty or deleted" | /usr/ucb/mail -s "ARGUS-PROBLEM"\
      ${ARGUS_ADMIN}
   exit(1)
endif
#
# check for IP spoofing
#
if ( -e ./{SPOOF_OUTPUT} ) then
   set spoofout_size=`ls -l ./${SPOOF_OUTPUT} | awk '{print $4}'`
   /usr/argus/bin/ra -Mnc -r $DIR/$FILE -F ./${SPOOF_FILTER} \
      -w ./${SPOOF_OUTPUT} >/dev/null
   if ( $spoofout_size < `ls -l ./${SPOOF_OUTPUT} | awk '{print $4}'` ) then
      echo check ${DIR}/"${SPOOF_OUTPUT} | \
         /usr/ucb/mail -s "SPOOF-ALERT" ${ARGUS_ADMIN}
   endif
else
   /usr/argus/bin/ra -Mnc -r $DIR/$FILE -F ./${SPOOF_FILTER} \
      -w ./${SPOOF_OUTPUT} >/dev/null
   if ( -e ./${SPOOF_OUTPUT} ) then
      echo check ${DIR}/${SPOOF_OUTPUT}" | \
         /usr/ucb/mail -s "SPOOF-ALERT" ${ARGUS_ADMIN}
   endif
endif
#
compress -f $DIR/$FILE
chmod 444 $DIR/$FILE.Z
