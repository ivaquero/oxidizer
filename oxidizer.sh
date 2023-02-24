if (test -z ${OXIDIZER}); then
    export OXIDIZER=${HOME}/oxidizer
fi

##########################################################
# Oxidizer configuration files
##########################################################

declare -A OX_OXYGEN
# defaults
OX_OXYGEN[oxd]=${OXIDIZER}/defaults.sh
OX_OXYGEN[oxwz]=${OXIDIZER}/defaults/wezterm.lua
# plugins
OX_OXYGEN[oxpm]=${OXIDIZER}/plugins/ox-macos.sh
OX_OXYGEN[oxpd]=${OXIDIZER}/plugins/ox-debians.sh
OX_OXYGEN[oxpb]=${OXIDIZER}/plugins/ox-brew.sh
OX_OXYGEN[oxpg]=${OXIDIZER}/plugins/ox-git.sh
OX_OXYGEN[oxpc]=${OXIDIZER}/plugins/ox-conda.sh
OX_OXYGEN[oxpbw]=${OXIDIZER}/plugins/ox-bitwarden.sh
OX_OXYGEN[oxpcn]=${OXIDIZER}/plugins/ox-conan.sh
OX_OXYGEN[oxpct]=${OXIDIZER}/plugins/ox-container.sh
OX_OXYGEN[oxpes]=${OXIDIZER}/plugins/ox-espanso.sh
OX_OXYGEN[oxpfm]=${OXIDIZER}/plugins/ox-formats.sh
OX_OXYGEN[oxphx]=${OXIDIZER}/plugins/ox-helix.sh
OX_OXYGEN[oxpjl]=${OXIDIZER}/plugins/ox-julia.sh
OX_OXYGEN[oxpjn]=${OXIDIZER}/plugins/ox-jupyter.sh
OX_OXYGEN[oxpnj]=${OXIDIZER}/plugins/ox-node.sh
OX_OXYGEN[oxppd]=${OXIDIZER}/plugins/ox-podman.sh
OX_OXYGEN[oxppu]=${OXIDIZER}/plugins/ox-pueue.sh
OX_OXYGEN[oxprs]=${OXIDIZER}/plugins/ox-rust.sh
OX_OXYGEN[oxptl]=${OXIDIZER}/plugins/ox-texlive.sh
OX_OXYGEN[oxput]=${OXIDIZER}/plugins/ox-utils.sh
OX_OXYGEN[oxpvs]=${OXIDIZER}/plugins/ox-vscode.sh
OX_OXYGEN[oxpzj]=${OXIDIZER}/plugins/ox-zellij.sh

##########################################################
# System configuration files
##########################################################

declare -A OX_ELEMENT

OX_ELEMENT[ox]=${OXIDIZER}/custom.sh
OX_ELEMENT[wz]=${HOME}/.config/wezterm/wezterm.lua
OX_ELEMENT[zs]=${HOME}/.zshrc
OX_ELEMENT[bs]=${HOME}/.bash_profile
OX_ELEMENT[fs]=${HOME}/.config/fish/config.fish

declare -A OX_OXIDE

. ${OX_ELEMENT[ox]}

if (test ! -d ${OX_BACKUP}/shell); then
    mkdir -p ${OX_BACKUP}/shell
fi

if (test ! -d ${OX_BACKUP}/install); then
    mkdir -p ${OX_BACKUP}/install
fi

if (test ! -d ${OX_BACKUP}/apps); then
    mkdir -p ${OX_BACKUP}/apps
fi

##########################################################
# Shell
##########################################################

export SHELLS=/private/etc/shells

add_shell() {
    echo $1 | sudo tee -a ${SHELLS}
}

alias shell="echo ${SHELL}"
alias shells="cat ${SHELLS}"

##########################################################
# Zsh & Plugins
##########################################################

declare -a OX_CORE_PLUGINS
OX_CORE_PLUGINS=(oxpb oxput oxppu)

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

declare -a OX_PLUGINS

for plugin in ${OX_PLUGINS[@]}; do
    . ${OX_OXYGEN[$plugin]}
done

##########################################################
# Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
init_all() {
    for obj in ${OX_INIT_PROG[@]}; do
        eval init_$obj
    done
}

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

# initialize Oxidizer
iiox() {
    for obj in ${OX_INIT_FILE[@]}; do
        iif $obj
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
        curl -o ${OX_OXYGEN[$core_plugin]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$core_plugin_file
    done

    case $(uname -a) in
    *Darwin*)
        local macos_plugin_file=$(basename ${OX_OXYGEN[oxpm]})
        curl -o ${OX_OXYGEN[oxpm]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$macos_plugin_file
        ;;
    *Ubuntu* | *Debian* | *WSL*)
        local debian_plugin_file=$(basename ${OX_OXYGEN[oxpd]})
        curl -o ${OX_OXYGEN[oxpd]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$debian_plugin_file
        ;;
    esac

    for plugin in ${OX_PLUGINS[@]}; do
        local plugin_file=$(basename ${OX_OXYGEN[$plugin]})
        curl -o ${OX_OXYGEN[$plugin]} https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/zsh-plugins/$plugin_file
    done
}

case ${SHELL} in
*zsh)
    eval "$(zoxide init zsh)"
    ;;
*bash)
    eval "$(zoxide init bash)"
    ;;
*fish)
    eval "$(zoxide init fish)"
    ;;
esac

if [[ ${OX_STARTUP} ]]; then
    startup
fi
