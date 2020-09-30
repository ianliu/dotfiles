[[ $- != *i* ]] && return

so() {
  if [ -f "$1" ]; then
    source "$1"
  else
    echo >&2 "warning: couldn't source $1, no such file or directory"
  fi
}

export EDITOR=vim
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose
export GIT_PS1_SHOWCOLORHINTS=1
export IMAGIC_ROOT=$HOME/src/Imagic
export DENO_INSTALL="/home/ian/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE='clear'

shopt -s histappend checkwinsize extglob autocd

[ -x /usr/bin/lesspipe.sh ] \
  && eval "$(SHELL=/bin/sh /usr/bin/lesspipe.sh)"

so /usr/share/fzf/key-bindings.bash
so /usr/share/fzf/completion.bash
so /usr/share/git/completion/git-prompt.sh
so /usr/share/bash-completion/bash_completion
so /usr/share/git/completion/git-completion.bash

command -v pyenv &>/dev/null && eval "$(pyenv init -)"

myprompt() {
  if [ -n "$SSH_CLIENT" ]; then
    __git_ps1 "[\\u@\[\e[32m\e[1m\]\\h\[\e[0m\]:\\W]" "\$ "
  else
    __git_ps1 "\\W" "\$ "
  fi
}

alias open='xdg-open'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias tree='tree -C'
alias xclip='xclip -sel clip'

hide_cmds=(feh mpv zathura)
for cmd in ${hide_cmds[@]}; do
	eval "alias $cmd='hide $cmd'"
done

__git_complete config __git_main

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

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# vim:sw=2:et:sta
