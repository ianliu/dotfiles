[[ $- != *i* ]] && return

so() {
  [ -f "$1" ] && source "$1"
}

export EDITOR=vim
export PATH="$HOME/bin:$PATH"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose
export GIT_PS1_SHOWCOLORHINTS=1

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE='clear'

shopt -s histappend checkwinsize extglob autocd

[ -x /usr/bin/lesspipe.sh ] \
  && eval "$(SHELL=/bin/sh /usr/bin/lesspipe.sh)"

so /usr/share/git/completion/git-prompt.sh
so /usr/share/bash-completion/bash_completion
so ~/.asdf/asdf.sh
so ~/.asdf/completions/asdf.bash

myprompt() {
  __git_ps1 '\W' '$ '
  if [ -n "$SSH_SESSION" ]; then
    PS1="\[\e[31m\][ssh]\[\e[0m\] $PS1"
  fi
}

alias open='xdg-open'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if [ -z "$VIMRUNTIME" ]; then
  alias vim='vim --servername VIM'
else
  alias vim="vim --servername $VIM_SERVERNAME --remote"
fi

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  PROMPT_COMMAND=myprompt
else
  PS1='\W$ '
fi


# vim:sw=2:et:sta
