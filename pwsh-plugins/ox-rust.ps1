##########################################################
# config
##########################################################

$Global:OX_ELEMENT.cg = "$HOME\.cargo\config.toml"
$Global:OX_ELEMENT.rs = "$HOME\.rustup\settings.toml"

##########################################################
# packages
##########################################################

function cgh { cargo help $args }
function cgis { cargo install $args }
function cgus { cargo uninstall $args }
function cgls { cargo --list }
function cgup { cargo update $args }
function cgcl { cargo clean }
function cgsc { cargo search $args }
function cgck { cargo check }
function cgdp { cargo tree $args }
function cgcf { cargo config $args }

function cgif {
    param ( $pkg )
    if ([string]::IsNullOrEmpty( $pkg )) {
        cargo info
    }
    else
    { cargo $pkg info }
}

##########################################################
# project
##########################################################

function cgb { cargo build $args }
function cgr { cargo run $args }
function cgts { cargo test $args }
function cgfx { cargo fix $args }
function cgpb { cargo publish $args }

function cgii {
    if ([string]::IsNullOrEmpty($args)) { cargo init $args }
    else { cargo new $args }
}

##########################################################
# rustup
##########################################################

function rsh { rustup help $args }
function rsis { rustup component add $args }
function rsus { rustup component remove $args }
function rsls { rustup component list }
function rsup { rustup update }
function rsck { rustup check }
function rsr { rustup run }
