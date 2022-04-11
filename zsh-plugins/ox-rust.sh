##########################################################
# config
##########################################################

# config files
Element[cg]=$HOME/.cargo/env
Element[cg_]=$HOME/.cargo

# backup files
Oxide[bkcg]=$BACKUP/rust/env.sh
Oxide[bkcg_]=$BACKUP/rust

if [[ ! -d $BACKUP/rust ]]; then
    mkdir -p $BACKUP/rust
fi

##########################################################
# mirrors
##########################################################

rsmr() {
    export RUSTUP_DIST_SERVER=https://$Rust_Mirror[$1]/rust-static
    export RUSTUP_UPDATE_ROOT=https://$Rust_Mirror[$1]/rust-static/rustup
}

##########################################################
# packages
##########################################################

alias cgh="cargo help"
alias cgis="cargo install"
alias cgus="cargo uninstall"
alias cgup="cargo update"
alias cgcl="cargo clean"
alias cgsc="cargo search"
alias cgck="cargo check"

##########################################################
# project
##########################################################

alias cgb="cargo build"
alias cgr="cargo run"
alias cgts="cargo test"
alias cgpb="cargo publish"

cgii() {
    if [[ ! -d $1 ]]; then
        cargo new
    else
        cargo init
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
