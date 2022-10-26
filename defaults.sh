# conventions
#
# uppercase for global variables
# lowercase for local variables
# titlecase for arrays

##########################################################
# basic settings
##########################################################

# donwload path: works for function `bdl()` that use aria2 to donwload brew casks
export DOWNLOAD=$HOME/Documents
# backup folder
export BACKUP=$DOWNLOAD/backup

# default editor, can be changed by function `ched()`
export EDITOR=code
# terminal editor
export EDITOR_T=vi

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
# oxprb: ox-ruby
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
# oxplm: ox-lima
# oxpf: ox-flatpak
# oxpzj: ox-zellij
#
# other-shortcuts
# oxpfm: ox-formats
# oxpwg: ox-widgets
# oxpbw: ox-bitwarden
PLUGINS=(oxpg oxpc oxpvs oxpfm)

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

# options: brew, conda, julia, node, texlive, vscode, espanso
declare -a INIT_OBJ
export INIT_OBJ=(brew)

declare -a BACK_OBJ
export BACK_OBJ=(brew)

declare -a UP_OBJ
export UP_OBJ=(brew)

# backup file path
Oxide[bkb]=$BACKUP/install/Brewfile
Oxide[bkzs]=$BACKUP/shell/.zshrc
Oxide[bkbs]=$BACKUP/shell/.bash_profile
Oxide[bkox]=$BACKUP/shell/custom.sh
# Oxide[bkwz]=$BACKUP/wezterm.lua
# Oxide[bkvi]=$BACKUP/.vimrc
# Oxide[bkar]=$BACKUP/aria2.conf

##########################################################
# select export and import configurations
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
EPF_OBJ=(ox ar oxp zj)

# files to be import from backup folder
declare -a IPF_OBJ
# IPF_OBJ=(ox ar oxp zj)

# file to be copied from oxidizer/defaults
declare -a IIF_OBJ
# wz: wezterm
# ar: aria2
# pu: pueue
# pua: pueue_aliases
IIF_OBJ=(ar)
# IIF_OBJ=(ar wz)

##########################################################
# brew configurations
##########################################################

export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_ENV_HINTS=true

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
# register conda environments
##########################################################

# predefined conda environments
# set the length of key <= 3
declare -A Conda_Env
Conda_Env[b]="base"
# conda env stats with bkce, and should be consistent with Conda_Env
# Oxide[bkceb]=$BACKUP/conda/conda-base.txt

##########################################################
# rust configurations
##########################################################

# rust mirrors for faster download, use `rsmr` to use
# declare -A Rust_Mirror
# Rust_Mirror[ts]="mirrors.tuna.tsinghua.edu.cn"
# Rust_Mirror[zk]="mirrors.ustc.edu.cn"

##########################################################
# lima configurations
##########################################################

# # predefined lima instances
# # set the length of key <= 3
# declare -A Lima
# Lima[ub]="ubuntu"
# Lima[ar]="archlinux"

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
alias ar="aria2c --dir $DOWNLOAD"

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
# startup commands
##########################################################

export STARTUP=1

startup() {
    # start directory
    cd $HOME
}