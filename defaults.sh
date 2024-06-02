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

# package managers
# - oxppc: conda
# - oxppcn: conan (c++)
# - oxppnj: npm + yarn
# - oxpptl: tlmgr (texlive)
# languages
# - oxplj: julia
# - oxplr: ruby (include gem)
# - oxplr: rust (include cargo)
# services
# - oxpsc: container (docker & podman)
# - oxpsp: pueue
# app cli
# - oxpcg: git
# - oxpcbw: bitwarden
# - oxpces: espanso
# - oxpcjr: jupyter (notebook, lab, book)
# - oxpcvs: vscode
# system utils
# - oxpufm: format conversion
# terminal utils
# - oxptwr: weather
# - oxptzj: zellij
# extra utils
# - oxpxns: notes

OX_PLUGINS=(
    oxpcg
    oxpufm
)

##########################################################
# select software configuration objects
##########################################################

# backup file path
export OX_BACKUP=${HOME}/Documents/backup

# shellscripts
# the key should meet the following requirements
# 1. starts with `bk`
# 2. keeps consistent with the key in `OX_ELEMENT` (if it exists)

# the oxidizer backup path
OX_OXIDE[bkox]=${OX_BACKUP}/shell/custom.sh

##########################################################
# vim & neovim
##########################################################

OX_OXIDE[bkvi]=${OX_BACKUP}/shell/.vimrc

##########################################################
# terminal
##########################################################
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
# common aliases
##########################################################

# shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias zz="cd -"
alias cat="bat"
alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias du="dust"
alias e="echo"
alias rr="rm -rf"
alias c="clear"
# shellcheck disable=SC2139
alias own="sudo chown -R $(whoami)"

# tools
alias tldr="tlrc"
alias man="tlrc"
alias hf="hyperfine"

# oxidizer
# export config
alias epf="oxf"
# import config
alias ipf="rdf"
# initialize config
alias iif="clzf"

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
    autoload -Uz edit-command-line
    zle -N edit-command-line
    # turn case sensitivity off
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    # other options
    zstyle ':completion:*' menu select
    zstyle ":completion:*" file-sort change
    zstyle ":completion:*" use-cache yes
    # pasting with tabs doesn't perform completion
    zstyle ':completion:' insert-tab pending
    ;;
*bash)
    # turn case sensitivity off
    if [ ! -e "${HOME}"/.inputrc ]; then
        # shellcheck disable=SC2016
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

# installer downloaded path: works for function `brp()`
# use `which brp` to check `brp()` in details
export OX_DOWNLOAD=${HOME}/Desktop
export OX_STARTUP=1

startup() {
    # start directory
    cd "${HOME}" || exit
}

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
    # or use predefined items in pueue_aliases
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
# notes apps
##########################################################

# OX_OXIDIAN=""
