##########################################################
# config
##########################################################

# binaries
export OPEN=open

if [[ $(uname -m) = "arm64" ]]; then
    export TERMINFO=/usr/share/terminfo
else
    export TERMINFO=/usr/local/share/terminfo
fi

##########################################################
# main
##########################################################

export MACOS_CACHES=${HOME}/Library/Caches

update() {
    echo "Installing needed updates.\n"
    softwareupdate -i -a >/dev/null 2>&1
}

clean() {
    case $1 in
    vs)
        echo "Cleaning up VSCode Cache.\n"
        rm -rfv ${HOME}/Library/'Application Support'/Code/Cache/*
        ;;
    chr)
        echo "Cleaning up Chrome Cache.\n"
        rm -rfv ${MACOS_CACHES}/Google/Chrome/*
        ;;
    zs)
        echo "Cleaning up ZSH history.\n"
        rm -rfv ${HOME}/.zsh_sessions/*
        rm -fv ${HOME}/.zsh_history
        ;;
    cont)
        echo "Cleaning Container Caches"
        for ct in $(ls ~/Library/Containers/); do
            rm -rfv ~/Library/Containers/$ct/Data/Library/Caches/*
        done
        ;;
    vol)
        echo "Emptying trash in Volumes.\n"
        sudo rm -rfv /Volumes/*/.Trashes
        ;;
    log)
        echo "Emptying the system log files.\n"
        sudo log erase
        ;;
    *)
        echo "Emptying trash.\n"
        rm -rfv ${HOME}/.Trash/*
        ;;
    esac
}

allow() {
    sudo spctl --master-disable
    echo "Initial letter needs to be capitalized"

    for app in /Applications/$1*.app; do
        if [[ -z $app ]]; then
            echo "$app not found."
        else
            echo "Cracking $app"
            xattr -r -d com.apple.quarantine $app
        fi
    done
}

hide() {
    chflags hidden $1
}

##########################################################
# computer
##########################################################

shutdown() {
    if [[ -z $1 ]]; then
        echo "Shutting down.\n"
        sudo shutdown -h now
    else
        echo "Shutting down in $1 seconds.\n"
        sudo shutdown -h $1
    fi
}

restart() {
    if [[ -z $1 ]]; then
        echo "Restarting $1.\n"
        sudo shutdown -r now
    else
        echo "Restarting in $1 seconds.\n"
        sudo shutdown -r "+$1"
    fi
}

hibernate() {
    echo "Hibernating.\n"
    shutdown -s now
}

sysinfo() {
    sysctl -a | rg $1
}

##########################################################
# files
##########################################################

alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"

##########################################################
# network
##########################################################

alias netq="networkQuality"

##########################################################
# time machine
##########################################################

alias tmh="tmutil -h"
alias tms="tmutil startbackup"
alias tmq="tmutil stopbackup"
alias tmls="tmutil listbackups"
alias tmrm="tmutil delete"

##########################################################
# mas - app store
##########################################################

if test "$(command -v mas)"; then
    alias mis="mas install"
    alias mus="sudo mas uninstall"
    alias mup="mas upgrade"
    alias mh="mas help"
    alias mif="mas info"
    alias mls="mas list"
    alias mst="mas outdated"
    alias msc="mas search"
    alias msi="mas signin"
    alias mso="mas signout"
fi
