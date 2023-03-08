##########################################################
# conventions
##########################################################

# uppercase for global variables
# lowercase for local variables

##########################################################
# basic settings
##########################################################

# default editor, can be changed by function `che()`
export EDITOR='code'
# terminal editor
export EDITOR_T='vi'

##########################################################
# select ox-plugins
##########################################################

# oxpg: ox-git
# oxpc: ox-conda
# oxpcn: ox-conan
# oxpfm: ox-format
# oxphx: ox-helix
# oxpjl: ox-julia
# oxpnj: ox-nodejs
# oxprs: ox-rust
# oxpzj: ox-zellij
# oxpbw: ox-bitwarden
# oxpct: ox-container
# oxpes: ox-espanso
# oxpjn: ox-jupyter
# oxptl: ox-texlive
# oxpvs: ox-vscode

OX_PLUGINS=(
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

# shell backups
OX_OXIDE[bkox]=${OX_BACKUP}/shell/custom.sh
# OX_OXIDE[bkvi]=${OX_BACKUP}/shell/.vimrc

# terminal

# OX_OXIDE[bkwz]=${OX_BACKUP}/terminal/wezterm.lua
# OX_OXIDE[bkal]=${OX_BACKUP}/terminal/alacritty.yml

# system file
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
# brew settings
##########################################################

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
# vscode settings
##########################################################

# # OX_OXIDE[bkvs]=${OX_BACKUP}/vscode/settings.json

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
# startup commands
##########################################################

# donwload path: works for function `bdl()`
export OX_DOWNLOAD=${HOME}/Desktop

export OX_STARTUP=1

startup() {
    # start directory
    cd ${HOME}/Desktop
}
