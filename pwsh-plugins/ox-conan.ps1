##########################################################
# config
##########################################################

$Global:OX_ELEMENT.cn = "$HOME\.conan\conan.conf"
$Global:OX_ELEMENT.cnr = "$HOME\.conan\remotes.json"
$Global:OX_ELEMENT.cnd = "$HOME\.conan\profiles\default"

##########################################################
# packages
##########################################################

function cnh { conan help $args }
function cnis { conan install $args }
function cnus { conan remove $args }
function cnsc {
    Switch ( $args[1] ) {
        --cc { conan search --remote=conancenter $args[2] }
        Default { conan search $args }
    }
}
function cndl {
    Switch ( $args[1] ) {
        --cc { conan download --remote=conancenter $args[2] }
        Default { conan download $args }
    }
}

function cndp { conan info }
function cncf { conan config }

##########################################################
# extension
##########################################################

function cnxa { conan remote add $args }
function cnxrm { conan remote remove $args }
function cnxls { conan remote list }

##########################################################
# project
##########################################################

function cnii { conan create $args }
function cnb { conan build $args }
function cnif { conan inspect $args }
function cnpb { conan publish $args }
function cnts { conan test $args }
function cnpb { conan upload $args }

##########################################################
# cmake
##########################################################

function cmh { cmake --help $args }
