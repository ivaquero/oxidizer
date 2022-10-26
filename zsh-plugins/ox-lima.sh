##########################################################
# config
##########################################################

##########################################################
# management
##########################################################

# $1: name, $2: template
lms() {
    if [ -z $1 ]; then
        limactl start
    elif [[ ${#1} < 4 ]]; then
        limactl start ${Lima[$1]}
    elif [ -z $2]; then
        limactl start $1
    else
        limactl start --name=$1 $2
    fi
}

lmq() {
    if [[ ${#1} < 4 ]]; then
        limactl stop ${Lima[$1]}
    else
        limactl stop $1
    fi
}

alias lmls="limactl list"
alias lmlst="limactl start --list-templates"
alias lmrm="limactl delete"
alias lmcl="limactl prune"

##########################################################
# main
##########################################################

alias lm="limactl"
alias lmh="limactl -h"
alias lmif="limactl info"
alias lme="limactl edit"
alias lsrt="limactl factory-reset"

# specific
alias lmsh="limactl shell"
alias lmcp="limactl copy"
alias lmcpl="limactl completion"
