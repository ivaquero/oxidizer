##########################################################
# config
##########################################################

$Global:OX_ELEMENT.cn = "$HOME\.conan\conan.conf"
$Global:OX_ELEMENT.cnr = "$HOME\.conan\remotes.json"

##########################################################
# packages
##########################################################

function cn { conan $args }
function cnh { conan help $args }
function cnis { conan install $args }
function cnus { conan remove $args }
function cnsc {
    Switch ( $pkg ) {
        -r { conan search -r=conancenter $pkg }
        Default { conan search $pkg }
    }
}
function cnsc {
    Switch ( $pkg ) {
        -r { conan remote list }
    }
}
function cnif { conan inspect $args }
function cndl { conan download $args }

# specific
function cncf { conan config }

##########################################################
# project
##########################################################

function cnii { conan create $args }
function cnb { conan build $args }
function cnts { conan test $args }
function cnpb { conan publish $args }
