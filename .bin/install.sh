#!/usr/bin/env bash

echo '      _       _    __ _ _            '
echo '     | |     | |  / _(_) |           '
echo '   __| | ___ | |_| |_ _| | ___  ___  '
echo '  / _` |/ _ \| __|  _| | |/ _ \/ __| '
echo ' | (_| | (_) | |_| | | | |  __/\__ \ '
echo '  \__,_|\___/ \__|_| |_|_|\___||___/ '
echo '                                     '

# Color option {{{
Color_off='\033[0m'       # Text Reset

# terminal color template {{{
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
# }}}

config() {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

color() {
    ecode=$1
    text=$2

    printf "${ecode}${text}${Color_off}"
}

info() {
    text=$1
    echo $(color $Blue "[➭]") $text
}

success() {
    text=$1
    echo $(color $Green "[✔]") $text
}

error() {
    text=$1

    echo $(color $Red "[✘]") $text
}

warn() {
    text=$1

    echo $(color $Yellow "[⚠]") $text
}

info "Fetching dotfiles..."
git clone --bare git@github.com:link00000000/dotfiles.git $HOME/.cfg 2> /dev/null

if [ $? != 0 ]; then
    error "Unable to clone dotfiles to $HOME/.cfg. Does the directory already exist?"
    exit 1
fi

echo

config checkout > /dev/null 2>&1
if [ $? != 0 ]; then
    warn "Pre-existing dotfiles found!"
    info "Backing up pre-existing dotfiles..."

    for file in $(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'}); do
        mkdir --parents .config-backup/$(dirname $file)
        mv $file .config-backup/$file
    done

    success "Dotfiles backed up to $HOME/.config-backup"
    echo
fi

config checkout
config config status.showUntrackedFiles no

success "Done!"

