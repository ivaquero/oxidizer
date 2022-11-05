# conventions
#
# uppercase for global variables
# lowercase for local variables
# titlecase for arrays

##########################################################
# basic settings
##########################################################

# change editor
# $1: name
che() {
    sd "EDITOR=.*" "EDITOR=\"$1\"" $Element[ox]
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
export EDITOR="code"
# terminal editor
export EDITOR_T="vi"

##########################################################
# select ox-plugins
##########################################################

# toolchain specific (highly recommended)
# oxpg: ox-git
#
# language & software-specific
# oxpzp: ox-zap
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
# register proxy ports
##########################################################

declare -A Proxy
# c: clash, v: v2ray
Proxy[c]=7890
Proxy[v]=1080

##########################################################
# select software configuration objects
##########################################################

# options: brew, conda, vscode, espanso
declare -a INIT_OBJ
export INIT_OBJ=(brew)

# options: brew, conda, vscode, espanso, julia, texlive, node
declare -a UP_OBJ
export UP_OBJ=(brew)

declare -a BACK_OBJ
export BACK_OBJ=(brew)

# backup file path
export BACKUP=$HOME/Documents/backup

Oxide[bkox]=$BACKUP/custom.sh
Oxide[bkzs]=$BACKUP/shell/.zshrc
Oxide[bkbs]=$BACKUP/shell/.bash_profile
# Oxide[bkwz]=$BACKUP/terminal/wezterm.lua
# Oxide[bkvi]=$BACKUP/.vimrc

# system file
Element[vi]=$HOME/.vimrc
# Element[al]=$HOME/.config/alacritty/alacritty.yml

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
declare -a EPF_OBJ
EPF_OBJ=(ox)

# files to be import from backup folder
declare -a IPF_OBJ
IPF_OBJ=(ox)

# file to be copied from oxidizer/defaults
declare -a IIF_OBJ
# wz: wezterm
# pu: pueue
# pua: pueue_aliases
IIF_OBJ=(pu pua)

##########################################################
# git settings
##########################################################

# backup files
Oxide[bkg]=$BACKUP/.gitconfig
Oxide[bkgi]=$BACKUP/git/.gitignore

##########################################################
# zellij settings
##########################################################

# if [ ! -d $BACKUP/zellij ]; then
#     mkdir -p $BACKUP/zellij
# fi

# Oxide[bkzj]=$BACKUP/zellij/config.yaml
# Oxide[bkzjl_]=$BACKUP/zellij/layouts

##########################################################
# helix settings
##########################################################

# Oxide[bkhx]=$BACKUP/helix/config.toml
# Oxide[bkhxl]=$BACKUP/helix/languages.toml

##########################################################
# brew settings
##########################################################

export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_ENV_HINTS=true

Oxide[bkb]=$BACKUP/install/Brewfile

# brew mirrors for faster download, use `bmr` to use
# declare -A Brew_Mirror
# Brew_Mirror[ts]="mirrors.tuna.tsinghua.edu.cn/git/homebrew"
# Brew_Mirror[zk]="mirrors.ustc.edu.cn/git/homebrew"

# predefined brew services
# set the length of key <= 3
declare -A Brew_Service
Brew_Service[pu]="pueue"
Brew_Service[mys]="mysql"

##########################################################
# pueue settings
##########################################################

# backup files
Oxide[bkpu]=$BACKUP/pueue/pueue.yml
Oxide[bkpua]=$BACKUP/pueue/pueue_aliases.yml

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
# Oxide[bkc]=$BACKUP/conda/.condarc

# # predefined conda environments
# # set the length of key <= 3
# declare -A Conda_Env

# Conda_Env[b]="base"

# # conda env stats with bkce, and should be consistent with Conda_Env
# Oxide[bkceb]=$BACKUP/conda/conda-base.txt

##########################################################
# rust settings
##########################################################

# if [ ! -d $BACKUP/rust ]; then
#     mkdir -p $BACKUP/rust
# fi

# Oxide[bkcg]=$BACKUP/rust/env.sh
# Oxide[bkcg_]=$BACKUP/rust

# rust mirrors for faster download, use `rsmr` to use
# declare -A Rust_Mirror
# Rust_Mirror[ts]="mirrors.tuna.tsinghua.edu.cn"
# Rust_Mirror[zk]="mirrors.ustc.edu.cn"

##########################################################
# espanso settings
##########################################################

# Oxide[bkes]=$BACKUP/espanso/config/default.yml
# Oxide[bkesm]=$BACKUP/espanso/match/base.yml
# Oxide[bkesx]=$BACKUP/install/espanso-pkgs.txt

##########################################################
# julia settings
##########################################################

# if [ ! -d $BACKUP/julia ]; then
#     mkdir -p $BACKUP/julia
# fi

# Oxide[bkjl]=$BACKUP/julia/julia-pkgs.txt
# Oxide[bkjls]=$BACKUP/julia/startup.jl

##########################################################
# vscode settings
##########################################################

# if [ ! -d $BACKUP/vscode ]; then
#     mkdir -p $BACKUP/vscode
# fi

# # Oxide[bkvs]=$BACKUP/vscode/settings.json
# Oxide[bkvsk]=$BACKUP/vscode/keybindings.json
# Oxide[bkvss_]=$BACKUP/vscode/snippets
# Oxide[bkvsx]=$BACKUP/vscode/vscode-exts.txt

##########################################################
# podman settings
##########################################################

##########################################################
# other settings
##########################################################

# # conan
# Oxide[bkcn]=$BACKUP/conan/default
# Oxide[bkcnr]=$BACKUP/conan/remote.json
# # nodejs
# Oxide[bknj]=$BACKUP/javascript/node-pkgs.txt
# # texlive
# Oxide[bktl]=$BACKUP/tex/texlive-pkgs.txt

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
export DOWNLOAD=$HOME/Download

export STARTUP=1

startup() {
    # start directory
    cd $HOME
}
