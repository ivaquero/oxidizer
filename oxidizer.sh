#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

##########################################################
# Oxidizer Configuration Files
##########################################################

# plugins
declare -A OX_OXYGEN=(
    [oxd]=${OXIDIZER}/defaults.sh
    [oxwz]=${OXIDIZER}/defaults/wezterm.lua
    [oxpm]=${OXIDIZER}/plugins/ox-macos.sh
    [oxpd]=${OXIDIZER}/plugins/ox-debians.sh
    [oxpr]=${OXIDIZER}/plugins/ox-rehats.sh
    [oxpw]=${OXIDIZER}/plugins/ox-windows.sh
    [oxpb]=${OXIDIZER}/plugins/ox-brew.sh
    [oxps]=${OXIDIZER}/plugins/ox-scoop.sh
    [oxpg]=${OXIDIZER}/plugins/ox-git.sh
    [oxpc]=${OXIDIZER}/plugins/ox-conda.sh
    [oxpbw]=${OXIDIZER}/plugins/ox-bitwarden.sh
    [oxpcn]=${OXIDIZER}/plugins/ox-conan.sh
    [oxpct]=${OXIDIZER}/plugins/ox-container.sh
    [oxpes]=${OXIDIZER}/plugins/ox-espanso.sh
    [oxpfm]=${OXIDIZER}/plugins/ox-formats.sh
    [oxpjl]=${OXIDIZER}/plugins/ox-julia.sh
    [oxpjn]=${OXIDIZER}/plugins/ox-jupyter.sh
    [oxpnj]=${OXIDIZER}/plugins/ox-node.sh
    [oxpns]=${OXIDIZER}/plugins/ox-notes.sh
    [oxpnw]=${OXIDIZER}/plugins/ox-network.sh
    [oxppd]=${OXIDIZER}/plugins/ox-podman.sh
    [oxppu]=${OXIDIZER}/plugins/ox-pueue.sh
    [oxprb]=${OXIDIZER}/plugins/ox-ruby.sh
    [oxprs]=${OXIDIZER}/plugins/ox-rust.sh
    [oxptl]=${OXIDIZER}/plugins/ox-texlive.sh
    [oxput]=${OXIDIZER}/plugins/ox-utils.sh
    [oxpvs]=${OXIDIZER}/plugins/ox-vscode.sh
    [oxpwr]=${OXIDIZER}/plugins/ox-weather.sh
    [oxpzj]=${OXIDIZER}/plugins/ox-zellij.sh
)

##########################################################
# System Configuration Files
##########################################################

declare -A OX_ELEMENT=(
    [ox]=${OXIDIZER}/custom.sh
    [vi]=${HOME}/.vimrc
)

declare -A OX_OXIDE

##########################################################
# Load Plugins
##########################################################

# load system plugin
case $(uname -a) in
*Darwin*)
    . "${OX_OXYGEN[oxpm]}"
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . "${OX_OXYGEN[oxpd]}"
    ;;
*MINGW*)
    . "${OX_OXYGEN[oxpw]}"
    ;;
esac

# load custom plugins
declare -a OX_PLUGINS

. "${OX_ELEMENT[ox]}"

for plugin in "${OX_PLUGINS[@]}"; do
    if [[ -f "${OX_OXYGEN[$plugin]}" ]]; then
        . "${OX_OXYGEN[$plugin]}"
    else
        echo "Plugin not found: ${plugin}"
    fi
done

# load core plugins

declare -a OX_CORE_PLUGINS
case $(uname -a) in
*Darwin* | *Ubuntu* | *Debian* | *WSL*)
    OX_CORE_PLUGINS=(oxpb oxput oxpnw)
    ;;
*MINGW*)
    OX_CORE_PLUGINS=(oxps oxput oxpnw)
    ;;
esac

for core_plugin in "${OX_CORE_PLUGINS[@]}"; do
    . ${OX_OXYGEN[$core_plugin]}
done

##########################################################
# Shell Settings
##########################################################

export SHELLS=/private/etc/shells

case ${SHELL} in
*zsh)
    OX_ELEMENT[zs]=${HOME}/.zshrc
    OX_ELEMENT[zshst]=${HOME}/.zsh_history
    OX_OXIDE[bkzs]=${OX_BACKUP}/shell/.zshrc
    ;;
*bash)
    OX_ELEMENT[bs]=${HOME}/.bash_profile
    OX_ELEMENT[bshst]=${HOME}/.bash_history
    OX_OXIDE[bkbs]=${OX_BACKUP}/shell/.bash_profile
    ;;
esac

OX_OXIDE[bkvi]=${OX_BACKUP}/shell/.vimrc

##########################################################
# Oxidizer Management
##########################################################

# update Oxidizer
upox() {
    cd "${OXIDIZER}" || exit
    printf "Updating Oxidizer...\n"
    git fetch origin master
    git reset --hard origin/master

    if [[ ! -d "${OXIDIZER}"/plugins ]]; then
        printf "\n\nCloning Oxidizer Plugins...\n"
        git clone --depth=1 https://github.com/ivaquero/oxplugins.git "${OXIDIZER}"/plugins
    else
        printf "\n\nUpdating Oxidizer Plugins...\n"
        cd "${OXIDIZER}"/plugins || exit
        git fetch origin main
        git reset --hard origin/main
    fi

    cd "${OXIDIZER}" || exit
    ox_change=$(git diff defaults.sh)
    if [[ -n "$ox_change" ]]; then
        printf "\n\nDefaults changed, don't forget to update your custom.sh accordingly...\n"
        printf "Compare the difference using 'edf oxd'"
    fi
    cd "${HOME}" || exit
}

##########################################################
# Starship
##########################################################

if test "$(command -v starship)"; then
    # system files
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
    esac
fi

if [[ ${OX_STARTUP} ]]; then
    startup
fi
