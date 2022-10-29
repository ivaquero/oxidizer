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
function cnsc {
    switch ( $pkg ) {
        -r { conan search -r=conancenter $pkg }
        Default { conan search $pkg }
    }
}
function cnsc {
    switch ( $pkg ) {
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
