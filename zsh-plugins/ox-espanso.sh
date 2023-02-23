##########################################################
# config
##########################################################

OX_ELEMENT[es]=${OX_APPDATA}/espanso/config/default.yml
OX_ELEMENT[esx]=${OX_APPDATA}/espanso/match/base.yml
OX_ELEMENT[esx_]=${OX_APPDATA}/espanso/match/packages

##########################################################
# packages
##########################################################

alias esis="espanso package install"
alias esus="espanso package uninstall"
alias esls="espanso package list"

esup() {
    if [[ -z $1 ]]; then
        local pkgs=$(espanso package list | rg --only-matching "\w+.*\w\s-" | rg --only-matching "\w+.*\w")
        echo $pkgs | while read line; do
            espanso package update $line
        done
    else
        espanso package update $1
    fi
}

##########################################################
# management
##########################################################

alias ess="espanso start"
alias esrs="espanso restart"
alias esst="espanso status"
alias esq="espanso stop"

##########################################################
# main
##########################################################

esa() {
    touch ${OX_APPDATA}/espanso/match/$1.yml
}

alias esh="espanso help"
alias esed="espanso edit"
