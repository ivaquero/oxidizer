##########################################################
# main
##########################################################

# $1=object
bwsc() {
    case $2 in
    -h)
        bw get --help
        ;;
    -u)
        bw get username $1
        ;;
    -p)
        bw get password $1
        ;;
    -n)
        bw get notes $1
        ;;
    *)
        bw get item $1 --pretty
        ;;
    esac
}

# $1=object
bwe() {
    case $2 in
    -f)
        bw edit folder $1
        ;;
    *)
        bw edit item $1
        ;;
    esac
}

# $1=object
bwrm() {
    case $2 in
    -f)
        bw delete folder $1
        ;;
    *)
        bw delete item $1
        ;;
    esac
}

alias bwh="bw --help"
alias bwst="bw status --pretty"
alias bwsy="bw sync"
