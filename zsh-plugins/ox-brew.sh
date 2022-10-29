##########################################################
# source
##########################################################

# source system-specific commands
if [ $(uname -s) = "Darwin" ]; then
    if [ $(uname -m) = "arm64" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    fi
    export APP=$(brew --caskroom)
    export APPDATA=$HOME/Library/'Application Support'
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export APP=$HOME
    export APPDATA=$HOME/.config
fi

export BREW=$(brew --prefix)
export BREW_DL=$(brew --cache)/downloads

case $SHELL in
*zsh)
    if type brew &>/dev/null; then
        FPATH=$BREW/share/zsh-completions:$FPATH
        autoload -Uz compinit && compinit
    fi

    [ -d "$BREW/share/zsh-syntax-highlighting" ] && . "$BREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    [ -d "$BREW/share/zsh-autosuggestions" ] && . "$BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ;;
*bash)
    [ -r "$BREW/etc/profile.d/bash_completion.sh" ] && . "$BREW/etc/profile.d/bash_completion.sh"
    ;;
esac

##########################################################
# config
##########################################################

init_brew() {
    echo "Initialize Brew by Oxidizer configuration"
    brew bundle --file ${Oxygen[oxpb]}
}

up_brew() {
    echo "Update Brew by self-defined configuration"
    brew bundle --file ${Oxide[bkb]}
}

back_brew() {
    echo "Backup Brew to ${Oxide[bkb]}"
    brew bundle dump --force
}

clean_brew() {
    echo "Clean Brew by $HOMEBREW_BUNDLE_FILE"
    brew bundle cleanup
}

##########################################################
# packages
##########################################################

alias bh="brew help"
alias bcf="brew config"
alias bis="brew install"
alias bris="brew reinstall"
alias bups="brew update"
alias bup="brew upgrade"

bus() {
    brew uninstall $@
    brew autoremove
}

bisp() {
    local n_args=$#
    if [[ $n_args > 1 ]]; then
        echo "Trying to install $n_args pkgs in parallel"
        pueue group add brew_install
        pueue parallel $n_args -g brew_install

        for pkg in $@; do
            pueue add -g brew_install "brew install $pkg"
        done
        sleep 3 && pueue status
    else
        brew install $1
    fi
}

bupp() {
    local n_args=$#
    if [[ $n_args == 0 ]]; then
        local pkgs=$(brew outdated)
        local num=$(echo $pkgs | wc -l | sd " " "")
        if [[ $num == 0 ]]; then
            echo "No outdated packages"
        elif [[ $num == 1 ]]; then
            brew upgrade $pkgs
        else
            echo "Trying to update $num pkgs in parallel"
            pueue group add brew_upgrade
            pueue parallel $num -g brew_upgrade

            echo $pkgs | while read line; do
                pueue add -g brew_upgrade "brew upgrade $line"
            done
            sleep 3 && pueue status
        fi
    elif [[ $n_args == 1 ]]; then
        brew upgrade $1
    else
        echo "Trying to update $n_args pkgs in parallel"
        pueue group add brew_upgrade
        pueue parallel $n_args -g brew_upgrade

        for pkg in $@; do
            pueue add -g brew_upgrade "brew upgrade $pkg"
        done
        sleep 3 && pueue status
    fi
}

alias bls="brew list"
alias blsf="brew list --formula"
alias blv="brew leaves"
alias bsc="brew search"
alias bdp="brew deps --tree --formula --installed"
alias bcl="brew autoremove && brew cleanup"
alias bck="brew doctor"
alias bln="brew link"
alias buln="brew unlink"

# info & version
alias bif="brew info --json=v2"
alias bst="brew outdated"
alias bsta="brew outdated --greedy"
alias bpn="brew pin"
alias bupn="brew unpin"

##########################################################
# extension
##########################################################

alias bxa="brew tap"
alias bxrm="brew untap"

##########################################################
# project
##########################################################

alias bii="brew create"
alias bts="brew test"
alias be="brew edit"

##########################################################
# mirrors
##########################################################

bmr() {
    export HOMEBREW_BREW_GIT_REMOTE="https://${Brew_Mirror[$1]}/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://${Brew_Mirror[$1]}/homebrew-core.git"

    for tap in core bottles services cask{,-fonts} command-not-found; do
        brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://${Brew_Mirror[$1]}/homebrew-${tap}.git"
    done
    brew update
}

bmrq() {
    unset HOMEBREW_BREW_GIT_REMOTE
    git -C "$(brew --repo)" remote set-url origin https://github.com/Brew/brew

    unset HOMEBREW_CORE_GIT_REMOTE
    BREW_TAPS="$(
        BREW_TAPS="$(brew tap 2>/dev/null)"
        echo -n "${BREW_TAPS//$'\n'/:}"
    )"

    for tap in core bottles services cask{,-fonts} command-not-found; do
        if [[ ":${BREW_TAPS}:" == *":homebrew/${tap}:"* ]]; then
            brew tap --custom-remote "homebrew/${tap}" "https://github.com/Brew/homebrew-${tap}"
        fi
    done
    brew update
}

##########################################################
# bundle
##########################################################

# oxidizer files
Oxygen[oxb]=$OXIDIZER/defaults/Brewfile
# backup files
export HOMEBREW_BUNDLE_FILE=${Oxide[bkb]}

alias bb="brew bundle"

##########################################################
# casks
##########################################################

alias bisc="bis --cask --no-quarantine"
alias busc="bus --cask"
alias brisc="bris --cask --no-quarantine"
alias bupc="bup --cask --no-quarantine"

bupa() {
    local pkgs=$(brew outdated | sd "\n" " ")
    local casks=$(brew outdated --greedy-auto-updates | sd "\n" " ")
    eval "brew upgrade $pkgs"
    eval "brew upgrade $casks"
}

biscp() {
    local n_args=$#
    if [[ $n_args > 1 ]]; then
        echo "Trying to install $n_args casks in parallel"
        pueue group add brew_install
        pueue parallel $n_args -g brew_install

        for pkg in $@; do
            pueue add -g brew_install "brew install --cask $pkg"
        done
        sleep 3 && pueue status
    else
        brew install --cask $1
    fi
}

bupap() {
    local pkgs=$(brew outdated --greedy-auto-updates)
    local num=$(echo $pkgs | wc -l | sd " " "")

    if [[ $num > 1 ]]; then
        echo "Trying to update $num pkgs in parallel"
        pueue group add brew_upgrade_greedy
        pueue parallel $num -g brew_upgrade_greedy

        echo $pkgs | while read line; do
            echo "upgrade $line"
            pueue add -g brew_upgrade_greedy "brew upgrade $line"
        done

        sleep 3 && pueue status
    else
        brew upgrade $pkgs
    fi
}

alias blsc="bls --cask"
alias bifc="bif --cask"
alias bec="be --cask"

##########################################################
# cask downloading
##########################################################

# download by aria2
bdl() {
    local url=$(brew info --cask --json=v2 $1 | rg \"url\" | rg --only-matching \"https:.+\" -m 1)
    echo "downloading from $url to $DOWNLOAD"
    eval $(aria2c --dir $DOWNLOAD $url)
}

# replace cache file by predownloaded file
brp() {
    local f_pred=$(ls $DOWNLOAD | rg --ignore-case $1)
    if [ -z $f_pred ]; then
        echo "predownloaded file not found"
        return 1
    fi
    local f_cache=$(ls $BREW_DL/*.incomplete | rg --ignore-case $1 | sd ".incomplete" "")
    mv $DOWNLOAD/$f_pred $f_cache
}

##########################################################
# brew services
##########################################################

alias bs="brew services"
alias bsh="brew services --help"
alias bsr="brew services run"
alias bscl="brew services cleanup"
alias bsif="brew services info"
alias bsls="brew services list"

bss() {
    if [[ ${#1} < 4 ]]; then
        brew services start ${Brew_Service[$1]}
    else
        brew services start $1
    fi
}

bsq() {
    if [[ ${#1} < 4 ]]; then
        brew services stop ${Brew_Service[$1]}
    else
        brew services stop $1
    fi
}

bsrs() {
    if [[ ${#1} < 4 ]]; then
        brew services restart ${Brew_Service[$1]}
    else
        brew services restart $1
    fi
}
