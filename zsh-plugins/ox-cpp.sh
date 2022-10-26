##########################################################
# config
##########################################################

# config files
Element[cn]=$HOME/.conan/profiles/default
Element[cnr]=$HOME/.conan/remote.json
# backup files
Oxide[bkcn]=$BACKUP/conan/default
Oxide[bkcnr]=$BACKUP/conan/remote.json

##########################################################
# packages
##########################################################

alias cnh="conan help"
alias cnis="conan install"
alias cnus="conan remove"
alias cnsc="conan search"
alias cnscr="conan search -r=conancenter"
alias cnif="conan inspect"
alias cndl="conan download"
# specific
alias cncf="conan config"
alias cnrmls="conan remote list"

##########################################################
# project
##########################################################

alias cnii="conan create"
alias cnb="conan build"
alias cnts="conan test"
alias cnpb="conan publish"
