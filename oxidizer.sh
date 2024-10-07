#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

##########################################################
# Oxidizer Configuration Files
##########################################################

# plugins
declare -A OX_OXYGEN=(
    [oxd]=${OXIDIZER}/defaults.sh
    [oxwz]=${OXIDIZER}/defaults/wezterm.lua
    [oxpod]=${OXIDIZER}/plugins/ox-os-debians.sh
    [oxpom]=${OXIDIZER}/plugins/ox-os-macos.sh
    [oxpor]=${OXIDIZER}/plugins/ox-os-rehats.sh
    [oxpow]=${OXIDIZER}/plugins/ox-os-windows.sh
    [oxpcbw]=${OXIDIZER}/plugins/ox-cli-bitwarden.sh
    [oxpces]=${OXIDIZER}/plugins/ox-cli-espanso.sh
    [oxpcjr]=${OXIDIZER}/plugins/ox-cli-jupyter.sh
    [oxpcvs]=${OXIDIZER}/plugins/ox-cli-vscode.sh
    [oxpljl]=${OXIDIZER}/plugins/ox-lang-julia.sh
    [oxplrb]=${OXIDIZER}/plugins/ox-lang-ruby.sh
    [oxplrs]=${OXIDIZER}/plugins/ox-lang-rust.sh
    [oxppb]=${OXIDIZER}/plugins/ox-pkg-brew.sh
    [oxppc]=${OXIDIZER}/plugins/ox-pkg-conda.sh
    [oxppcn]=${OXIDIZER}/plugins/ox-pkg-conan.sh
    [oxppnj]=${OXIDIZER}/plugins/ox-pkg-npm.sh
    [oxpps]=${OXIDIZER}/plugins/ox-pkg-scoop.sh
    [oxpptl]=${OXIDIZER}/plugins/ox-pkg-tlmgr.sh
    [oxpsol]=${OXIDIZER}/plugins/ox-svc-ollama.sh
    [oxpspu]=${OXIDIZER}/plugins/ox-svc-pueue.sh
    [oxpuf]=${OXIDIZER}/plugins/ox-utils-files.sh
    [oxpufm]=${OXIDIZER}/plugins/ox-utils-formats.sh
    [oxpunw]=${OXIDIZER}/plugins/ox-utils-networks.sh
    [oxptzj]=${OXIDIZER}/plugins/ox-term-zellij.sh
    [oxpxns]=${OXIDIZER}/plugins/ox-xtra-notes.sh
)

##########################################################
# System Configuration Files
##########################################################

declare -A OX_ELEMENT=(
    [ox]=${OXIDIZER}/custom.sh
    [g]=${HOME}/.gitconfig
    [vi]=${HOME}/.vimrc
)

declare -A OX_OXIDE

##########################################################
# Load Plugins
##########################################################

# load system plugin
case $(uname -a) in
*Darwin*)
    . "${OX_OXYGEN[oxpom]}"
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . "${OX_OXYGEN[oxpod]}"
    ;;
*MINGW*)
    . "${OX_OXYGEN[oxpow]}"
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
    OX_CORE_PLUGINS=(oxppb oxpuf oxpunw)
    ;;
*MINGW*)
    OX_CORE_PLUGINS=(oxpps oxpuf oxpunw)
    ;;
esac

for core_plugin in "${OX_CORE_PLUGINS[@]}"; do
    . "${OX_OXYGEN[$core_plugin]}"
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
# fzf
##########################################################

if test "$(command -v fzf)"; then
    case ${SHELL} in
    *zsh)
        source <(fzf --zsh)
        ;;
    *bash)
        eval "$(fzf --bash)"
        ;;
    esac
fi

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
