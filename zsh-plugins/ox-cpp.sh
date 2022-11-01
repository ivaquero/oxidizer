##########################################################
# config
##########################################################

# config files
Element[cn]=$HOME/.conan/profiles/default
Element[cnr]=$HOME/.conan/remote.json

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
        conan search
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
