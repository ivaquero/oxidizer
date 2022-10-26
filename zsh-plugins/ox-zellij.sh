##########################################################
# config
##########################################################

# oxidizer files
Oxygen[oxzj]=$OXIDIZER/defaults/zellij.yml

# config files
# use `_` as a suffix flag for directory
Element[zj]=$ZELLIJ_CONFIG_DIR/config.yaml
Element[zjl_]=$ZELLIJ_CONFIG_DIR/layouts

# backup files
Oxide[bkzj]=$BACKUP/zellij/config.yaml
Oxide[bkzjl_]=$BACKUP/zellij/layouts

if [ ! -d $BACKUP/zellij ]; then
    mkdir -p $BACKUP/zellij
fi

##########################################################
# main
##########################################################

alias zj="zellij"
alias zjh="zellij help"
alias zjls="zellij list-sessions"
alias zjck="zellij setup --check"

zja() {
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
