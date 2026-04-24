#!/usr/bin/env bash
export OXIDIZER=${OXIDIZER:-"$HOME/oxidizer"}

DEFAULT_CONFIG="${OXIDIZER}/defaults/config.json"
CUSTOM_CONFIG="${OXIDIZER}/custom.json"

if ! command -v jq >/dev/null 2>&1; then
    printf 'oxidizer: jq is required but was not found in PATH.\n' >&2
    return 1 2>/dev/null || exit 1
fi

json_get() {
    local expression="$1"
    local file="$2"
    jq -r "${expression} // empty" <"$file"
}

source_plugin_file() {
    local plugin_rel_path="$1"
    local plugin_file="${OXIDIZER}/${plugin_rel_path}"

    if [[ -z "$plugin_rel_path" ]]; then
        return 1
    fi

    if [[ ! -f "$plugin_file" ]]; then
        printf 'oxidizer: skip missing plugin file: %s\n' "$plugin_file" >&2
        return 1
    fi

    # shellcheck source=/dev/null
    . "$plugin_file"
}

source_plugin_key() {
    local key="$1"
    local map="${2:-plugins}"
    local config_file="${3:-$DEFAULT_CONFIG}"
    local plugin_rel_path

    plugin_rel_path="$(jq -r --arg map "$map" --arg key "$key" '.[$map][$key] // empty' <"$config_file")"
    source_plugin_file "$plugin_rel_path"
}

# oxidizer configuration files
OX_OXYGEN_KEYS="$(jq -r '.oxygen | keys[]?' <"$DEFAULT_CONFIG")"
export OX_BACKUP="$HOME/$(json_get '.oxide_folder' "$CUSTOM_CONFIG")"
export OX_DOWNLOAD="$HOME/$(json_get '.download_folder' "$CUSTOM_CONFIG")"

# system configuration files
if [[ -n ${ZSH_VERSION:-} ]]; then
    typeset -gA OX_ELEMENT
else
    declare -A OX_ELEMENT
fi

OX_ELEMENT[ox]="${CUSTOM_CONFIG}"
OX_ELEMENT[zs]="$HOME/.zshrc"
OX_ELEMENT[zsh]="$HOME/.zsh_history"
OX_ELEMENT[bsh]="$HOME/.bash_history"
OX_ELEMENT[g]="$HOME/.gitconfig"
OX_ELEMENT[vi]="$HOME/.vimrc"
OX_ELEMENT[dr]="$HOME/.docker/custom.json"
OX_ELEMENT[drd]="$HOME/.docker/daemon.json"
OX_ELEMENT[wz]="$HOME/.wezterm.lua"

if [[ -f "$HOME/.bashrc" ]]; then
    OX_ELEMENT[bs]="$HOME/.bashrc"
elif [[ -f "$HOME/.bash_profile" ]]; then
    OX_ELEMENT[bs]="$HOME/.bash_profile"
elif [[ -f "$HOME/.profile" ]]; then
    OX_ELEMENT[bs]="$HOME/.profile"
fi

OS_NAME="$(uname -s)"
OS_INFO="$(uname -a)"

case "$OS_NAME" in
Darwin)
    OX_ELEMENT[lg]="$HOME/Library/Application Support/lazygit/config.yml"
    ;;
Linux)
    OX_ELEMENT[lg]="$HOME/.config/lazygit/config.yml"
    ;;
esac

# backup configuration files
OX_OXIDE="$(jq -c '.oxides // {}' <"$CUSTOM_CONFIG")"

##########################################################
# Load Plugins
##########################################################

# load core plugins
if command -v brew >/dev/null 2>&1; then
    source_plugin_key "pkg_brew" "plugins" "$DEFAULT_CONFIG"
fi

case "$OS_INFO" in
*Darwin*)
    source_plugin_key "os_macos" "plugins" "$DEFAULT_CONFIG"
    ;;
*Ubuntu* | *Debian*)
    source_plugin_key "os_debian" "plugins" "$DEFAULT_CONFIG"
    ;;
*RedHat* | *Redhat*)
    source_plugin_key "os_redhat" "plugins" "$DEFAULT_CONFIG" || source_plugin_key "os_rehat" "plugins" "$DEFAULT_CONFIG"
    ;;
*MINGW*)
    source_plugin_key "os_windows" "plugins" "$DEFAULT_CONFIG"
    source_plugin_key "pkg_scoop" "plugins" "$DEFAULT_CONFIG"
    ;;
esac

source_plugin_key "utils_files" "plugins" "$DEFAULT_CONFIG"
source_plugin_key "utils_formats" "plugins" "$DEFAULT_CONFIG"
source_plugin_key "utils_networks" "plugins" "$DEFAULT_CONFIG"

# load plugins
while IFS= read -r plugin; do
    [[ -n "$plugin" ]] || continue
    source_plugin_key "$plugin" "plugins" "$DEFAULT_CONFIG"
done < <(jq -r '.plugins_load[]?' <"$CUSTOM_CONFIG")

# load custom plugins
while IFS= read -r plugin; do
    [[ -n "$plugin" ]] || continue
    source_plugin_key "$plugin" "plugins_plus" "$CUSTOM_CONFIG"
done < <(jq -r '.plugins_load_plus[]?' <"$CUSTOM_CONFIG")

##########################################################
# Shell Settings
##########################################################

export GPG_TTY="$(tty)"

if [[ -f /private/etc/shells ]]; then
    export SHELLS=/private/etc/shells
elif [[ -f /etc/shells ]]; then
    export SHELLS=/etc/shells
fi

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
    if [[ ! -e "$HOME/.inputrc" ]]; then
        printf '%s\n' '$include /etc/inputrc' >"$HOME/.inputrc"
    fi
    if ! grep -Fxq 'set completion-ignore-case On' "$HOME/.inputrc"; then
        printf '%s\n' 'set completion-ignore-case On' >>"$HOME/.inputrc"
    fi
    ;;
esac

# clean history
ccc() {
    case ${SHELL} in
    *zsh)
        local HISTSIZE=0
        history -p && reset && : >"${OX_ELEMENT[zsh]}"
        ;;
    *bash)
        local HISTSIZE=0
        history -c && reset && : >"${OX_ELEMENT[bsh]}"
        ;;
    esac
}

tt() {
    local shell_file

    if ! command -v hyperfine >/dev/null 2>&1; then
        printf 'oxidizer: hyperfine is not installed.\n' >&2
        return 1
    fi

    case ${SHELL} in
    *zsh)
        shell_file="${OX_ELEMENT[zs]}"
        ;;
    *bash)
        shell_file="${OX_ELEMENT[bs]}"
        ;;
    esac

    if [[ -z "$shell_file" || ! -f "$shell_file" ]]; then
        printf 'oxidizer: shell profile is missing: %s\n' "$shell_file" >&2
        return 1
    fi

    hyperfine --warmup 3 --shell "${SHELL}" "source ${shell_file}"
}

##########################################################
# Zoxide
##########################################################

export _ZO_DATA_DIR=${_ZO_DATA_DIR:-"$HOME/.config/zoxide"}
OX_ELEMENT[z]="${_ZO_DATA_DIR}/db.zo"

if command -v zoxide >/dev/null 2>&1; then
    case ${SHELL} in
    *zsh)
        eval "$(zoxide init zsh)"
        ;;
    *bash)
        eval "$(zoxide init bash)"
        ;;
    esac

    alias zii="zoxide init"
    alias za="zoxide add"
    alias zrm="zoxide remove"
    alias zed="zoxide edit"
    alias zsc="zoxide query"
fi

##########################################################
# Starship
##########################################################

if command -v starship >/dev/null 2>&1; then
    # system files
    export STARSHIP_CONFIG=${STARSHIP_CONFIG:-"$HOME/.config/starship.toml"}
    OX_ELEMENT[ss]="${STARSHIP_CONFIG}"

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
# oxidizer Management
##########################################################

# update oxidizer
upox() {
    local force_reclone="$1"

    if ! command -v git >/dev/null 2>&1; then
        printf 'oxidizer: git is required for upox.\n' >&2
        return 1
    fi

    cd "${OXIDIZER}" || return 1
    printf "Updating oxidizer...\n"
    git fetch origin master
    git reset --hard origin/master

    if [[ ! -d "${OXIDIZER}/plugins" ]]; then
        printf "\n\nCloning oxidizer Plugins...\n"
        git clone --depth=1 https://github.com/ivaquero/oxplugins.git "${OXIDIZER}/plugins"
    else
        printf "\n\nUpdating oxidizer Plugins...\n"
        if [[ "$force_reclone" == "-f" ]]; then
            rm -rf "${OXIDIZER}/plugins"
            git clone --depth=1 https://github.com/ivaquero/oxplugins.git "${OXIDIZER}/plugins"
        fi
        cd "${OXIDIZER}/plugins" || return 1
        git fetch origin main
        git reset --hard origin/main
    fi

    cd "$HOME" || return 1
}

lsoxp() {
    printf "Available Plugins:\n"
    jq -r '.plugins | keys[]' <"$DEFAULT_CONFIG"
}

lsox() {
    printf '%s\n' "$OX_OXYGEN_KEYS"
}

lsoxsys() {
    printf '%s\n' "${OX_ELEMENT[@]}" | sort
}

lsoxbk() {
    printf '%s\n' "$OX_OXIDE"
}

##########################################################
# Startup
##########################################################

export OX_STARTUP="$(json_get '.startup_folder' "$CUSTOM_CONFIG")"

if [[ -n "${OX_STARTUP}" ]]; then
    if ! cd "$HOME/${OX_STARTUP}"; then
        printf 'oxidizer: startup folder not found: %s\n' "$HOME/${OX_STARTUP}" >&2
    fi
fi
