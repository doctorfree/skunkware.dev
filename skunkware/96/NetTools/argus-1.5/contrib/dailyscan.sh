#!/bin/csh -f
#
# This script is used to report violations in the policy of a firewall gateway
# as well as report internal network services. This script is run daily at 1am.
#
# file          - name of the Argus file saved from a cron script daily
# dir           - archive directory the file is saved to
# free_space    - free space on partition
# argus_admin   - users to be notified via mail
# policy_filter - Argus policy filter
# my_net        - network name in /etc/networks or in decimal form
#
set file=monitor.`date +%m.%d.%H`:00
set dir=/usr/argus/archive
set free_space=`df /archive | tail -1 | awk '{ print $4 }'`
set argus_admin=dante
set spoof_filter=filter
set spoof_output=spoof.out
set my_net=192.0.0
#
cd $dir
#
# notify if data should be archived to tape
#
if ( ${free_space} <= 20000 ) then
   echo `hostname` has only ${free_space} blocks left in ${dir} \
      | /usr/ucb/mail -s "SPACE-PROBLEM" ${argus_admin}
endif
#
# notify if data is file does not exist or is zero length
#
if ( ! -e ${dir}/${file} | -z ${dir}/${file} ) then
   echo "Argus data file empty or deleted" | /usr/ucb/mail -s "ARGUS-PROBLEM"\
      ${argus_admin}
   exit(1)
endif
#
# Run ra and report any Argus transactions that violate the filter file
# named in the variable policy_filter.  Also, report all internal network
# services.
#
/usr/argus/bin/ra -C ./ra.conf -nc -r $dir/$file proto not igmp and \
   dst net ${my_net} | /usr/ucb/mail -s "ARGUS-DATA" ${argus_admin}
/usr/argus/bin/services -r $dir/$file dst net ${my_net} | \
   /usr/ucb/mail -s "ARGUS-SERVICES-DATA" ${argus_admin}
#
compress -f $dir/$file
chmod 444 $dir/$file.Z
