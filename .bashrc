# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# And store a decent amount of history
export HISTSIZE=1000000

export EDITOR=vim;

# User specific aliases and functions

        RED="\[\033[31m\]"
     YELLOW="\[\033[0;33m\]"
 	  GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
 LIGHT_BLUE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function parse_git_branch {

  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^On branch ([^${IFS}]*)"
  remote_pattern="Your branch is (.*) with"
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    state="${LIGHT_RED}⚡"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}↑"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}↕"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function host_and_domain() {
    PRETTY_HOSTNAME=`echo $HOSTNAME | awk -F "." '{print $1}'`
    PRETTY_DOMAIN=`echo $HOSTNAME | awk -F "." '{print $2}'`
    echo "${PRETTY_HOSTNAME}${GREEN}.${PRETTY_DOMAIN}"
}

function host_and_domain_noformat() {
    PRETTY_HOSTNAME=`echo $HOSTNAME | awk -F "." '{print $1}'`
    PRETTY_DOMAIN=`echo $HOSTNAME | awk -F "." '{print $2}'`
    echo "${PRETTY_HOSTNAME}.${PRETTY_DOMAIN}"
}

function prompt_func() {
    previous_return_value=$?;
    # prompt="${TITLEBAR}$BLUE[$RED\w$GREEN$(__git_ps1)$YELLOW$(git_dirty_flag)$BLUE]$COLOR_NONE "
    prompt="${TITLEBAR}${LIGHT_BLUE}[${LIGHT_RED}$(host_and_domain)${LIGHT_RED}:${WHITE}\w${GREEN}$(parse_git_branch)${LIGHT_BLUE}]${COLOR_NONE} "
    if test $previous_return_value -eq 0
    then
        PS1="${prompt}$ "
    else
        PS1="${prompt}${LIGHT_RED}$ ${COLOR_NONE}"
    fi
}

# This way you get the host/path in the title bar and the pretty PS1
PROMPT_COMMAND='prompt_func && echo -ne "\033]0;${USER}@$(host_and_domain_noformat): ${PWD/$HOME/~}\007"'

alias tmux='tmux -CC '

# Because British
alias whilst='while'
alias splendid='done'
alias smashing='done'
alias lovely='done'

function growl() { echo -e $'\e]9;'${1}'\007' ; return ; }

function fix-ssh() { 
    if [ -z $1 ]
    then
        echo "Removes the specified line number from your ~/.ssh/know_hosts file. "
        echo "Usage: fix-ssh <line number>"
    else
        sed -i -e "$1 d" ~/.ssh/known_hosts
        echo "Removed line $1"
    fi
}
function ilo() { ipmitool -I lanplus -U root -H $@ sol activate; }

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

