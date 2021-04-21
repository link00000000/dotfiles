#!/usr/bin/env bash

echo '      _       _    __ _ _            '
echo '     | |     | |  / _(_) |           '
echo '   __| | ___ | |_| |_ _| | ___  ___  '
echo '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
echo ' | (_| | (_) | |_| | | | |  __/\__ \ '
echo '  \__,_|\___/ \__|_| |_|_|\___||___/ '
echo '                                     '

git clone --bare git@github.com:link00000000/dotfiles.git $HOME/.cfg

config() {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

config checkout > /dev/null 2>&1
if [ $? != 0 ]; then
    echo "Backing up pre-existing dot files..."

    for file in $(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'}); do
        mkdir --parents .config-backup/$(dirname $file)
        mv $file .config-backup/$file
    done

    echo "Dotfiles backed up to $HOME/.config-backup"
fi

config checkout
config config status.showUntrackedFiles no

