##########################################################
# config
##########################################################

OX_ELEMENT[cn]=$HOME/.conan/conan.conf
OX_ELEMENT[cnr]=$HOME/.conan/remotes.json

##########################################################
# packages
##########################################################

alias cnh="conan help"
alias cnis="conan install"
alias cnus="conan remove"

cnsc() {
    case $1 in
    -r)
        conan search -r=conancenter $1
        ;;
    *)
        conan search $1
        ;;
    esac
}

cnls() {
    case $1 in
    -r)
        conan remote list
        ;;
    esac
}

alias cnif="conan inspect"
alias cndl="conan download"

# specific
alias cncf="conan config"

##########################################################
# project
##########################################################

alias cnii="conan create"
alias cnb="conan build"
alias cnts="conan test"
alias cnpb="conan publish"
