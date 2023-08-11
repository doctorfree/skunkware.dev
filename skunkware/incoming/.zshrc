#!/usr/local/bin/zsh

function zshopts() {
  setopt AUTO_CD	# let some/path/name be the same as 'cd some/path/name'
  setopt AUTOLIST	# automatically list possible completions on ambiguity
  setopt AUTO_NAME_DIRS	# any variable set to a dir may be referenced by ~var
  setopt AUTO_PUSHD       # push all dir's cd'ed into onto dir stack
  setopt AUTO_REMOVE_SLASH # trailing slashes get removed on completions
			  # if the next char is a word delimiter
  setopt AUTO_RESUME	# %1 = fg %1
  setopt CDABLE_VARS	# implied ~ before argument if not a dir.
  setopt COMPLETE_IN_WORD # complete args when TAB pressed even if in word
  setopt CORRECT	# these two attempt to correct common typos...
  setopt CORRECTALL
  setopt EXTENDED_HISTORY	# save timestamps with history entries
  setopt APPENDHISTORY
  #setopt GLOBDOTS	# glob & complete on dotfiles
  setopt HASH_CMDS 	# hash everything in sight :)
  setopt HASH_DIRS
  setopt HASH_LIST_ALL
  setopt HIST_IGNORE_DUPS # don't put duplicate items onto the history list
  setopt HIST_IGNORE_SPACE # don't put lines starting with a space into history
  setopt HIST_REDUCE_BLANKS # remove superfluous blanks from history items
  setopt LIST_AMBIGUOUS	# fixes a 'lil bug ... :)
  setopt LIST_TYPES	# tag file completions with their types
  setopt LONG_LIST_JOBS	# list jobs in the long format
  setopt MARK_DIRS	# mark dirs resulting from a glob with '/'
  setopt MULTIOS	# do implicit tee/cat when multiple redirections used
  setopt NOBEEP		# don't beep on ambiguous completions
  setopt NO_FLOW_CONTROL  # don't like ^S/^Q nonsense
  setopt NO_HUP		# don't SIGHUP jobs when the shell exits
  setopt NOTIFY		# notify me immediately when bg processes complete 
  setopt PATH_DIRS	# search $PATH for targets to CD into
  setopt PRINT_EXIT_VALUE # print exit value for non-zero exits
  setopt PROMPT_BANG    # replaces ! in prompt with current history event number
  setopt PUSHD_IGNORE_DUPS # don't push dirs onto stack if already there
  setopt PUSHD_MINUS	# cd -<n> starts at left side of dir stack
  setopt PUSHD_TO_HOME	# pushd w/no args goes to $HOME
  setopt SH_WORD_SPLIT	# use sh-style word-splitting
  setopt SHORT_LOOPS	# allow lazy loop syntax
}

function zshaliases()
{
  alias -g E='|egrep'
  alias rs='eval `/usr/bin/X11/resize`'
  alias vi=vim
  alias ls='/usr/local/bin/gnu-ls --color'
  alias lf='/usr/local/bin/gnu-ls -FC --color'
  alias l='/usr/local/bin/gnu-ls --color -l'
  alias lfs='lf -s'	# list files with size/type
  alias ll='ls -l'	# long listing of files (follow symlinks)
  alias la='lf -a'	# list all files with type
  alias lfsa='lf -sa'	# list all files with size/type
  alias lsd='lf -d *(-/DN)' 	# list only directories
  alias c='clear'		# handy shortcut
  alias d='date'		# handy shortcut
  alias j='jobs'		# handy shortcut
  alias m='mutt'		# handy shortcut
  alias mv='nocorrect mv' # keep CORRECTALL from annoying us with mv
  alias make='nocorrect make' # same as above for make
  alias cp='nocorrect cp' # same as above for cp
  alias rcp='nocorrect rcp' # same as above for rcp
  alias rsh='nocorrect rcmd' # same as above for rcmd
  alias mkdir='nocorrect mkdir' # same as above for mkdir
  alias time=timex
  alias find='noglob /usr/local/bin/find' # no more ... -name \*.blah :)
  alias -g M='| more'	# 'blah M' becomes 'blah | more'
  alias -g G='| grep'	# 'blah G foo' becomes 'blah | grep foo'
  alias h='history'
  alias ...='cd ../../'	# so I'm lazy ...
  alias ....='cd ../../../' # really lazy ...
}

function zshexports
{
  export PATH=/usr/local/bin:/usr/X/bin:$PATH:/usr/sbin:/usr/ccs/bin:/usr/local/infodock/bin:/usr/sco/bin:${HOME}/bin:/usr/java/bin:/usr/ucb:.
  export PAGER=pg	# pager of choice.
  export HISTFILE=~/.hist/.zsh-$TTY    # Where to save history on logout.
  export HISTSIZE=2048		# number of commands to save
  export SAVEHIST=2048
  export IGNORE_EOF=1		# number of ^Ds before we logout
  export EDITOR=/usr/local/bin/vim
  export VISUAL=/usr/local/bin/vim
  export http_proxy=http://localhost:3128/
  export gopher_proxy=http://localhost:3128/
  export ftp_proxy=http://localhost:3128/ 
  export NNTPSERVER=hobbes.sco.com
# export LESS='-cdame'
  export LESS="-FeisSj4z-4"
  export LESSOPEN="|lesspipe %s"
  export REPLYTO=${LOGNAME}@sco.com
  export CLASSPATH=/usr/java/lib:/opt/netscape/java:/usr/local/java:.
  export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib
  export MAILCHECK=5
  export MAILPATH=/var/mail/$LOGNAME\?'New mail, Ronnie.':$HOME/mailfolders/scocore\?'New scocore mail has arrived.':$HOME/mailfolders/kde-devel\?'New kde-devel mail has arrived.':$HOME/mailfolders/postfix\?'New postfix mail has arrived.':$HOME/Mail/spam.incoming\?'New spam has arrived.'
  export PUB=/x/ftp/pub
  export LS_COLORS='no=00:fi=00:di=01;33:ln=01;36:pi=04;33:so=33:bd=40;33;01:cd=40;33;01:or=40\:07;31;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:';
}

# mm: page the output of a command through more, but differently than
# a pipe through more does - you can lseek on the output (ie
# scrollback)
function mm () {
	[ -z "$*" ] && echo "Usage: mm command [args...]" || more =( $* )
}

# Timezone and Locale
if [ -z "$LANG" ]
then
    eval `defadm locale LANG`
fi
export LANG
. /etc/TIMEZONE

# interactive stuff
if [ "$PS1" != "" ]; then

  # Make sure we have the right terminal settings.
  stty intr ^\?
  stty susp 
  stty eof 

  # figure out where user is logging in from
  TTY=`tty|sed 's:/dev/::'`

  # 1. if we're on the console or a vt, we know the term type.
  # 2. otherwise, if a term type isn't already set, run tset.
  case $TTY in
    console|vt[0-9][0-9])
      export TERM=at386-ie ;;
    *) [ -z "$TERM" ] &&
       eval `tset -m scoansi:${TERM:-scoansi} -r -s -Q`
  esac

  case "$TERM" in
    (xterm|rxvt|xterm-color))
      eval `/usr/bin/X11/resize` ;
#     export PS1="%{[5;34;43m%}%n@%m%{[30m%} %~%#%{[0m%} " ;
#     export PS2="%{[5;34;43m%}] %{[0m%} " ;;
      export PS1="(!)<%m:%n>[%~] " ;
      export PS2="[%~] " ;;
    *)
      export PS1="[%n@%m %~] " ;
      export PS2="] " ;;
  esac 

  # Make sure we have a logname - rxvt on OSR5 doesn't set utmp
  # right...
  if [ -z "$LOGNAME" ]; then
	  LOGNAME=`logname 2>/dev/null`   # name of user who logged in
	  if [ $? -ne 0 ]; then           # logname failed - fake it
		  LOGNAME=`basename $HOME`        
	  fi
	  export LOGNAME
  fi

  # Safety net - make sure $PWD is set.
  if [ -z "$PWD" ]; then
    PWD=$HOME			# assumes initial cwd is HOME
    export PWD
  fi

  # the typeset will ensure that all elements of PATH are unique from
  # now on
  typeset -U PATH path

  # a couple of variables (to be treated as named directories for ~
  # expansion):
  cdpath=(.. ~ /x/ftp /x/ftp/pub /usr ~/bin)

  # suffixes to ignore for filename completions:
  fignore=(.o .c~ .old .pro .bak)

  #bindkey -v				# vi-style line-editing
  bindkey -e				# emacs-style line-editing
  
  # show all login/logout activity:
  watch=( all )

  # set exported variables
  zshexports
  # Set zsh options
  zshopts
  # Set up aliases
  zshaliases
  # Source my zsh command completions
  . ~/.zcompctl

  # IF we are on the console, fire up X.
  if [ $TTY = "console" ]
  then
    export DISPLAY=unix:0
    startx 2>$HOME/.startx.errs
    sleep 1
    kill -9 `ps -ef | grep netscape | grep -v grep | awk '{ print $2 }'` \
      2>/dev/null
	exit
  fi
fi
