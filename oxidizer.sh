#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

# oxidizer configuration files
OX_OXYGEN=$(jq .oxygen <"$OXIDIZER"/defaults/config.json)
# shellcheck disable=SC2155
export OX_BACKUP=${HOME}/$(jq -r .oxide_folder <"$OXIDIZER"/custom.json)
# shellcheck disable=SC2155
export OX_DOWNLOAD=${HOME}/$(jq -r .download_folder <"$OXIDIZER"/custom.json)

# system configuration files
declare -A OX_ELEMENT=(
    [ox]=${OXIDIZER}/custom.sh
    [jox]=${OXIDIZER}/custom.json
    [zs]=${HOME}/.zshrc
    [zshs]=${HOME}/.zsh_history
    [bs]=${HOME}/.bash_profile
    [bshs]=${HOME}/.bash_history
    [g]=${HOME}/.gitconfig
    [vi]=${HOME}/.vimrc
    [dk]=${HOME}/.docker/custom.json
    [dkd]=${HOME}/.docker/daemon.json
    [wz]=${HOME}/.wezterm.lua
)

case $(uname -s) in
Darwin)
    OX_ELEMENT[lg]="${HOME}/Library/Application Support/lazygit/config.yml"
    ;;
Linux)
    OX_ELEMENT[lg]="${HOME}/.config/lazygit/config.yml"
    ;;
esac

# backup configuration files
OX_OXIDE=$(jq .oxides <"$OXIDIZER"/custom.json)

##########################################################
# Load Plugins
##########################################################

. "${OX_ELEMENT[ox]}"

# load required plugin
case $(uname -a) in
*Darwin*)
    . "$OXIDIZER"/"$(jq -r .plugins.os_macos <"$OXIDIZER"/defaults/config.json)"
    . "$OXIDIZER"/"$(jq -r .plugins.pkg_brew <"$OXIDIZER"/defaults/config.json)"
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . "$OXIDIZER"/"$(jq -r .plugins.os_debian <"$OXIDIZER"/defaults/config.json)"
    . "$OXIDIZER"/"$(jq -r .plugins.pkg_brew <"$OXIDIZER"/defaults/config.json)"
    ;;
esac

. "$OXIDIZER"/"$(jq -r .plugins.utils_files <"$OXIDIZER"/defaults/config.json)"
. "$OXIDIZER"/"$(jq -r .plugins.utils_formats <"$OXIDIZER"/defaults/config.json)"
. "$OXIDIZER"/"$(jq -r .plugins.utils_networks <"$OXIDIZER"/defaults/config.json)"

for plugin in $(jq -r ".plugins_load |.[]" <"$OXIDIZER"/custom.json); do
    . "$OXIDIZER"/"$(jq -r .plugins."$plugin" <"$OXIDIZER"/defaults/config.json)"
done

# # load custom plugins
if [[ -n $(jq .plugins_plus <"$OXIDIZER"/custom.json) ]]; then
    for plugin in $(jq -r ".plugins_load_plus |.[]" <"$OXIDIZER"/custom.json); do
        . "$OXIDIZER"/"$(jq -r .plugins_plus."$plugin" <"$OXIDIZER"/defaults/config.json)"
    done
fi

##########################################################
# Shell Settings
##########################################################

# shellcheck disable=SC2155
export GPG_TTY=$(tty)

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

    cd "${HOME}" || exit
}

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
# Startup
##########################################################

# shellcheck disable=SC2155
export OX_STARTUP=$(jq -r .startup_folder <"$OXIDIZER"/custom.json)

if [[ "${OX_STARTUP}" ]]; then
    cd "${HOME}/${OX_STARTUP}" || exit
fi
