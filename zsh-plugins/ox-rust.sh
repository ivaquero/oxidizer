##########################################################
# config
##########################################################

# config files
Element[cg]=$HOME/.cargo/env
Element[cg_]=$HOME/.cargo

##########################################################
# mirrors
##########################################################

rsmr() {
    export RUSTUP_DIST_SERVER=https://${Rust_Mirror[$1]}/rust-static
    export RUSTUP_UPDATE_ROOT=https://${Rust_Mirror[$1]}/rust-static/rustup
}

##########################################################
# packages
##########################################################

alias cgh="cargo help"
alias cgls="cargo --list"
alias cgis="cargo install"
alias cgus="cargo uninstall"
alias cgup="cargo update"
alias cgcl="cargo clean"
alias cgsc="cargo search"
alias cgck="cargo check"
alias cgdp="cargo tree"
alias cgcf="cargo config"

cgif() {
    if [ -z $1 ]; then
        cargo info
    else
        cargo $1 info
    fi
}

##########################################################
# project
##########################################################

alias cgb="cargo build"
alias cgr="cargo run"
alias cgts="cargo test"
alias cgfx="cargo fix"
alias cgpb="cargo publish"

cgii() {
    if [ -z $1 ]; then
        cargo init
    else
        cargo new $@
    fi
}

##########################################################
# rustup
##########################################################

alias rsh="rustup help"
alias rsis="rustup component add"
alias rsus="rustup component remove"
alias rsls="rustup component list"
alias rsup="rustup update"
alias rsck="rustup check"
alias rsr="rustup run"
