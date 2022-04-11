##########################################################
# config
##########################################################

# oxidizer files
Oxygen[oxpu]=$OXIDIZER/defaults/pueue.yml
Oxygen[oxpua]=$OXIDIZER/defaults/pueue_aliases.yml

# config files
if [[ $MACOS ]]; then
    Element[pu]=$HOME/Library/Preferences/pueue/pueue.yml
    Element[pual]=$HOME/Library/Preferences/pueue/pueue_aliases.yml
fi

# backup files
Oxide[bkpu]=$BACKUP/pueue/pueue.yml
Oxide[bkpua]=$BACKUP/pueue/pueue_aliases.yml

##########################################################
# main
##########################################################

alias pu="pueue"
alias puh="pueue help"
alias pua="pueue add"
alias purm="pueue remove"
alias pus="pueue start"
alias purs="pueue restart"
alias pupa="pueue pause"
alias pucl="pueue clean && pueue status"
alias pust="pueue status"
alias pue="pueue edit"
alias puq="pueue kill"
alias purt="pueue reset"
