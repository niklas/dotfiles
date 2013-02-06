# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return
# remove return vor rvm
[ -z "$PS1" ]

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTFILESIZE=5555555
export HISTSIZE=5555555

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

source ~/.bash/git.sh

ps_host_and_name='\[\e[01;32m\]\u@\h\[\e[00m\]'
ps_working_dir='\[\e[01;34m\]\W\[\e[00m\]'
ps_git_info='\[\e[01;35m\]\[$(parse_git_branch)\]\[\e[00m\]'
#PS1="${debian_chroot:+($debian_chroot)}$ps_host_and_name:$ps_working_dir$ps_git_info\$ "


export SCREEN_HOST=`hostname -s`

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias crep='grep --color=always'
#    export GREP_OPTIONS='--color=auto'
    export GREP_OPTIONS='--color=auto --exclude-from=/home/niklas/.grep-excludes --exclude-dir=.svn'
    export GREP_COLOR='00;38;5;226'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
alias tl='translate -w'
alias lc='locate -i'
alias neatimage='wine .wine/fake_windows/Program\ Files/Neat\ Image/NeatImage.exe'
alias lookup='beagle-query'
alias transsetname='xprop | grep "WM_CLASS" | cut -d \" -f 4'
alias svnew='svn status | grep '?' | grep -v swp'
#alias svndiff='svn diff | gview -'
svndiff () { svn diff "${@}" | gview - ;}
alias svngrep='grep --exclude .svn -r'
export DEVICE_URI="smb://hvaldos/hp4l"
export AWT_TOOLKIT=MToolkit  # fix java for compiz
export SVN_EDITOR=vim
#export VIMRUNTIME="/usr/share/vim/vim70"

alias dl='DISPLAY=:0.0'
alias dr='DISPLAY=:0.1'

#        local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
#        PS1="\[\033]0;\h:\w\007\033]1;\h\007\]\h\$ "

# set path for rubygems, DEBIAN style (/usr/share/doc/rubygems/README.Debian)
if [ -d /var/lib/gems/1.8/bin ] ; then
    PATH=/var/lib/gems/1.8/bin:"${PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

#eval `dbus-launch --auto-syntax`

if [ -d /usr/local/arduino-0015 ] ; then
    PATH="${PATH}":/usr/local/arduino-0015
fi

# rails
alias ss='./script/server'
alias sss='while (true); do (ss; sleep 1); done'
alias sc='./script/console'
alias migrate='rake db:migrate RAILS_ENV=test && rake db:migrate'
alias irb='irb --readline -r irb/completion'
alias rii='ri -Tf ansi'

autotesting() {
  echo "Starting spork in background"
  bundle exec spork &
  if type -P netcat >&/dev/null ; then
    until netcat localhost 8989 -w 1 -q 0 </dev/null
    do
      sleep 1
    done
  fi
  echo "Starting spork cucumber in background"
  bundle exec spork cucumber & 
  if type -P netcat >&/dev/null ; then
    until netcat localhost 8990 -w 1 -q 0 </dev/null
    do
      sleep 1
    done
  fi
  echo "Starting autotest with features"
  AUTOFEATURE=true bundle exec autotest -f
  kill %"bundle exec spork cucumber"
  sleep 1
  kill %"bundle exec spork"
}

lsd() { encfs ~/mnt/alice/fn0rd/.$1 ~/mnt/fn0rd/$1; }
lsdu() { fusermount -u ~/mnt/fn0rd/$1; }

alias gt='gnome-terminal'
alias tophist="cut -f1 -d\" \" ~/.bash_history | sort | uniq -c | sort -nr | head -n 30"

alias right_buttons='gconftool --type string --set /apps/metacity/general/button_layout ":maximize,minimize,close"'

alias fmplayer="DISPLAY=:0.0 mplayer -fs -vo gl"

export WIIMOTE_BDADDR="00:19:1D:83:6E:6A"
export DUNKELZAHN="00:1C:A4:C3:30:A2"
export LESS="-r"


# Some git shortcuts
alias gitdiff_staged="git diff --cached"
alias gitdiff_unstaged="git diff"
alias gitdiff_both="git diff HEAD"
alias gst="git status"
export EDITOR="vim"

alias go="gnome-open"

alias lc="cl"
function cl () {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
}

alias record_screen="ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq"

export SELENIUM_BROWSER="*firefox /usr/lib/firefox/firefox-2-bin"
export LD_LIBRARY_PATH="/usr/lib/firefox;$LD_LIBRARY_PATH"

alias find_part="find app/views/parts/stock/ vendor/plugins/*/app/views/parts/stock themes/*/views/parts/stock"

. /home/niklas/bin/git-prompt/git-prompt.sh

export PERL_CPANM_OPT="--local-lib=~/.perl5"
export PERL5LIB=~/.perl5/lib/perl5:$PERL5LIB
export PATH=~/.perl5/bin:$PATH


export RSENSE_HOME=~/src/rsense/

export MAKEFLAGS="-j3"

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi

## Al-Jazeera with Mplayer
alias aje="rtmpdump -v -r rtmp://livestfslivefs.fplive.net/livestfslive-live/ \
-y 'aljazeera_en_veryhigh?videoId=747084146001&lineUpId=&pubId=665003303001&playerId=751182905001&affiliateId=' \
-W 'http://admin.brightcove.com/viewer/us1.24.04.08.2011-01-14072625/federatedVideoUI/BrightcovePlayer.swf \
-p 'http://english.aljazeera.net/watch_now/ \
-a 'aljazeeraflashlive-live?videoId=747084146001&lineUpId=&pubId=665003303001&playerId=751182905001&affiliateId=' \
| mplayer -cache 2048 -quiet -"
