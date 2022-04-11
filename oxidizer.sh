if [[ -z $OXIDIZER ]]; then
    export OXIDIZER=$HOME/oxidizer
fi

##########################################################
# Oxidizer configuration files
##########################################################

declare -A Oxygen
Oxygen[oxal]=$OXIDIZER/defaults/alacritty.yml
Oxygen[oxar]=$OXIDIZER/defaults/aria2.conf
Oxygen[oxox]=$OXIDIZER/demo-custom.sh
# plugins
Oxygen[oxpm]=$OXIDIZER/zsh-plugins/ox-macos.sh
Oxygen[oxpub]=$OXIDIZER/zsh-plugins/ox-ubuntu.sh
Oxygen[oxpb]=$OXIDIZER/zsh-plugins/ox-brew.sh
Oxygen[oxpc]=$OXIDIZER/zsh-plugins/ox-conda.sh
Oxygen[oxpcc]=$OXIDIZER/zsh-plugins/ox-cpp.sh
Oxygen[oxpdk]=$OXIDIZER/zsh-plugins/ox-docker.sh
Oxygen[oxpfm]=$OXIDIZER/zsh-plugins/ox-formats.sh
Oxygen[oxpg]=$OXIDIZER/zsh-plugins/ox-git.sh
Oxygen[oxphx]=$OXIDIZER/zsh-plugins/ox-helix.sh
Oxygen[oxpjl]=$OXIDIZER/zsh-plugins/ox-julia.sh
Oxygen[oxplm]=$OXIDIZER/zsh-plugins/ox-lima.sh
Oxygen[oxpn]=$OXIDIZER/zsh-plugins/ox-node.sh
Oxygen[oxppu]=$OXIDIZER/zsh-plugins/ox-pueue.sh
Oxygen[oxprs]=$OXIDIZER/zsh-plugins/ox-rust.sh
Oxygen[oxptl]=$OXIDIZER/zsh-plugins/ox-texlive.sh
Oxygen[oxpu]=$OXIDIZER/zsh-plugins/ox-utils.sh
Oxygen[oxpvi]=$OXIDIZER/zsh-plugins/ox-vim.sh
Oxygen[oxpvs]=$OXIDIZER/zsh-plugins/ox-vscode.sh
Oxygen[oxpwt]=$OXIDIZER/zsh-plugins/ox-widgets.sh
Oxygen[oxpzj]=$OXIDIZER/zsh-plugins/ox-zellij.sh

##########################################################
# System configuration files
##########################################################

declare -A Element
Element[oxi]=$OXIDIZER/oxidizer.sh
Element[ox]=$OXIDIZER/custom.sh
Element[al]=$HOME/.config/alacritty/alacritty.yml
Element[ar]=$HOME/.aria2/aria2.conf
Element[zs]=$HOME/.zshrc

source $Element[ox]

declare -A Oxide

if [[ ! -d $BACKUP/oxidizer ]]; then
    mkdir -p $BACKUP/oxidizer
fi

Oxide[bkzs]=$BACKUP/shell/.zshrc
Oxide[bkoxi]=$BACKUP/shell/oxidizer.sh
Oxide[bkox]=$BACKUP/shell/custom.sh
Oxide[bkal]=$BACKUP/alacritty.yml
Oxide[bkar]=$BACKUP/aria2.conf

##########################################################
# Aliases
##########################################################

alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat"
alias man="tldr"
alias z.="z .."
alias z..="z ../.."
alias zz="z -"

##########################################################
# Zsh & Plugins
##########################################################

zmodload zsh/zprof
zmodload zsh/mathfunc

# turn case sensitivity off
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

declare -a PLUGINS

# import zsh-brew
source $Oxygen[oxpb]
# import zsh-utils
source $Oxygen[oxpu]
# import zsh-pueue
source $Oxygen[oxppu]

case $(uname -a) in
*Darwin*)
    source $Oxygen[oxpm]
    ;;
*Ubuntu* | *WSL*)
    source $Oxygen[oxpub]
    ;;
esac

for plugin in $PLUGINS[@]; do
    source $Oxygen[$plugin]
done

if [[ ! -d $BACKUP/install ]]; then
    mkdir -p $BACKUP/install
fi

if [[ ! -d $BACKUP/apps ]]; then
    mkdir -p $BACKUP/apps
fi

##########################################################
#  Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
init_all() {
    for obj in $INIT_OBJ[@]; do
        eval init_$obj
    done
}

# update all packages
up_all() {
    for obj in $UP_OBJ[@]; do
        eval up_$obj
    done
}

# backup package lists
back_all() {
    for obj in $BACK_OBJ[@]; do
        eval back_$obj
    done
}

# export configurations
epall() {
    for obj in $EPF_OBJ[@]; do
        epf $obj
    done
}

# import configurations
ipall() {
    for obj in $IPF_OBJ[@]; do
        ipf $obj
    done
}

# initialize Oxidizer
iiox() {
    for obj in $IIF_OBJ[@]; do
        iif $obj
    done
}

# update Oxidizer
upox() {
    z $OXIDIZER
    git fetch origin master
    git reset --hard origin/master
    z -
}

if [[ $STARTUP ]]; then
    eval "$(starship init zsh)"
    eval "$(zoxide init zsh)"
    startup
fi
