##########################################################
# config
##########################################################

# config files
$Global:Element.cn = "$env:BASE\.conan\profiles\default"
$Global:Element.cnr = "$env:BASE\.conan\remote.json"
# backup files
$Global:Oxide.bkcn = "$env:backup\conan\default"
$Global:Oxide.bkcnr = "$env:backup\conan\remote.json"

##########################################################
# packages
##########################################################

function cn { conan $args }
function cnh { conan help }
function cnis { conan install $args }
function cnus { conan remove $args }
function cnsc { conan search $args }
function cnscr { conan search -r=conancenter $args }
function cnif { conan inspect $args }
function cndl { conan download $args }
# specific
function cncf { conan config }
function cnrmls { conan remote list }

##########################################################
# project
##########################################################

function cnii { conan create $args }
function cnb { conan build $args }
function cnts { conan test $args }
function cnpb { conan publish $args }
