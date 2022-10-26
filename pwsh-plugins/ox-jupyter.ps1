##########################################################
# main
##########################################################

function jn { jupyter notebook }
function jn { jupyter lab }

##########################################################
# kernelspec
##########################################################

function jnk { jupyter kernelspec $args }
function jnkls { jupyter kernelspec list }
function jnkus { jupyter kernelspec remove $args }

##########################################################
# book
##########################################################

function jb { jupyter-book $args }
function jbcr { jupyter-book create $args }
function jbcl { jupyter-book clean $args }
function jbb { jupyter-book build $args }
function ghp { ghp-import -n -p -f $args\_build\html }
