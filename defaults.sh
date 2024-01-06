#!/bin/bash /bin/zsh
##########################################################
# conventions
##########################################################

# uppercase for global variables
# lowercase for local variables

##########################################################
# basic settings
##########################################################

# default editor, can be changed by function `ched()`
export EDITOR='code'
# terminal editor
export EDITOR_T='vi'

##########################################################
# select ox-plugins
##########################################################

# oxpg: ox-git
# oxpc: ox-conda
# oxpbw: ox-bitwarden
# oxpcn: ox-conan
# oxpct: ox-container
# oxpes: ox-espanso
# oxpfm: ox-format
# oxpjl: ox-julia
# oxpjn: ox-jupyter
# oxpnj: ox-nodejs
# oxpns: ox-notes
# oxppu: ox-pueue
# oxprb: ox-ruby
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
# oxpwr: ox-weather
# oxpzj: ox-zellij

OX_PLUGINS=(
    oxpg
    oxpwr
)

##########################################################
# select software configuration objects
##########################################################

# backup file path
export OX_BACKUP=${HOME}/Documents/backup

# shell backups
OX_OXIDE[bkox]=${OX_BACKUP}/shell/custom.sh
# OX_OXIDE[bkvi]=${OX_BACKUP}/shell/.vimrc

# terminal
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
OX_OXIDE[bkwz]=${OX_BACKUP}/terminal/wezterm.lua

##########################################################
# proxy and mirror settings
##########################################################

# to use proxy and mirrors for faster download, don't forget to add `oxpnw` in `OX_PLUGINS`

# c: clash, m: clash-meta, v: v2ray
declare -A OX_PROXY=(
    [c]=7890
    [m]=7897
    [v]=1080
)

# use `mrb [key]` for brew mirror, use `mrbq` for quit brew mirror
# declare -A MIRRORS=(
#     [bts]="mirrors.tuna.tsinghua.edu.cn/git/homebrew"
#     [bzk]="mirrors.ustc.edu.cn/git/homebrew"
# )

##########################################################
# brew settings
##########################################################

case $(uname -a) in
*Darwin* | *Ubuntu* | *Debian*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_CLEANUP_MAX_AGE_DAYS="3"

    # predefined brew services
    # set the length of key <= 3
    declare -A HOMEBREW_SERVICE=(
        [pu]="pueue"
        [pg]="postgresql@15"
        [pd]="podman"
    )
    ;;
esac

##########################################################
# pueue settings
##########################################################

# pueue demo
upp() {
    pueue group add up_all
    pueue parallel 3 -g up_all
    pueue add -g up_all 'brew update && brew upgrade'
    pueue add -g up_all 'conda update --all --yes'
    # or use predefined items in pueue_aliase
    # pueue add -g up_all 'cup'
}

##########################################################
# conda settings
##########################################################

# # predefined conda environments
# # set the length of key <= 3
# declare -A OX_CONDA_ENV=(
#     [b]="base"
#     [k]="kaggle"
# )

# # conda env stats with bkce, and should be consistent with OX_CONDA_ENV
# OX_OXIDE[bkceb]=${OX_BACKUP}/conda/conda-base.txt

##########################################################
# others settings
##########################################################

# git
OX_OXIDE[bkg]=${OX_BACKUP}/.gitconfig
OX_OXIDE[bkgi]=${OX_BACKUP}/git/.gitignore
# OX_OXIDE[bkesb]=${OX_BACKUP}/espanso/match/base.yml
# vscode
# OX_OXIDE[bkvs]=${OX_BACKUP}/vscode/settings.jsonc

##########################################################
# common aliases
##########################################################

# shortcuts
alias cat="bat"
alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias du="dust"
alias e="echo"
alias rr="rm -rf"
alias c="clear"
alias own="sudo chown -R $(whoami)"

# tools
alias man="tldr"
alias hf="hyperfine"

##########################################################
# shell
##########################################################

# clean history
ccc() {
    case ${SHELL} in
    *zsh)
        local HISTSIZE=0 && history -p && reset && echo >"${OX_ELEMENT[zshst]}"
        ;;
    *bash)
        local HISTSIZE=0 && history -c && reset && echo >"${OX_ELEMENT[bshst]}"
        ;;
    esac
}

# configuration
case ${SHELL} in
*zsh)
    # turn case sensitivity off
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    # pasting with tabs doesn't perform completion
    zstyle ':completion:' insert-tab pending
    ;;
*bash)
    # turn case sensitivity off
    if [ ! -e "${HOME}"/.inputrc ]; then
        echo '$include /etc/inputrc' >"${HOME}"/.inputrc
    fi
    echo 'set completion-ignore-case On' >>"${HOME}"/.inputrc
    ;;
esac

# test profile loading time
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
# startup commands
##########################################################

# installer donwloaded path: works for function `brp()`
# use `which brp` to chech `brp()` in details
export OX_DOWNLOAD=${HOME}/Desktop
export OX_STARTUP=1

startup() {
    # start directory
    cd "${HOME}"/Desktop || exit
}

##########################################################
# notes apps
##########################################################

# OX_OXIDIAN=""
