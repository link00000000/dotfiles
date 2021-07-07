#!/usr/bin/env bash

echo '      _       _    __ _ _            '
echo '     | |     | |  / _(_) |           '
echo '   __| | ___ | |_| |_ _| | ___  ___  '
echo '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
echo ' | (_| | (_) | |_| | | | |  __/\__ \ '
echo '  \__,_|\___/ \__|_| |_|_|\___||___/ '
echo '                                     '

config() {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

color() {
    ecode=$1
    text=$2

    printf "\033[${ecode}m${text}\033[0m"
}

red() {
    text=$1

    color '0;31' "$text"
}

cyan() {
    text=$1
    color '0;36' "$text"
}

light_green() {
    text=$1
    color '1;32' "$text"
}

echo $(cyan "Fetching dotfiles...")
git clone --bare --mirror https://github.com/link00000000/dotfiles.git $HOME/.cfg
echo

config checkout > /dev/null 2>&1
if [ $? != 0 ]; then
    echo $(red "Pre-existing dofiles found!")
    echo $(cyan "Backing up pre-existing dotfiles...")

    for file in $(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'}); do
        mkdir --parents .config-backup/$(dirname $file)
        mv $file .config-backup/$file
    done

    echo "Dotfiles backed up to $HOME/.config-backup"
    echo
fi

config checkout
config config status.showUntrackedFiles no

echo $(light_green "Done!")

