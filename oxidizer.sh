#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

# oxidizer configuration files
OX_PLUGINS=$(jq .plugin_file <"$OXIDIZER"/default.json)
OX_OXYGEN=$(jq .builtin_config_file <"$OXIDIZER"/default.json)

# system configuration files
declare -A OX_ELEMENT=(
    [ox]=${OXIDIZER}/custom.sh
    [g]=${HOME}/.gitconfig
    [vi]=${HOME}/.vimrc
    [dk]=${HOME}/.docker/config.json
    [dkd]=${HOME}/.docker/daemon.json
)

case $(uname -s) in
Darwin)
    OX_ELEMENT[lg]="${HOME}/Library/Application Support/lazygit/config.yml"
    ;;
Linux)
    OX_ELEMENT[lg]="${HOME}/.config/lazygit/config.yml"
    ;;
esac

case $(uname -a) in
*Darwin* | *Ubuntu* | *Debian*)
    OX_ELEMENT[wz]=${HOME}/.config/wezterm/wezterm.lua
    ;;
*MINGW*)
    OX_ELEMENT[wz]=${HOME}/.wezterm.lua
    if [[ -z "${OX_ELEMENT[wz]}" ]]; then
        touch "${OX_ELEMENT[wz]}"
    fi
    ;;
esac

# backup configuration files
OX_OXIDE=$(jq .backup_config_file <"$OXIDIZER"/config.json)

##########################################################
# Load Plugins
##########################################################

# shellcheck disable=SC1091
. "$OXIDIZER"/custom.sh

# load required plugin
case $(uname -a) in
*Darwin*)
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .os_macos)"
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .pkg_brew)"
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .os_debian)"
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .pkg_brew)"
    ;;
*MINGW*)
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .os_windows)"
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .pkg_scoop)"
    ;;
esac

. "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .utils_files)"
. "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .utils_formats)"
. "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r .utils_networks)"

# # load custom plugins
# shellcheck disable=SC2002
OX_PLUGINS_LOADED=$(cat "$OXIDIZER"/config.json | jq .plugin_load | rg -o "\w+")

echo "${OX_PLUGINS_LOADED}" | while read -r line; do
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r ."$line")"
done

##########################################################
# Shell Settings
##########################################################

export SHELLS=/private/etc/shells

case ${SHELL} in
*zsh)
    # edit
    autoload -Uz edit-command-line
    zle -N edit-command-line
    # turn case sensitivity off
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    # pasting with tabs doesn't perform completion
    zstyle ':completion:' insert-tab pending
    # git colorization
    zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
    # other options
    zstyle ':completion:*' menu select
    zstyle ':completion:*' file-sort change
    zstyle ':completion:*' use-cache yes
    ;;
*bash)
    # turn case sensitivity off
    if [[ ! -e "${HOME}"/.inputrc ]]; then
        echo '$include /etc/inputrc' >"${HOME}"/.inputrc
    fi
    echo 'set completion-ignore-case On' >>"${HOME}"/.inputrc
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

if command -v fzf >/dev/null 2>&1; then
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

if command -v starship >/dev/null 2>&1; then
    # system files
    export STARSHIP_CONFIG=${HOME}/.config/starship.toml
    OX_ELEMENT[ss]=${STARSHIP_CONFIG}

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
