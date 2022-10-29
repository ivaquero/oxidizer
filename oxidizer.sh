if [ -z $OXIDIZER ]; then
    export OXIDIZER=$HOME/oxidizer
fi

##########################################################
# Oxidizer configuration files
##########################################################

declare -A Oxygen
# defaults
Oxygen[oxd]=$OXIDIZER/defaults.sh
Oxygen[oxwz]=$OXIDIZER/defaults/wezterm.lua
# plugins
Oxygen[oxpm]=$OXIDIZER/zsh-plugins/ox-macos.sh
Oxygen[oxpa]=$OXIDIZER/zsh-plugins/ox-apt.sh
Oxygen[oxpb]=$OXIDIZER/zsh-plugins/ox-brew.sh
Oxygen[oxpf]=$OXIDIZER/zsh-plugins/ox-flatpak.sh
Oxygen[oxpg]=$OXIDIZER/zsh-plugins/ox-git.sh
Oxygen[oxpc]=$OXIDIZER/zsh-plugins/ox-conda.sh
Oxygen[oxpbw]=$OXIDIZER/zsh-plugins/ox-bitwarden.sh
Oxygen[oxpcc]=$OXIDIZER/zsh-plugins/ox-cpp.sh
Oxygen[oxpdk]=$OXIDIZER/zsh-plugins/ox-docker.sh
Oxygen[oxpes]=$OXIDIZER/zsh-plugins/ox-espanso.sh
Oxygen[oxpfm]=$OXIDIZER/zsh-plugins/ox-formats.sh
Oxygen[oxphx]=$OXIDIZER/zsh-plugins/ox-helix.sh
Oxygen[oxpjl]=$OXIDIZER/zsh-plugins/ox-julia.sh
Oxygen[oxpjn]=$OXIDIZER/zsh-plugins/ox-jupyter.sh
Oxygen[oxpnj]=$OXIDIZER/zsh-plugins/ox-node.sh
Oxygen[oxppd]=$OXIDIZER/zsh-plugins/ox-podman.sh
Oxygen[oxppu]=$OXIDIZER/zsh-plugins/ox-pueue.sh
Oxygen[oxprb]=$OXIDIZER/zsh-plugins/ox-ruby.sh
Oxygen[oxprs]=$OXIDIZER/zsh-plugins/ox-rust.sh
Oxygen[oxptl]=$OXIDIZER/zsh-plugins/ox-texlive.sh
Oxygen[oxput]=$OXIDIZER/zsh-plugins/ox-utils.sh
Oxygen[oxpvs]=$OXIDIZER/zsh-plugins/ox-vscode.sh
Oxygen[oxpwg]=$OXIDIZER/zsh-plugins/ox-widgets.sh
Oxygen[oxpzj]=$OXIDIZER/zsh-plugins/ox-zellij.sh

##########################################################
# System configuration files
##########################################################

declare -A Element

Element[ox]=$OXIDIZER/custom.sh
Element[wz]=$HOME/.config/wezterm/wezterm.lua
Element[zs]=$HOME/.zshrc
Element[bs]=$HOME/.bash_profile

declare -A Oxide

. ${Element[ox]}

if [ ! -d $BACKUP/shell ]; then
    mkdir -p $BACKUP/shell
fi

if [ ! -d $BACKUP/install ]; then
    mkdir -p $BACKUP/install
fi

if [ ! -d $BACKUP/apps ]; then
    mkdir -p $BACKUP/apps
fi

##########################################################
# Shell
##########################################################

export SHELLS=/private/etc/shells

add_shell() {
    echo $1 | sudo tee -a $SHELLS
}

alias shell="echo $SHELL"
alias shells="cat $SHELLS"

##########################################################
# Zsh & Plugins
##########################################################

declare -a PLUGINS

# import ox-utils
. ${Oxygen[oxput]}
# import ox-pueue
. ${Oxygen[oxppu]}

# import ox-brew
if [ $(uname -s) != "Linux" ] && [ $(uname -m) != "aarch64" ]; then
    . ${Oxygen[oxpb]}
fi

case $(uname -a) in
*Darwin*)
    . ${Oxygen[oxpm]}
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . ${Oxygen[oxpa]}
    ;;
esac

for plugin in ${PLUGINS[@]}; do
    . ${Oxygen[$plugin]}
done

##########################################################
# Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
init_all() {
    for obj in $INIT_OBJ[@]; do
        eval init_$obj
    done
}

# update all packages
up_all() {
    for obj in $UP_OBJ[@]; do
        eval up_$obj
    done
}

# backup package lists
back_all() {
    for obj in $BACK_OBJ[@]; do
        eval back_$obj
    done
}

# export configurations
epall() {
    for obj in $EPF_OBJ[@]; do
        epf $obj
    done
}

# import configurations
ipall() {
    for obj in $IPF_OBJ[@]; do
        ipf $obj
    done
}

# initialize Oxidizer
iiox() {
    for obj in $IIF_OBJ[@]; do
        iif $obj
    done
}

# update Oxidizer
upox() {
    z $OXIDIZER
    git fetch origin master
    git reset --hard origin/master
    z -
}

if [[ $STARTUP ]]; then
    case $SHELL in
    *zsh)
        eval "$(zoxide init zsh)"
        ;;
    *bash)
        eval "$(zoxide init bash)"
        ;;
    esac
    startup
fi
