##########################################################
# config
##########################################################

# config files
$Global:Element.cg = "$HOME\.cargo\env"
$Global:Element.cg_ = "$HOME\.cargo"

##########################################################
# mirrors
##########################################################

function rsmr {
    param ( $mirror )
    $env:RUSTUP_DIST_SERVER = "https://$Global:Rust_Mirror.$mirror/rust-static"
    $env:RUSTUP_UPDATE_ROOT = "https://$Global:Rust_Mirror.$mirror/rust-static/rustup"
}

##########################################################
# packages
##########################################################

function cg { cargo }
function cgh { cargo help }
function cgis { cargo install $args }
function cgus { cargo uninstall $args }
function cgls { cargo --list }
function cgup { cargo update $args }
function cgcl { cargo clean }
function cgsc { cargo search $args }
function cgck { cargo check }
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
    if ([string]::IsNullOrEmpty($args)) { cargo new $args }
    else { cargo init $args }
}

##########################################################
# rustup
##########################################################

function rsh { rustup help }
function rsis { rustup component add $args }
function rsus { rustup component remove $args }
function rsls { rustup component list }
function rsup { rustup update }
function rsck { rustup check }
function rsr { rustup run }
