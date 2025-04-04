#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

# oxidizer configuration files
OX_PLUGINS=$(jq .ox_plugins <"$OXIDIZER"/config.json)
OX_OXYGEN=$(jq .ox_oxygen <"$OXIDIZER"/config.json)

# system configuration files
declare -A OX_ELEMENT=(
    [ox]=${OXIDIZER}/custom.sh
    [zs]=${HOME}/.zshrc
    [zshs]=${HOME}/.zsh_history
    [bs]=${HOME}/.bash_profile
    [bshs]=${HOME}/.bash_history
    [g]=${HOME}/.gitconfig
    [vi]=${HOME}/.vimrc
    [dk]=${HOME}/.docker/custom.json
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

# backup configuration files
OX_OXIDE=$(jq .ox_oxide <"$OXIDIZER"/custom.json)
OX_PLUGINS_PLUS=$(jq .ox_plugins_plus <"$OXIDIZER"/custom.json)

# # load custom plugins
# shellcheck disable=SC2002
OX_PLUGINS_LOADED=$(cat "$OXIDIZER"/custom.json | jq .plugin_load | rg -o "\w+")

echo "${OX_PLUGINS_LOADED}" | while read -r line; do
    . "$OXIDIZER"/"$(echo "$OX_PLUGINS" | jq -r ."$line")"
done

# shellcheck disable=SC2002
OX_PLUGINS_LOADED_PLUS=$(cat "$OXIDIZER"/custom.json | jq .plugin_load_plus | rg -o "\w+")
if [ -n "$OX_PLUGINS_LOADED_PLUS" ]; then
    echo "${OX_PLUGINS_LOADED_PLUS}" | while read -r line; do
        . "$(echo "$OX_PLUGINS_PLUS" | jq -r ."$line")"
    done
fi

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

# clean history
ccc() {
    case ${SHELL} in
    *zsh)
        local HISTSIZE=0 && history -p && reset && echo >"${OX_ELEMENT[zshs]}"
        ;;
    *bash)
        local HISTSIZE=0 && history -c && reset && echo >"${OX_ELEMENT[bshs]}"
        ;;
    esac
}

tt() {
    case ${SHELL} in
    *zsh)
        hyperfine --warmup 3 --shell zsh "source ${OX_ELEMENT[zs]}"
        ;;
    *bash)
        hyperfine --warmup 3 --shell bash "source ${OX_ELEMENT[bs]}"
        ;;
    esac
}

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
# Zoxide
##########################################################

export _ZO_DATA_DIR=${HOME}/.config/zoxide

if [[ ! -d "$_ZO_DATA_DIR" ]]; then
    mkdir -p -v "$_ZO_DATA_DIR"
fi

OX_ELEMENT[z]=${_ZO_DATA_DIR}/db.zo

case ${SHELL} in
*zsh)
    eval "$(zoxide init zsh)"
    ;;
*bash)
    eval "$(zoxide init bash)"
    ;;
esac

alias zh="zoxide --help"
alias zii="zoxide init"
alias za="zoxide add"
alias zrm="zoxide remove"
alias zed="zoxide edit"
alias zsc="zoxide query"

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
