# ~/.bashrc: executed by bash(1) for non-login shells.
# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# ^^ TODO check if that works in ubuntu, too

# Put your fun stuff here.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTFILESIZE=9001
export HISTSIZE=9001

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
# gentoo has different lesspipe
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

[ -x ~/.bash/git.sh ] && source ~/.bash/git.sh

ps_host_and_name='\[\e[01;32m\]\u@\h\[\e[00m\]'
ps_working_dir='\[\e[01;34m\]\W\[\e[00m\]'
ps_git_info='\[\e[01;35m\]\[$(parse_git_branch)\]\[\e[00m\]'
#PS1="${debian_chroot:+($debian_chroot)}$ps_host_and_name:$ps_working_dir$ps_git_info\$ "


#export SCREEN_HOST=`hostname -s`

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
    alias grep='grep --color=auto --exclude-from=/home/niklas/.grep-excludes --exclude-dir=.svn'
    export TERM=rxvt
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='exa'
alias ttt="t&t&t&t&t"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
alias tl='translate -w'
alias lc='locate -i'
alias neatimage='wine .wine/fake_windows/Program\ Files/Neat\ Image/NeatImage.exe'
alias transsetname='xprop | grep "WM_CLASS" | cut -d \" -f 4'
#alias svndiff='svn diff | gview -'
svndiff () { svn diff "${@}" | gview - ;}
alias svngrep='grep --exclude .svn -r'
export DEVICE_URI="smb://hvaldos/hp4l"
export AWT_TOOLKIT=MToolkit  # fix java for compiz
export SVN_EDITOR=vim
#export VIMRUNTIME="/usr/share/vim/vim70"

alias dl='DISPLAY=:0.0'
alias dr='DISPLAY=:0.1'

alias mm='milkmaid'

#        local TITLEBAR='\[\033]0;\u@\h:\w\007\]'
#        PS1="\[\033]0;\h:\w\007\033]1;\h\007\]\h\$ "

# set path for rubygems, DEBIAN style (/usr/share/doc/rubygems/README.Debian)
#if [ -d /var/lib/gems/1.8/bin ] ; then
#    PATH=/var/lib/gems/1.8/bin:"${PATH}"
#fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    [[ ":$PATH:" == *":$HOME/bin:"* ]] || PATH=~/bin:"${PATH}"
fi

#eval `dbus-launch --auto-syntax`

if [ -d /usr/local/arduino-0015 ] ; then
    PATH="${PATH}":/usr/local/arduino-0015
fi

if [ -d /opt/google/android-sdk-linux_x86 ] ; then
    PATH="${PATH}":/opt/google/android-sdk-linux_x86/tools:/opt/google/android-sdk-linux_x86/platform-tools
fi

# rails
alias ss='./script/server'
alias be="bundle exec"
alias sss='foreva be rails server'
alias zsss='foreva zeus server'
alias mxp='foreva iex -S mix phx.server'
alias sc='./script/console'
alias migrate='bundle exec rake db:migrate RAILS_ENV=test && bundle exec rake db:migrate'
alias irb='irb --readline -r irb/completion'
alias rii='ri -Tf ansi'
alias cu="truncate --size 0 log/*.log; clear; bundle exec cucumber --drb -r features/"
alias killall_spork="ps ax | grep spork | grep -v grep | tail -n 2 | cut -b 1-6 | xargs kill"
alias add="git add -p"

alias todo="mm task add"
if [[ -x /usr/bin/ack ]]
then
  alias ack="ack -i"
else
  alias ack="ack-grep -i"
fi
alias _watch_git_status="watch --color 'git -c color.status=always status'"

foreva() {
    restart_time=3

    while true; do
        $@
        echo "Will restart in ${restart_time}s..."
        sleep $restart_time
    done
}

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
alias t="urxvt &"
alias tophist="cut -f1 -d\" \" ~/.bash_history | sort | uniq -c | sort -nr | head -n 30"

alias right_buttons='gconftool --type string --set /apps/metacity/general/button_layout ":maximize,minimize,close"'

alias fmplayer="DISPLAY=:0.0 mplayer -fs -vo gl"

export WIIMOTE_BDADDR="00:19:1D:83:6E:6A"
export DUNKELZAHN="00:1C:A4:C3:30:A2"
export LESS="-r"


# Some git shortcuts
alias gitdiff_staged="git diff --cached"
alias gitdiff_unstaged="git diff"
alias gc="git diff"
alias gdc="git diff --cached"
alias gitdiff_both="git diff HEAD"
alias gst="git status"
alias gs="git status"
alias ci="git commit -m"
alias add="git add -p"
alias feature="git flow feature"
alias hotfix="git flow hotfix"
alias release="git flow release"
export EDITOR="vim"
alias gg="git graph"
# baguette working dir
alias bwd='pwd | sed -e s*/*🥖*g'

alias go="xdg-open"
alias watch_gitdiff="watch -c 'git diff --color=always; echo \"Unstaged ^^^^^ |||| vvvvv staged\"; git diff --cached --color=always'"

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

[ -x '/home/niklas/bin/git-prompt/git-prompt.sh' ] && source /home/niklas/bin/git-prompt/git-prompt.sh


export RSENSE_HOME=~/src/rsense/

export MAKEFLAGS="-j6"

## Al-Jazeera with Mplayer
alias aje="rtmpdump -v -r rtmp://livestfslivefs.fplive.net/livestfslive-live/ \
-y 'aljazeera_en_veryhigh?videoId=747084146001&lineUpId=&pubId=665003303001&playerId=751182905001&affiliateId=' \
-W 'http://admin.brightcove.com/viewer/us1.24.04.08.2011-01-14072625/federatedVideoUI/BrightcovePlayer.swf \
-p 'http://english.aljazeera.net/watch_now/ \
-a 'aljazeeraflashlive-live?videoId=747084146001&lineUpId=&pubId=665003303001&playerId=751182905001&affiliateId=' \
| mplayer -cache 2048 -quiet -"

alias new_torrents="ssh torrents ruby /home/niklas/cataract/script/runner 'Torrent.recognize_new'"

export CAPYBARA_CHROME=yes
export LOLCOMMITS_TRANZLATE=1
export KOPFLOS=no
export CLOCKWORK_EMBER_ROOT="/home/niklas/ember/clockwork.js"

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi
GPG_TTY=$(tty)
export GPG_TTY

# really late so rvm does not complain about its ../bin being in the first
# place of PATH
if [ -x ~/.rvm/scripts/rvm ]; then
  unset RUBYOPT
  source ~/.rvm/scripts/rvm
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

# allow locking screen from /etc/acpi/actions
xhost +local:root > /dev/null

[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts" # Load shortcut aliases


[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

[ -f $HOME/.asdf/asdf.sh ] && . $HOME/.asdf/asdf.sh
[ -f $HOME/.asdf/completions/asdf.bash ] && . $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
