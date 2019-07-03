#!/bin/bash

GIT_DIR=${GIT_DIR:-$HOME/.dotfiles.git}

if [ -d ~/.dotfiles.git ]; then
	echo "~/.dotfiles.git already exists."
	git --work-tree="$HOME" status -bs
	exit 1
fi

branches=( $(curl -s https://api.github.com/repos/ianliu/dotfiles/branches \
	| grep '"name"' \
	| sed 's/^[^:]*:\s*"\([^"]*\)".*$/\1/' \
	| grep -v master) )

i=1
for branch in "${branches[@]}"; do
	echo "$((i++)): $branch"
done

echo -en "\nChoose a branch: "
read choice < /dev/tty

branch=${branches[$((choice - 1))]}

git clone -b "$branch" --bare git@github.com:ianliu/dotfiles ~/.dotfiles.git
git --git-dir="$GIT_DIR" --work-tree="$HOME" config status.showUntrackedFiles no

cat <<EOF

   Your dotfiles are now tracked with Git. The bare repository is
   located at ~/.dotfiles.git, and you can issue git commands like so:

       alias dotf='git --git-dir="$GIT_DIR" --work-tree="\$HOME"'
       dotf status
       dotf add .vimrc
       dotf commit -m 'Add an awesome vim config!'

EOF
