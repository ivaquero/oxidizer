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
    sd "EDITOR=\'.*\'" "EDITOR=\'$1\'" $Element[ox]
    case $SHELL in
    *zsh)
        . ${Element[zs]}
        ;;
    *bash)
        . ${Element[bs]}
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
# oxpcc: ox-cpp
# oxpdk: ox-docker
# oxpes: ox-espanso
# oxphx: ox-helix
# oxpjl: ox-julia
# oxpjn: ox-jupyter
# oxpnj: ox-node
# oxppd: ox-podman
# oxprb: ox-ruby
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
# oxpzj: ox-zellij
#
# other-shortcuts
# oxpfm: ox-formats
# oxpbw: ox-bitwarden
PLUGINS=(
    oxpg
    oxpfm
)

##########################################################
# select software configuration objects
##########################################################

# options: brew, conda, vscode, espanso
declare -a OX_INIT_PROG
export OX_INIT_PROG=(brew)

# options: brew, conda, vscode, espanso, julia, texlive, node
declare -a OX_UPDATE_PROG
export OX_UPDATE_PROG=(brew)

declare -a OX_BACKUP_PROG
export OX_BACKUP_PROG=(brew)

# backup file path
export BACKUP=$HOME/Documents/backup

OX_OXIDE[bkox]=$BACKUP/custom.sh
OX_OXIDE[bkzs]=$BACKUP/shell/.zshrc
OX_OXIDE[bkbs]=$BACKUP/shell/.bash_profile
OX_OXIDE[bksc]=$BACKUP/install/source.list
# OX_OXIDE[bkwz]=$BACKUP/terminal/wezterm.lua
# OX_OXIDE[bkvi]=$BACKUP/.vimrc

# system file
Element[vi]=$HOME/.vimrc
# Element[al]=$HOME/.config/alacritty/alacritty.yml

##########################################################
# register proxy ports
##########################################################

declare -A OX_PROXY
# c: clash, v: v2ray
OX_PROXY[c]=7890
OX_PROXY[v]=1080

Element[cv]="$HOME/.config/clash-verge/verge.yaml"
OX_OXIDE[bkcv]="$BACKUP/app/verge.yaml"

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

# file to be copied from oxidizer/defaults
declare -a OX_INIT_FILE
# wz: wezterm
# pu: pueue
# pua: pueue_aliases
OX_INIT_FILE=(pu pua)

##########################################################
# git settings
##########################################################

# backup files
OX_OXIDE[bkg]=$BACKUP/.gitconfig
OX_OXIDE[bkgi]=$BACKUP/git/.gitignore

##########################################################
# zellij settings
##########################################################

# if [ ! -d $BACKUP/zellij ]; then
#     mkdir -p $BACKUP/zellij
# fi

# OX_OXIDE[bkzj]=$BACKUP/zellij/config.yaml
# OX_OXIDE[bkzjl_]=$BACKUP/zellij/layouts

##########################################################
# helix settings
##########################################################

# OX_OXIDE[bkhx]=$BACKUP/helix/config.toml
# OX_OXIDE[bkhxl]=$BACKUP/helix/languages.toml

##########################################################
# brew settings
##########################################################

export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_ENV_HINTS=true

OX_OXIDE[bkb]=$BACKUP/install/Brewfile

# brew mirrors for faster download, use `bmr` to use
# declare -A homebrew_mirror
# homebrew_mirror[ts]="mirrors.tuna.tsinghua.edu.cn/git/homebrew"
# homebrew_mirror[zk]="mirrors.ustc.edu.cn/git/homebrew"

# predefined brew services
# set the length of key <= 3
declare -A homebrew_service

homebrew_service[pu]="pueue"
homebrew_service[mys]="mysql"

##########################################################
# pueue settings
##########################################################

# backup files
OX_OXIDE[bkpu]=$BACKUP/pueue/pueue.yml
OX_OXIDE[bkpua]=$BACKUP/pueue/pueue_aliases.yml

# pueue demo
upp() {
    pueue group add up_all
    pueue parallel 3 -g up_all
    pueue add -g up_all 'brew update && brew upgrade'
    pueue add -g up_all 'conda update --all --yes'
    pueue add -g up_all 'tlmgr update --all'
    # or use predefined items in pueue_aliase
    # pueue add -g up_all 'tlup'
}

##########################################################
# conda settings
##########################################################

# # backup files
# OX_OXIDE[bkc]=$BACKUP/conda/.condarc

# # predefined conda environments
# # set the length of key <= 3
# declare -A Conda_Env

# Conda_Env[b]="base"

# # conda env stats with bkce, and should be consistent with Conda_Env
# OX_OXIDE[bkceb]=$BACKUP/conda/conda-base.txt

##########################################################
# rust settings
##########################################################

# if [ ! -d $BACKUP/rust ]; then
#     mkdir -p $BACKUP/rust
# fi

# OX_OXIDE[bkcg]=$BACKUP/rust/config.toml
# OX_OXIDE[bkrs]=$BACKUP/rust/settings.toml

##########################################################
# espanso settings
##########################################################

# OX_OXIDE[bkes]=$BACKUP/espanso/config/default.yml
# OX_OXIDE[bkesx]=$BACKUP/espanso/match/base.yml
# OX_OXIDE[bkesx_]=$BACKUP/espanso/match/packages

##########################################################
# julia settings
##########################################################

# if [ ! -d $BACKUP/julia ]; then
#     mkdir -p $BACKUP/julia
# fi

# OX_OXIDE[bkjl]=$BACKUP/julia/julia-pkgs.txt
# OX_OXIDE[bkjls]=$BACKUP/julia/startup.jl

##########################################################
# vscode settings
##########################################################

# if [ ! -d $BACKUP/vscode ]; then
#     mkdir -p $BACKUP/vscode
# fi

# # OX_OXIDE[bkvs]=$BACKUP/vscode/settings.json
# OX_OXIDE[bkvsk]=$BACKUP/vscode/keybindings.json
# OX_OXIDE[bkvss_]=$BACKUP/vscode/snippets
# OX_OXIDE[bkvsx]=$BACKUP/vscode/vscode-exts.txt

##########################################################
# podman settings
##########################################################

##########################################################
# other settings
##########################################################

# # conan
# OX_OXIDE[bkcn]=$BACKUP/conan/default
# OX_OXIDE[bkcnr]=$BACKUP/conan/remote.json
# # nodejs
# OX_OXIDE[bknj]=$BACKUP/javascript/node-pkgs.txt
# # texlive
# OX_OXIDE[bktl]=$BACKUP/tex/texlive-pkgs.txt

##########################################################
# common aliases
##########################################################

# alternatives
alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
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

case $SHELL in
*zsh)
    # turn case sensitivity off
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

    # global
    alias -g w0="| rg '\s0\.\d+'"

    # test
    alias tt="hyperfine --warmup 3 --shell zsh 'source ~/.zshrc'"
    ;;
*bash)
    # turn case sensitivity off
    if [ ! -e ~/.inputrc ]; then
        echo '$include /etc/inputrc' >~/.inputrc
    fi
    echo 'set completion-ignore-case On' >>~/.inputrc

    # test
    alias tt="hyperfine --warmup 3 --shell bash 'source ~/.bash_profile'"
    ;;
esac

##########################################################
# starship
##########################################################

# case $SHELL in
# *zsh)
#     eval "$(starship init zsh)"
#     ;;
# *bash)
#     eval "$(starship init bash)"
#     ;;
# esac

# export STARSHIP_CONFIG=$HOME/.config/starship.toml
# Element[ss]=$STARSHIP_CONFIG

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
        echo "param 1:\n city: new+york\n airport(codes): muc \n resort: ~Eiffel+Tower\n ip address: @github.com\n help: :help"
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
export OX_DOWNLOAD=$HOME/Download

export OX_STARTUP=1

startup() {
    # start directory
    cd $HOME
}
