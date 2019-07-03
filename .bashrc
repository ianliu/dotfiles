[[ $- != *i* ]] && return

export EDITOR=vim
export PATH=$PATH:/var/lib/flatpak/exports/bin/
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

alias ls='ls --color=auto'
alias vim=nvim
alias vi=nvim

PS1='\W$ '

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

alias dotf='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
