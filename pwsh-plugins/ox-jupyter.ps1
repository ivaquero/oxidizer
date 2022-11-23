##########################################################
# config
##########################################################

$Global:OX_ELEMENT.jn = "$HOME/.jupyter/jupyter_notebook_config.py"

##########################################################
# main
##########################################################

function jnh { jupyter --help }
function jn { jupyter notebook $args }
function jncf { jupyter notebook --generate-config }
function jnl { jupyter lab $args }

##########################################################
# kernelspec
##########################################################

function jnk { jupyter kernelspec $args }
function jnkls { jupyter kernelspec list }
function jnkis { jupyter kernelspec install $args }
function jnkus { jupyter kernelspec remove $args }

##########################################################
# book
##########################################################

function jb { jupyter-book $args }
function jbcr { jupyter-book create $args }
function jbcl { jupyter-book clean $args }
function jbb { jupyter-book build $args }
function ghp { ghp-import -n -p -f $args\_build\html }
