##########################################################
# config
##########################################################

OX_ELEMENT[jn]="${HOME}/.jupyter/jupyter_notebook_config.py"

##########################################################
# main
##########################################################

alias jnh="jupyter --help"
alias jn="jupyter notebook"
alias jncf="jupyter notebook --generate-config"
alias jnl="jupyter lab"

if [[ $(uname) = "Darwin" ]]; then
    jncl() {
        echo "Cleaning up Jupyter Runtime Cache.\n"
        rm -rfv ${HOME}/Library/Jupyter/runtime/*.json
    }
fi

##########################################################
# kernelspec
##########################################################

alias jnk="jupyter kernelspec"
alias jnkls="jupyter kernelspec list"
alias jnkis="jupyter kernelspec install"
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
