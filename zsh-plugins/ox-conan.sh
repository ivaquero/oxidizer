##########################################################
# config
##########################################################

OX_ELEMENT[cn]=${HOME}/.conan/conan.conf
OX_ELEMENT[cnr]=${HOME}/.conan/remotes.json
OX_ELEMENT[cnd]=${HOME}/.conan/profiles/default

##########################################################
# packages
##########################################################

alias cnh="conan help"
alias cnis="conan install"
alias cnus="conan remove"

cnsc() {
    case $1 in
    -m) conan search --remote=conancenter $2 ;;
    *) conan search $1 ;;
    esac
}

cndl() {
    case $1 in
    -m) conan download --remote=conancenter $1 ;;
    *) conan download $2 ;;
    esac
}

alias cndp="conan info"
alias cncf="conan config"

##########################################################
# extension
##########################################################

alias cnxa="conan remote add"
alias cnxrm="conan remote remove"
alias cnxls="conan remote list"

##########################################################
# project
##########################################################

alias cnii="conan create"
alias cnb="conan build"
alias cnif="conan inspect"
alias cnpb="conan publish"
alias cnts="conan test"
alias cnpb="conan upload"

##########################################################
# cmake
##########################################################

alias cmh="cmake --help"
