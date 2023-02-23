##########################################################
# config
##########################################################

if [[ $(uname) = "Darwin" ]]; then
    export texlive=/usr/local/texlive
fi

# bin
eval "$(/usr/libexec/path_helper)"

up_texlive() {
    echo "Update TeXLive by ${OX_OXIDE[bktl]}"
    local num=$(cat ${OX_OXIDE[bktl]} | wc -l | rg --only-matching "\d+")

    pueue group add texlive_update
    pueue parallel $num -g texlive_update

    cat ${OX_OXIDE[bktl]} | while read line; do
        echo "Installing $line"
        pueue add -g texlive_update "tlmgr install $line"
    done
    sleep 3 && pueue status
}

back_texlive() {
    echo "Backup TeXLive to ${OX_OXIDE[bktl]}"
    tlmgr list --only-installed | rg --only-matching "collection-\w+" | rg --invert-match "basic" >${OX_OXIDE[bktl]}
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
