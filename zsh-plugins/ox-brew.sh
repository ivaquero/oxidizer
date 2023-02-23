##########################################################
# source
##########################################################

# source system-specific commands
if [[ $(uname -s) = "Darwin" ]]; then
    if [[ $(uname -m) = "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    fi
    export APPDATA=${HOME}/Library/'Application Support'
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_DOWNLOAD=$(brew --cache)/downloads

case ${SHELL} in
*zsh)
    if type brew &>/dev/null; then
        FPATH=${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}
        autoload -Uz compinit && compinit
        FPATH=${HOMEBREW_PREFIX}/share/zsh-completions:${FPATH}
        autoload -Uz compinit && compinit
    fi
    [[ -d "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting" ]] && . "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    [[ -d "${HOMEBREW_PREFIX}/share/zsh-autosuggestions" ]] && . "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ;;
*bash)
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
            [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
    fi
    ;;
*fish)
    [[ -d "${HOMEBREW_PREFIX}/share/fish/completions" ]] &&
        set -gx fish_complete_path $fish_complete_path ${HOMEBREW_PREFIX}/share/fish/completions
    [[ -d "${HOMEBREW_PREFIX}/share/fish/vendor_completions.d" ]] &&
        set -gx fish_complete_path $fish_complete_path ${HOMEBREW_PREFIX}/share/fish/vendor_completions.d
    ;;
esac

##########################################################
# config
##########################################################

init_brew() {
    echo "Initialize Brew by Oxidizer configuration"
    local pkgs=$(cat ${OXIDIZER}/defaults/Brewfile.txt | sd "\n" "")
    brew install $pkgs
}

up_brew() {
    echo "Update Brew by ${OX_OXIDE[bkb]}"
    brew bundle --file ${OX_OXIDE[bkb]}
}

back_brew() {
    echo "Backup Brew to ${OX_OXIDE[bkb]}"
    brew bundle dump --force
}

clean_brew() {
    echo "Clean Brew by ${HOMEBREW_BUNDLE_FILE}"
    brew bundle cleanup
}

##########################################################
# packages
##########################################################

alias bh="brew help"
alias bcf="brew config"
alias bis="brew install --no-quarantine"
alias bris="brew reinstall --no-quarantine"
alias bups="brew update"
alias bup="brew upgrade --no-quarantine"

bus() {
    case $1 in
    -a) brew uninstall --zap ${@:1} ;;
    *) brew uninstall $@ ;;
    esac
}

bisp() {
    local n_args=$#
    if [[ $n_args > 1 ]]; then
        echo "Trying to install $n_args pkgs in parallel"
        pueue group add brew_install
        pueue parallel $n_args -g brew_install

        for pkg in $@; do
            pueue add -g brew_install "brew install $pkg --no-quarantine"
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
                pueue add -g brew_upgrade "brew upgrade $line --no-quarantine"
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
            pueue add -g brew_upgrade "brew upgrade $pkg --no-quarantine"
        done
        sleep 3 && pueue status
    fi
}

alias bls="brew list"
alias blsf="brew list --formula"
alias blv="brew leaves"
alias bsc="brew search"
alias bdp="brew deps --tree --formula --installed"
alias bck="brew doctor"

bcl() {
    case $1 in
    -a) brew autoremove && brew cleanup -s --prune=all ;;
    *) brew autoremove && brew cleanup -s ;;
    esac
}

# info & version
alias bif="brew info"
alias bpn="brew pin"
alias bupn="brew unpin"

bst() {
    case $1 in
    -r) brew livecheck $2 ;;
    -rc) brew livecheck --cask $2 ;;
    -g) brew outdated --greedy ;;
    *) brew outdated ;;
    esac
}

##########################################################
# project
##########################################################

alias bii="brew create"
alias bts="brew test"
alias bed="brew edit"
alias bedc="brew edit --cask"
alias bca="brew cat"
alias bau="brew audit"
alias bfx="brew style --fix"
alias bln="brew link"
alias buln="brew unlink"

##########################################################
# extension
##########################################################

alias bxa="brew tap"
alias bxrm="brew untap"

##########################################################
# mirrors
##########################################################

bmr() {
    export HOMEBREW_BREW_GIT_REMOTE="https://${HOMEBREW_MIRROR[$1]}/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://${HOMEBREW_MIRROR[$1]}/homebrew-core.git"

    for tap in core bottles services cask{,-fonts} command-not-found; do
        brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://${HOMEBREW_MIRROR[$1]}/homebrew-${tap}.git"
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

# backup files
export HOMEBREW_BUNDLE_FILE=${OX_OXIDE[bkb]}

##########################################################
# casks
##########################################################

alias bisc="bis --cask --no-quarantine"
alias busc="bus --cask"
alias brisc="bris --cask --no-quarantine"
alias bupc="bup --cask"

bupg() {
    local pkgs=$(brew outdated | sd "\n" " ")
    local casks=$(brew outdated --greedy-auto-updates | sd "\n" " ")
    eval "brew upgrade $pkgs"
    eval "brew upgrade $casks --no-quarantine"
}

biscp() {
    local n_args=$#
    if [[ $n_args > 1 ]]; then
        echo "Trying to install $n_args casks in parallel"
        pueue group add brew_install
        pueue parallel $n_args -g brew_install

        for pkg in $@; do
            pueue add -g brew_install "brew install --cask $pkg --no-quarantine"
        done
        sleep 3 && pueue status
    else
        brew install --cask $1 --no-quarantine
    fi
}

bupgp() {
    local pkgs=$(brew outdated --greedy-auto-updates)
    local num=$(echo $pkgs | wc -l | sd " " "")

    if [[ $num > 1 ]]; then
        echo "Trying to update $num pkgs in parallel"
        pueue group add brew_upgrade_greedy
        pueue parallel $num -g brew_upgrade_greedy

        echo $pkgs | while read line; do
            echo "upgrade $line"
            pueue add -g brew_upgrade_greedy "brew upgrade $line --no-quarantine"
        done

        sleep 3 && pueue status
    else
        brew upgrade $pkgs
    fi
}

alias blsc="bls --cask"
alias bifc="bif --cask"
alias bedc="be --cask"

##########################################################
# cask downloading
##########################################################

# download by aria2
bdl() {
    local url=$(brew info --cask --json=v2 $1 | rg \"url\" | rg --only-matching \"https:.+\" -m 1)
    echo "downloading from $url to ${OX_DOWNLOAD}"
    eval $(aria2c --dir ${OX_DOWNLOAD} $url)
}

# replace cache file by predownloaded file
brp() {
    local f_pred=$(ls ${OX_DOWNLOAD} | rg --ignore-case $1)
    if [[ -z $f_pred ]]; then
        echo "predownloaded file not found"
        return 1
    fi
    local f_cache=$(ls ${HOMEBREW_DOWNLOAD}/*.incomplete | rg --ignore-case $1 | sd ".incomplete" "")
    mv ${OX_DOWNLOAD}/$f_pred $f_cache
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
        brew services start ${HOMEBREW_SERVICE[$1]}
    else
        brew services start $1
    fi
}

bsq() {
    if [[ ${#1} < 4 ]]; then
        brew services stop ${HOMEBREW_SERVICE[$1]}
    else
        brew services stop $1
    fi
}

bsrs() {
    if [[ ${#1} < 4 ]]; then
        brew services restart ${HOMEBREW_SERVICE[$1]}
    else
        brew services restart $1
    fi
}
