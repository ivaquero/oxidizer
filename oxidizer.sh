if [[ -z ${OXIDIZER} ]]; then
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
OX_OXYGEN[oxpm]=${OXIDIZER}/zsh-plugins/ox-macos.sh
OX_OXYGEN[oxpa]=${OXIDIZER}/zsh-plugins/ox-apt.sh
OX_OXYGEN[oxpb]=${OXIDIZER}/zsh-plugins/ox-brew.sh
OX_OXYGEN[oxpg]=${OXIDIZER}/zsh-plugins/ox-git.sh
OX_OXYGEN[oxpc]=${OXIDIZER}/zsh-plugins/ox-conda.sh
OX_OXYGEN[oxpbw]=${OXIDIZER}/zsh-plugins/ox-bitwarden.sh
OX_OXYGEN[oxpcn]=${OXIDIZER}/zsh-plugins/ox-conan.sh
OX_OXYGEN[oxpct]=${OXIDIZER}/zsh-plugins/ox-container.sh
OX_OXYGEN[oxpes]=${OXIDIZER}/zsh-plugins/ox-espanso.sh
OX_OXYGEN[oxpfm]=${OXIDIZER}/zsh-plugins/ox-formats.sh
OX_OXYGEN[oxphx]=${OXIDIZER}/zsh-plugins/ox-helix.sh
OX_OXYGEN[oxpjl]=${OXIDIZER}/zsh-plugins/ox-julia.sh
OX_OXYGEN[oxpjn]=${OXIDIZER}/zsh-plugins/ox-jupyter.sh
OX_OXYGEN[oxpnj]=${OXIDIZER}/zsh-plugins/ox-node.sh
OX_OXYGEN[oxppd]=${OXIDIZER}/zsh-plugins/ox-podman.sh
OX_OXYGEN[oxppu]=${OXIDIZER}/zsh-plugins/ox-pueue.sh
OX_OXYGEN[oxprs]=${OXIDIZER}/zsh-plugins/ox-rust.sh
OX_OXYGEN[oxptl]=${OXIDIZER}/zsh-plugins/ox-texlive.sh
OX_OXYGEN[oxput]=${OXIDIZER}/zsh-plugins/ox-utils.sh
OX_OXYGEN[oxpvs]=${OXIDIZER}/zsh-plugins/ox-vscode.sh
OX_OXYGEN[oxpzj]=${OXIDIZER}/zsh-plugins/ox-zellij.sh

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

if [[ ! -d ${OX_BACKUP}/shell ]]; then
    mkdir -p ${OX_BACKUP}/shell
fi

if [[ ! -d ${OX_BACKUP}/install ]]; then
    mkdir -p ${OX_BACKUP}/install
fi

if [[ ! -d ${OX_BACKUP}/apps ]]; then
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

declare -a OX_PLUGINS

# import ox-utils
. ${OX_OXYGEN[oxput]}
# import ox-pueue
. ${OX_OXYGEN[oxppu]}

# import ox-brew
if [[ $(uname -s) != "Linux" ]] && [[ $(uname -m) != "aarch64" ]]; then
    . ${OX_OXYGEN[oxpb]}
fi

case $(uname -a) in
*Darwin*)
    . ${OX_OXYGEN[oxpm]}
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . ${OX_OXYGEN[oxpa]}
    ;;
esac

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
