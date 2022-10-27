##########################################################
# config
##########################################################

back_lima() {
    if [[ ${#1} < 4 ]]; then
        cp ${Lima[$1]}
    else
    fi
}

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

lmr() {
    lima nerdctl run -d --name nginx -p 8080:80 nginx:$1
}

alias lmls="limactl list"
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
alias lmcp="limactl copy"
alias lmsh="limactl shell"
