#!/usr/bin/env bash

git clone --bare git@github.com:link00000000/dotfiles.git $HOME/.cfg

config() {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

config checkout
if [ $? != 0 ]; then
    echo "Backing up pre-existing dot files..."

    mkdir -p .config-backup
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}

    echo "Dotfiles backed up to $HOME/.config-backup/"
fi

config checkout
config config status.showUntrackedFiles no

