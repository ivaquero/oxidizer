# set default value for OXIDIZER
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

##########################################################
# Oxidizer configuration files
##########################################################

# plugins
declare -A OX_OXYGEN=(
    [oxd]=${OXIDIZER}/defaults.sh
    [oxwz]=${OXIDIZER}/defaults/wezterm.lua
    [oxpm]=${OXIDIZER}/plugins/ox-macos.sh
    [oxpd]=${OXIDIZER}/plugins/ox-debians.sh
    [oxpb]=${OXIDIZER}/plugins/ox-brew.sh
    [oxpg]=${OXIDIZER}/plugins/ox-git.sh
    [oxpc]=${OXIDIZER}/plugins/ox-conda.sh
    [oxpbw]=${OXIDIZER}/plugins/ox-bitwarden.sh
    [oxpcn]=${OXIDIZER}/plugins/ox-conan.sh
    [oxpct]=${OXIDIZER}/plugins/ox-container.sh
    [oxpes]=${OXIDIZER}/plugins/ox-espanso.sh
    [oxpfm]=${OXIDIZER}/plugins/ox-formats.sh
    [oxphx]=${OXIDIZER}/plugins/ox-helix.sh
    [oxpjl]=${OXIDIZER}/plugins/ox-julia.sh
    [oxpjn]=${OXIDIZER}/plugins/ox-jupyter.sh
    [oxpnj]=${OXIDIZER}/plugins/ox-node.sh
    [oxppd]=${OXIDIZER}/plugins/ox-podman.sh
    [oxppu]=${OXIDIZER}/plugins/ox-pueue.sh
    [oxprs]=${OXIDIZER}/plugins/ox-rust.sh
    [oxpss]=${OXIDIZER}/plugins/ox-starship.sh
    [oxptl]=${OXIDIZER}/plugins/ox-texlive.sh
    [oxput]=${OXIDIZER}/plugins/ox-utils.sh
    [oxpvs]=${OXIDIZER}/plugins/ox-vscode.sh
    [oxpzj]=${OXIDIZER}/plugins/ox-zellij.sh
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

# loading core plugins
for core_plugin in ${OX_CORE_PLUGINS[@]}; do
    . ${OX_OXYGEN[$core_plugin]}
done

case $(uname -a) in
*Darwin*)
    . ${OX_OXYGEN[oxpm]}
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . ${OX_OXYGEN[oxpd]}
    ;;
esac

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
    z ${OXIDIZER}
    git fetch origin master
    git reset --hard origin/master
    z -

    for core_plugin in ${OX_CORE_PLUGINS[@]}; do
        local core_plugin_file=$(basename ${OX_OXYGEN[$core_plugin]})
        curl -o -s ${OX_OXYGEN[$core_plugin]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$core_plugin_file
    done

    case $(uname -a) in
    *Darwin*)
        local macos_plugin_file=$(basename ${OX_OXYGEN[oxpm]})
        curl -o -s ${OX_OXYGEN[oxpm]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$macos_plugin_file
        ;;
    *Ubuntu* | *Debian* | *WSL*)
        local debian_plugin_file=$(basename ${OX_OXYGEN[oxpd]})
        curl -o ${OX_OXYGEN[oxpd]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$debian_plugin_file
        ;;
    esac

    for plugin in ${OX_PLUGINS[@]}; do
        local plugin_file=$(basename ${OX_OXYGEN[$plugin]})
        curl -o -s ${OX_OXYGEN[$plugin]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$plugin_file
    done
}

if [[ ${OX_STARTUP} ]]; then
    startup
fi
