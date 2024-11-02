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
# - oxpljl: julia
# - oxplrb: ruby (include gem)
# - oxplrs: rust (include cargo)
# app cli
# - oxpcbw: bitwarden
# - oxpces: espanso
# - oxpcjr: jupyter (notebook, lab, book)
# - oxpcol: ollama
# - oxpcvs: vscode
# system utils
# - oxpufm: format conversion
# terminal utils
# - oxptzj: zellij
# extra utils
# - oxpxns: notes

OX_PLUGINS=(
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
# git
##########################################################

# shellcheck disable=SC2155
export GPG_TTY=$(tty)

# default files
OX_OXYGEN[oxg]=${OXIDIZER}/defaults/.gitconfig
# system files
OX_ELEMENT[g]=${HOME}/.gitconfig
# backup files
OX_OXIDE[bkg]=${OX_BACKUP}/projects/.gitconfig
OX_OXIDE[bkgi]=${OX_BACKUP}/projects/.gitignore

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
# proxy settings
##########################################################

# c: clash, m: clash-meta, v: v2ray
declare -A OX_PROXY=(
    [c]=7890
    [m]=7897
    [v]=1080
)

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
        [pg]="postgresql@15"
        [pd]="podman"
    )
    ;;
esac

##########################################################
# conda settings
##########################################################

# predefined conda environments
# set the length of key <= 3
declare -A OX_CONDA_ENV=(
    [b]="base"
    # [k]="kaggle"
)

# # conda env stats with bkce, and should be consistent with OX_CONDA_ENV
# OX_OXIDE[bkceb]=${OX_BACKUP}/conda/conda-base.txt

##########################################################
# julia settings
##########################################################

# predefined julia environments
# set the length of key <= 3
export JULIA_DEPOT_PATH=${JULIA_DEPOT_PATH:-"${HOME}/.julia"}
declare -A OX_JULIA_ENV=(
    [b]="${JULIA_DEPOT_PATH}/environments/v$(julia -v | rg -o "\d+\.\d+")"
    # [t]="tutorial"
)

# # julia env stats with bkjl, and should be consistent with OX_JULIA_ENV
# OX_OXIDE[bkjlb]=${OX_BACKUP}/julia/julia-base.txt

##########################################################
# others settings
##########################################################

# OX_OXIDE[bkesb]=${OX_BACKUP}/espanso/match/base.yml
# vscode
# OX_OXIDE[bkvs]=${OX_BACKUP}/vscode/settings.jsonc

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
alias man="tldr"
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
# notes apps
##########################################################

# OX_OXIDIAN=""
