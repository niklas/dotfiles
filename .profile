# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# set PATH so it includes bin from dotfiles if it exists
if [ -d ~/bin/dotfiles ] ; then
    PATH=~/bin/dotfiles:"${PATH}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# Clear the dmenu cache so it detects new paths in dotfiles
[ -f ~/.cache/dmenu_run ] && rm ~/.cache/dmenu_run

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

export FILE="ranger"
export TERMINAL="nterm"

# Ubuntu make installation of Ubuntu Make binary symlink
if [ -d /home/niklas/.local/share/umake/bin ] ; then
    PATH=/home/niklas/.local/share/umake/bin:$PATH
fi

