# conventions
#
# uppercase for global variables
# lowercase for local variables

##########################################################
# basic settings
##########################################################

# change editor
# $1: name
che() {
    sd "EDITOR=\'.*\'" "EDITOR=\'$1\'" ${OX_ELEMENT[ox]}
    case ${SHELL} in
    *zsh)
        . ${OX_ELEMENT[zs]}
        ;;
    *bash)
        . ${OX_ELEMENT[bs]}
        ;;
    *fish)
        . ${OX_ELEMENT[fs]}
        ;;
    esac
}

# default editor, can be changed by function `che()`
export EDITOR='code'
# terminal editor
export EDITOR_T='vi'

##########################################################
# select ox-plugins
##########################################################

# toolchain specific (highly recommended)
# oxpg: ox-git
#
# language & software-specific
# oxpc: ox-conda
# oxpcn: ox-conan
# oxpct: ox-container
# oxpes: ox-espanso
# oxphx: ox-helix
# oxpjl: ox-julia
# oxpjn: ox-jupyter
# oxpnj: ox-node
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
# oxpzj: ox-zellij
#
# other-shortcuts
# oxpfm: ox-formats
# oxpbw: ox-bitwarden
OX_PLUGINS=(
    oxpg
    oxpfm
)

##########################################################
# select software configuration objects
##########################################################

# options: brew, conda, vscode, julia, texlive, node
declare -a OX_UPDATE_PROG
export OX_UPDATE_PROG=(brew)

declare -a OX_BACKUP_PROG
export OX_BACKUP_PROG=(brew)

# backup file path
export OX_BACKUP=${HOME}/Documents/backup

# shell
OX_OXIDE[bkox]=${OX_BACKUP}/shell/custom.sh
OX_OXIDE[bkzs]=${OX_BACKUP}/shell/.zshrc
OX_OXIDE[bkbs]=${OX_BACKUP}/shell/.bash_profile
OX_OXIDE[bkz]=${OX_BACKUP}/shell/db.zo
OX_OXIDE[bklx]=${OX_BACKUP}/install/source.list

# terminal
# OX_OXIDE[bkvi]=${OX_BACKUP}/.vimrc
# OX_OXIDE[bkwz]=${OX_BACKUP}/terminal/wezterm.lua
# OX_OXIDE[bkal]=${OX_BACKUP}/terminal/alacritty.yml

# system file
OX_ELEMENT[vi]=${HOME}/.vimrc
# OX_ELEMENT[al]=${HOME}/.config/alacritty/alacritty.yml

##########################################################
# register proxy ports
##########################################################

# c: clash, v: v2ray
declare -A OX_PROXY=(
    [c]=7890
    [v]=1080
)

OX_ELEMENT[cv]="${HOME}/.config/clash-verge/verge.yaml"
OX_OXIDE[bkcv]="${OX_BACKUP}/app/verge.yaml"

##########################################################
# select export and import settings
##########################################################

# files to be exported to backup folder
# ox: custom.sh of Oxidizer
# rs: cargo's env
# pu: pueue's config.yml
# pua: pueue's aliases.yml
# jl: julia's startup.jl
# vs: vscode's settings.json
# vsk: vscode's keybindings.json
# vss_: vscode's snippets folder
declare -a OX_EXPORT_FILE
OX_EXPORT_FILE=(ox)

# files to be import from backup folder
declare -a OX_IMPORT_FILE
OX_IMPORT_FILE=(ox)

##########################################################
# git settings
##########################################################

# backup files
OX_OXIDE[bkg]=${OX_BACKUP}/.gitconfig
OX_OXIDE[bkgi]=${OX_BACKUP}/git/.gitignore

##########################################################
# zellij settings
##########################################################

# if [ ! -d ${OX_BACKUP}/zellij ]; then
#     mkdir -p ${OX_BACKUP}/zellij
# fi

# OX_OXIDE[bkzj]=${OX_BACKUP}/zellij/config.yaml
# OX_OXIDE[bkzjl_]=${OX_BACKUP}/zellij/layouts

##########################################################
# helix settings
##########################################################

# OX_OXIDE[bkhx]=${OX_BACKUP}/helix/config.toml
# OX_OXIDE[bkhxl]=${OX_BACKUP}/helix/languages.toml

##########################################################
# brew settings
##########################################################

OX_OXIDE[bkb]=${OX_BACKUP}/install/Brewfile

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_CLEANUP_MAX_AGE_DAYS="7"

# brew mirrors for faster download, use `bmr` to use
# declare -A HOMEBREW_MIRROR=(
#     [ts]="mirrors.tuna.tsinghua.edu.cn/git/homebrew"
#     [zk]="mirrors.ustc.edu.cn/git/homebrew"
# )

# predefined brew services
# set the length of key <= 3
declare -A HOMEBREW_SERVICE=(
    [pu]="pueue"
    [pg]="postgresql@15"
    [pd]="podman"
)

##########################################################
# pueue settings
##########################################################

# backup files
OX_OXIDE[bkpu]=${OX_BACKUP}/pueue/pueue.yml
OX_OXIDE[bkpua]=${OX_BACKUP}/pueue/pueue_aliases.yml

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

# # backup files
# OX_OXIDE[bkc]=${OX_BACKUP}/conda/.condarc

# # predefined conda environments
# # set the length of key <= 3
# declare -A OX_CONDA_ENV=(
#     [b]="base"
#     [k]="kaggle"
# )

# # conda env stats with bkce, and should be consistent with OX_CONDA_ENV
# OX_OXIDE[bkceb]=${OX_BACKUP}/conda/conda-base.txt

##########################################################
# rust settings
##########################################################

# if [ ! -d ${OX_BACKUP}/rust ]; then
#     mkdir -p ${OX_BACKUP}/rust
# fi

# OX_OXIDE[bkcg]=${OX_BACKUP}/rust/config.toml
# OX_OXIDE[bkrs]=${OX_BACKUP}/rust/settings.toml

##########################################################
# julia settings
##########################################################

# if [ ! -d ${OX_BACKUP}/julia ]; then
#     mkdir -p ${OX_BACKUP}/julia
# fi

# OX_OXIDE[bkjl]=${OX_BACKUP}/julia/startup.jl
# OX_OXIDE[bkjlx]=${OX_BACKUP}/julia/julia-pkgs.txt

##########################################################
# conan settings
##########################################################

# if [ ! -d ${OX_BACKUP}/conan ]; then
#     mkdir -p ${OX_BACKUP}/conan
# fi

# OX_OXIDE[bkcn]=${OX_BACKUP}/conan/conan.conf
# OX_OXIDE[bkcnr]=${OX_BACKUP}/conan/remotes.json
# OX_OXIDE[bkcnd]=${OX_BACKUP}/conan/profiles/default

##########################################################
# espanso settings
##########################################################

# OX_OXIDE[bkes]=${OX_BACKUP}/espanso/config/default.yml
# OX_OXIDE[bkesx]=${OX_BACKUP}/espanso/match/base.yml
# OX_OXIDE[bkesx_]=${OX_BACKUP}/espanso/match/packages

##########################################################
# vscode settings
##########################################################

# if [ ! -d ${OX_BACKUP}/vscode ]; then
#     mkdir -p ${OX_BACKUP}/vscode
# fi

# # OX_OXIDE[bkvs]=${OX_BACKUP}/vscode/settings.json
# OX_OXIDE[bkvsk]=${OX_BACKUP}/vscode/keybindings.json
# OX_OXIDE[bkvss_]=${OX_BACKUP}/vscode/snippets
# OX_OXIDE[bkvsx]=${OX_BACKUP}/vscode/vscode-exts.txt

##########################################################
# other settings
##########################################################

# nodejs
# OX_OXIDE[bknj]=${OX_BACKUP}/javascript/.npmrc
# OX_OXIDE[bknjx]=${OX_BACKUP}/javascript/node-pkgs.txt
# texlive
# OX_OXIDE[bktl]=${OX_BACKUP}/tex/texlive-pkgs.txt

##########################################################
# common aliases
##########################################################

# alternatives
alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias cat="bat"
alias man="tldr"
alias du="dust"

# shortcuts
alias e="echo"
alias ev="eval"
alias rr="rm -rf"
alias own="sudo chown -R $(whoami)"
alias c="clear"
alias ccc="local HISTSIZE=0 && history -p && reset"

# tools
alias z.="z .."
alias z..="z ../.."
alias zz="z -"
alias hf="hyperfine"

##########################################################
# shell
##########################################################

weather() {
    case $2 in
    -a)
        curl wttr.in/$1
        ;;
    -d)
        curl v2d.wttr.in/$1
        ;;
    -n)
        curl v2n.wttr.in/$1
        ;;
    -g)
        curl v3.wttr.in/$1
        ;;
    -h)
        printf "param 1:\n city: new+york\n airport(codes): muc \n resort: %sEiffel+Tower\n ip address: @github.com\n help: :help\n" \
            "${HOME}" && printf "%s" \
            "param 2:\n a: all\n d/n: day/night\n g: geographical\n f: format\n"
        ;;
    *) curl "v2.wttr.in/$1" ;;
    esac
}

##########################################################
# starship
##########################################################

# case ${SHELL} in
# *zsh)
#     eval "$(starship init zsh)"
#     ;;
# *bash)
#     eval "$(starship init bash)"
#     ;;
# *fish)
#     eval "$(starship init fish)"
#     ;;
# esac

# export STARSHIP_CONFIG="${HOME}/.config/starship.toml"
# OX_ELEMENT[ss]=${STARSHIP_CONFIG}

##########################################################
# weather
##########################################################

# -a: all, -g: geographical, -d: day, -n: night
weather() {
    case $2 in
    -a)
        curl wttr.in/$1
        ;;
    -d)
        curl v2d.wttr.in/$1
        ;;
    -n)
        curl v2d.wttr.in/$1
        ;;
    -g)
        curl v3.wttr.in/$1
        ;;
    -h)
        echo "param 1:\n city: new+york\n airport(codes): muc \n resort: ${HOME}Eiffel+Tower\n ip address: @github.com\n help: :help"
        echo "param 2:\n a: all\n d: day \n n: night\n g: geographical\n f: format"
        ;;
    *)
        curl v2.wttr.in/$1
        ;;
    esac
}

##########################################################
# startup commands
##########################################################

# donwload path: works for function `bdl()`
export OX_DOWNLOAD=${HOME}/Desktop

export OX_STARTUP=1

startup() {
    # start directory
    cd ${HOME}/Desktop
}
