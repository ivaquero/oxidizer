##########################################################
# config
##########################################################

export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij

# use `_` as a suffix flag for directory
OX_ELEMENT[zj]=$ZELLIJ_CONFIG_DIR/config.kdl
OX_ELEMENT[zjl_]=$ZELLIJ_CONFIG_DIR/layouts

##########################################################
# main
##########################################################

alias zj="zellij"
alias zjh="zellij help"
alias zje="zellij edit"
alias zjck="zellij setup --check"

zjs() {
    case $1 in
    bs)
        zellij setup --generate-auto-start=bash >>~/.bash_profile
        ;;
    zs)
        zellij setup --generate-auto-start=zsh >>~/.zshrc
        ;;
    esac
}

zjcf() {
    case $1 in
    -p)
        zellij setup --dump-config
        ;;
    -l)
        zellij setup --dump-layout $2
        ;;
    *)
        zellij setup --dump-config >~/.config/zellij/config.kdl
        ;;
    esac
}

##########################################################
# sessions
##########################################################

alias zjls="zellij list-sessions"

zjat() {
    if [ -z $1 ]; then
        zellij attach --index 0
    elif [[ ${#1} < 3 ]]; then
        zellij attach --index $1
    else
        zellij attach
    fi
}

zjq() {
    if [ -z $1 ]; then
        zellij kill-all-sessions --yes
    else
        zellij kill-session $1
    fi
}

alias zjr="zellij run"
