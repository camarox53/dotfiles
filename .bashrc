# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Give terminal prompt color
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ssh-keys='cd /media/cumorris/cumorris/.ssh ; ssh-add identity'
alias licsvn='svn co https://svn.lcsee.wvu.edu/oldcvs/trunk/sysstaff/ops/licenses'
alias lds='ldapsearch -h ldap.corp.redhat.com -b "ou=groups,dc=redhat,dc=com" -x'
alias shell='ssh -AXp 20110 cumorris@shell.lcsee.wvu.edu'
alias tnode='ssh -AX tnode001'
alias propshell='ssh -AXp 20110 cumorris@proprietary.lcsee.wvu.edu'
alias lshelldap='unset DISPLAY && export EDITOR=emacs && lshelldap'
alias ad-search="ldapsearch -xLL -h adbalanced.wvu.edu -b dc=wvu-ad,dc=wvu,dc=edu -D cumorris@wvu-ad.wvu.edu -W" #samaccountname=myid
alias lpshell='ssh -AXp 20110 dmzlpreciseshell001' 
alias clean='sudo rm *~'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## Terminal Prompt
PS1="\[\033[0;35m\][\w]\[\033[01;37m\]\$(parse_git_branch)\[\033[00m\]\[\033[1;33m\]\n\[\033[1;37m\]\u@\h\[\033[1;37m\]-> \[\033[1;33m\]"

# Git hacks 

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

## Debian Packages
export EDITOR='vim'
export DEBEMAIL='cmorris@mix.wvu.edu'
export DEBEDITOR='emacs -nw'
export DEBFULLNAME="Cameron Morris" 

## Git Configs
git config --global user.email "cmorris@redhat.com"
git config --global user.name "Cameron Morris"

