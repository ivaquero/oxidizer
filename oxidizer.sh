#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}

##########################################################
# Oxidizer Configuration Files
##########################################################

OX_OXYGEN=$(jq .plugin_file <"$OXIDIZER"/config.json)

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

# load required plugin
case $(uname -a) in
*Darwin*)
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxpom)"
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxppb)"
    ;;
*Ubuntu* | *Debian* | *WSL*)
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxpod)"
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxppb)"
    ;;
*MINGW*)
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxpow)"
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxpps)"
    ;;
esac

. "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxpunw)"
. "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r .oxpuf)"

# # load custom plugins
# declare -a OX_PLUGINS

# shellcheck disable=SC2002
OX_PLUGINS=$(cat "$OXIDIZER"/config.json | jq .plugin_load | rg -o "\w+")

echo "${OX_PLUGINS}" | while read -r line; do
    . "$OXIDIZER"/"$(echo "$OX_OXYGEN" | jq -r ."$line")"
done

. "${OX_ELEMENT[ox]}"

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
