##########################################################
# config
##########################################################

if [[ $(uname -s) = "Darwin" ]]; then
    OX_ELEMENT[pu]=$HOME/Library/Preferences/pueue/pueue.yml
    OX_ELEMENT[pua]=$HOME/Library/Preferences/pueue/pueue_aliases.yml
else
    OX_ELEMENT[pu]=$HOME/.config/pueue/pueue.yml
    OX_ELEMENT[pua]=$HOME/.config/pueue/pueue_aliases.yml
fi

##########################################################
# management
##########################################################

alias pus="pueue start"
alias purs="pueue restart"
alias pua="pueue add"
alias purm="pueue remove"
alias pupa="pueue pause"
alias pucl="pueue clean && pueue status"
alias pust="pueue status"
alias puq="pueue kill"

##########################################################
# main
##########################################################

alias puh="pueue help"
alias pued="pueue edit"
alias purt="pueue reset"
