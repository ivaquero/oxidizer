##########################################################
# config
##########################################################

# oxidizer files
Oxygen[oxesx]=$OXIDIZER/defaults/espanso-pkgs.txt
# config files
Element[es]=$APPDATA/espanso/config/default.yml
Element[esm]=$APPDATA/espanso/match/base.yml
# backup files
Oxide[bkes]=$BACKUP/espanso/config/default.yml
Oxide[bkesm]=$BACKUP/espanso/match/base.yml
Oxide[bkesx]=$BACKUP/install/espanso-pkgs.txt

init_espanso() {
    echo "Initialize Espanso by Oxidizer configuration"
    local pkgs=$(espanso package list)
    cat ${Oxygen[oxesx]} | sd " " "" | while read line; do
        if echo $exts | rg $line; then
            echo "Package $line is already installed."
        else
            echo "Installing $line"
            espanso package install $line
        fi
    done
}

up_espanso() {
    echo "Update Espanso by ${Oxide[bkesx]}"
    local pkgs=$(espanso package list)
    cat ${Oxide[bkesx]} | sd " " "" | while read line; do
        if echo $exts | rg $line; then
            echo "Package $line is already installed."
        else
            echo "Installing $line"
            espanso package install $line
        fi
    done
}

back_espanso() {
    echo "Backup Espanso to ${Oxide[bkesx]}"
    espanso package list | rg --only-matching "\w+.*\w\s-" | rg --only-matching "\w+.*\w" >${Oxide[bkesx]}
}

##########################################################
# packages
##########################################################

alias esis="espanso package install"
alias esus="espanso package uninstall"
alias esls="espanso package list"

esup() {
    if [ -z $1 ]; then
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
    touch $APPDATA/espanso/$1.yml
}

alias es="espanso"
alias esh="espanso help"
alias ese="espanso edit"
