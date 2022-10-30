##########################################################
# config
##########################################################

up_bitwarden() {
    bw import $@
}

back_bitwarden() {
    bw export $@
}

alias bwcf="bw config"

##########################################################
# query
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

alias bwst="bw status --pretty"
alias bwh="bw --help"

##########################################################
# project management
##########################################################

alias bwpl="bw sync"

##########################################################
# item management
##########################################################

# $1=object
bwe() {
    case $2 in
    -d)
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
    -d)
        bw delete folder $1
        ;;
    *)
        bw delete item $1
        ;;
    esac
}

alias bwa="bw create"
alias bwls="bw list"
