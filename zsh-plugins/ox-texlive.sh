##########################################################
# config
##########################################################

if [ $(uname -s) = "Darwin" ]; then
    export texlive=/usr/local/texlive
fi

# bin
eval "$(/usr/libexec/path_helper)"

up_texlive() {
    echo "Update TeXLive by ${Oxide[bktl]}"
    local num=$(cat ${Oxide[bktl]} | wc -l | rg --only-matching "\d+")

    pueue group add texlive_update
    pueue parallel $num -g texlive_update

    cat ${Oxide[bktl]} | while read line; do
        echo "Installing $line"
        pueue add -g texlive_update "tlmgr install $line"
    done
    sleep 3 && pueue status
}

back_texlive() {
    echo "Backup TeXLive to ${Oxide[bktl]}"
    tlmgr list --only-installed | rg --only-matching "collection-\w+" | rg --invert-match "basic" >${Oxide[bktl]}
}

##########################################################
# packages
##########################################################

alias tlup="tlmgr update --all"
alias tlups="tlmgr update --all --self"
alias tlck="tlmgr check"
alias tlis="tlmgr install"
alias tlus="tlmgr remove && tlmgr check"
alias tllsa="tlmgr list"
alias tlls="tlmgr list --only-installed"
alias tlif="tlmgr info"
alias tlifc="tlmgr info collections"
alias tlifs="tlmgr info schemes"
alias tlh="tlmgr -h"
