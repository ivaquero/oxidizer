##########################################################
# main
##########################################################

alias jn="jupyter notebook"
alias jnl="jupyter lab"

##########################################################
# kernelspec
##########################################################

alias jnk="jupyter kernelspec"
alias jnkls="jupyter kernelspec list"
alias jnkus="jupyter kernelspec remove"

##########################################################
# book
##########################################################

alias jb="jupyter-book"
alias jbcr="jupyter-book create"
alias jbcl="jupyter-book clean"
alias jbb="jupyter-book build"

ghp() {
    ghp-import -n -p -f $1/_build/html
}
