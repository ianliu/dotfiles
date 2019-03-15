#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

red='\[\e[31m\]'
reset='\[\e[0m\]'

if [ -z $TMUX ]; then
  PS1="$red[ssh]$reset \\W$ "
fi

export PATH="$HOME/.cargo/bin:$PATH"
