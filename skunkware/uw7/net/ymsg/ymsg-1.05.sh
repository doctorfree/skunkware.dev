#!/bin/ksh
#
# ymsg 1.05  2000/01/10  Bela Lubkin  <filbo@armory.com>
#
# Quick-and-dirty script to read Yahoo message boards.
#
# *Guaranteed* to break any time Yahoo changes just about anything in
# the operation of their message boards -- IP addresses, URL
# construction, HTML format of the output, etc.  Thing is, it works
# today; I'll patch my copy to keep up with their changes.  Write me
# with fixes, enhancements, or defensive changes vs. Yahoo's changes.
#
# Not tested against ksh93, bash, pdksh, zsh, or any other shell
# variants that may have sprung up.  Runs on good old fashioned ksh88
# 11/16/88g + Lynx 2.8.2 or later.

cleanup()
{
  trap "" HUP INT TERM
  if [ -f $RC_old -a -f $RC_tmp ]; then
    cmp -s $RC_old $RC_tmp || {
      mv -f $RC $RC.old
      mv -f $RC_tmp $RC
    }
  fi
  rm -f $RC_end $RC_old $RC_tmp
}

onemsg() # $1 = message ID
{
  echo "========== Yahoo board: $board  Message: $1 =========="
  # messages.yahoo.com 204.71.201.183 184 185 186 187 188 109 110;
  # 109/110 seem to be behind the others.  You might have to change this
  # based on which of their machines is sane on a particular day.
  IP=204.71.201.188
  lynx -dump -nolist 'http://'$IP'/bbs?action=m&tid='$board'&sid='$sid'&mid='$1 |
    awk '
         /^   < Previous \| Next >/ { p = 1 - p; next }
         /^   Msg: [0-9]* of [0-9]*$/ { if (!e) print $4 > tmpfile; e = 1 }
         p' tmpfile=$RC_end
}

do_board() # $1 = first, $2 = last message ID
           # no args = all new; 1 arg = first->end
{
  echo "========== Yahoo board: $board =========="
  set -- "$1" "$2" `lynx -source 'http://messages.yahoo.com/?action=q&board='$board | awk '/action=m.*>Last</ { sub(/.*sid=/, ""); sub(/&.*mid=/, " "); sub(/".*/, ""); print; exit }'`
  sid=$3
  end=$4
  rcm=`awk '$1 == "'$board'" {print $2}' $RC_tmp`
  msg=${1:-${rcm:-$end}}
  end=${2:-$end}
  userend=$2
  if [ $msg -le $end ]; then
    while [ $msg -le $end ]; do
      onemsg $msg
      [ "" = "$userend" -a -f $RC_end ] && end=`cat $RC_end`
      let msg=msg+1
      [[ $msg -gt $rcm && $msg -le $end+1 ]] &&
        echo 'g/^'$board'$/s/$/ /\ng/^'$board' /s/.*/'$board $msg'/\nw' | ed - $RC_tmp
    done
  else
    echo "No new messages."
  fi
}

[ "" = "`whence -p lynx`" ] && {
  echo 'This script requires `lynx` to be on your path.' 1>&2
  echo '(and probably a recent version -- I recommend at least 2.8.2)' 1>&2
  exit 1
}

case $PAGER in
  *less*|*more*) P="$PAGER +/^======.*";;
  "") P=cat;;
  *) P="$PAGER";;
esac

RC=$HOME/.ymsgrc
RC_tmp=$RC.$$
RC_end=$RC_tmp.end
RC_old=$RC_tmp.old

trap cleanup HUP INT TERM

if [ ! -f $RC ]; then
  echo "First create $RC, listing the yahoo message boards
you wish to follow, one to a line.  For example:
scoc" 1>&2
  exit 1
fi
cp -p $RC $RC_old
cp -p $RC $RC_tmp
if [ "" != "$1" ]; then
  board=$1
  do_board $2 $3
else
  for board in `awk '{print $1}' $RC_tmp`; do
    do_board
  done
fi | $P
cleanup
