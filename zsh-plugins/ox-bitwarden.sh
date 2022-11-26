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
    if [[ -z $1 ]]; then
        bw get item $1 --pretty
    else
        case $1 in
        -h)
            bw get --help
            ;;
        -u)
            bw get username $2
            ;;
        -p)
            bw get password $2
            ;;
        -n)
            bw get notes $2
            ;;
        esac
    fi
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
    if [[ -z $1 ]]; then
        bw edit item $1
    else
        bw edit folder $1
    fi
}

# $1=object
bwrm() {
    if [[ -z $1 ]]; then
        bw delete item $1
    else
        bw delete folder $1
    fi
}

alias bwa="bw create"
alias bwls="bw list"
