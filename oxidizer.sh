# set default value for OXIDIZER
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

##########################################################
# Oxidizer configuration files
##########################################################

# plugins
declare -A OX_OXYGEN=(
    [oxd]=${OXIDIZER}/defaults.sh
    [oxwz]=${OXIDIZER}/defaults/wezterm.lua
    [oxpm]=${OXIDIZER}/oxplugins-zsh/ox-macos.sh
    [oxpd]=${OXIDIZER}/oxplugins-zsh/ox-debians.sh
    [oxpb]=${OXIDIZER}/oxplugins-zsh/ox-brew.sh
    [oxpg]=${OXIDIZER}/oxplugins-zsh/ox-git.sh
    [oxpc]=${OXIDIZER}/oxplugins-zsh/ox-conda.sh
    [oxpbw]=${OXIDIZER}/oxplugins-zsh/ox-bitwarden.sh
    [oxpcn]=${OXIDIZER}/oxplugins-zsh/ox-conan.sh
    [oxpct]=${OXIDIZER}/oxplugins-zsh/ox-container.sh
    [oxpes]=${OXIDIZER}/oxplugins-zsh/ox-espanso.sh
    [oxpfm]=${OXIDIZER}/oxplugins-zsh/ox-formats.sh
    [oxphx]=${OXIDIZER}/oxplugins-zsh/ox-helix.sh
    [oxpjl]=${OXIDIZER}/oxplugins-zsh/ox-julia.sh
    [oxpjn]=${OXIDIZER}/oxplugins-zsh/ox-jupyter.sh
    [oxpnj]=${OXIDIZER}/oxplugins-zsh/ox-node.sh
    [oxppd]=${OXIDIZER}/oxplugins-zsh/ox-podman.sh
    [oxppu]=${OXIDIZER}/oxplugins-zsh/ox-pueue.sh
    [oxprs]=${OXIDIZER}/oxplugins-zsh/ox-rust.sh
    [oxptl]=${OXIDIZER}/oxplugins-zsh/ox-texlive.sh
    [oxput]=${OXIDIZER}/oxplugins-zsh/ox-utils.sh
    [oxpvs]=${OXIDIZER}/oxplugins-zsh/ox-vscode.sh
    [oxpzj]=${OXIDIZER}/oxplugins-zsh/ox-zellij.sh
)

##########################################################
# System configuration files
##########################################################

declare -A OX_ELEMENT=(
    [ox]=${OXIDIZER}/custom.sh
    [wz]=${HOME}/.config/wezterm/wezterm.lua
    [zs]=${HOME}/.zshrc
    [bs]=${HOME}/.bash_profile
    [fs]=${HOME}/.config/fish/config.fish
    [vi]=${HOME}/.vimrc
)

declare -A OX_OXIDE

##########################################################
# Shell
##########################################################

SHELLS=/private/etc/shells

add_shell() {
    echo $1 | sudo tee -a ${SHELLS}
}

alias shell="echo ${SHELL}"
alias shells="cat ${SHELLS}"

##########################################################
# Zsh & Plugins
##########################################################

# load system plugin
case $(uname -a) in
*Darwin*)
    . ${OX_OXYGEN[oxpm]}
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . ${OX_OXYGEN[oxpd]}
    ;;
esac

# load custom plugins
declare -a OX_PLUGINS

. ${OX_ELEMENT[ox]}

for plugin in ${OX_PLUGINS[@]}; do
    . ${OX_OXYGEN[$plugin]}
done

# shell backup
if [ ! -d ${OX_BACKUP}/shell ]; then
    mkdir -p ${OX_BACKUP}/shell
fi

OX_OXIDE[bkzs]=${OX_BACKUP}/shell/.zshrc
OX_OXIDE[bkbs]=${OX_BACKUP}/shell/.bash_profile
OX_OXIDE[bkvi]=${OX_BACKUP}/shell/.vimrc

declare -a OX_CORE_PLUGINS
OX_CORE_PLUGINS=(oxpb oxput oxppu)

# load core plugins
for core_plugin in ${OX_CORE_PLUGINS[@]}; do
    . ${OX_OXYGEN[$core_plugin]}
done

##########################################################
# Oxidizer management
##########################################################

# update all packages
up_all() {
    for obj in ${OX_UPDATE_PROG[@]}; do
        eval up_$obj
    done
}

# backup package lists
back_all() {
    for obj in ${OX_BACKUP_PROG[@]}; do
        eval back_$obj
    done
}

# export configurations
epall() {
    for obj in ${OX_EXPORT_FILE[@]}; do
        epf $obj
    done
}

# import configurations
ipall() {
    for obj in ${OX_IMPORT_FILE[@]}; do
        ipf $obj
    done
}

iiox() {
    for pkg in $(cat ${OXIDIZER}/defaults/Brewfile.txt); do
        case $pkg in
        ripgrep)
            cmd='rg'
            ;;
        bottom)
            cmd='btm'
            ;;
        tealdear)
            cmd='tldr'
            ;;
        zoxide)
            cmd='z'
            ;;
        *)
            cmd=$pkg
            ;;
        esac
        if test ! "$(command -v $cmd)"; then
            brew install $pkg
        fi
    done
}

# update Oxidizer
upox() {
    cd ${OXIDIZER}
    git fetch origin master
    git reset --hard origin/master

    if [ ! -d ${OXIDIZER}/oxplugins-zsh ]; then
        git clone --depth=1 https://github.com/ivaquero/oxplugins-zsh.git
    else
        cd ${OXIDIZER}/oxplugins-zsh
        git fetch origin main
        git reset --hard origin/main
    fi
    cd ${HOME}
}

##########################################################
# Starship
##########################################################

if test "$(command -v starship)"; then
    # config files
    export STARSHIP_CONFIG=${HOME}/.config/starship.toml
    OX_ELEMENT[ss]=${STARSHIP_CONFIG}
    # backup files
    OX_OXIDE[ss]=${OX_BACKUP}/shell/starship.toml

    case ${SHELL} in
    *zsh)
        eval "$(starship init zsh)"
        ;;
    *bash)
        eval "$(starship init bash)"
        ;;
    *fish)
        eval "$(starship init fish)"
        ;;
    esac
fi

if [[ ${OX_STARTUP} ]]; then
    startup
fi
