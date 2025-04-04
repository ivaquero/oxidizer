#!/bin/bash /bin/zsh
##########################################################
# basic settings
##########################################################

# shellcheck disable=SC2155
export GPG_TTY=$(tty)

export EDITOR='code'
# terminal editor
export EDITOR_T="vi"

# backup file path
export OX_BACKUP="${HOME}"/backup

##########################################################
# brew settings
##########################################################

case $(uname -a) in
*Darwin* | *Ubuntu* | *Debian*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_AUTOREMOVE=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_CLEANUP_MAX_AGE_DAYS="3"
    ;;
esac

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
alias rr="rm -r"
alias c="clear"
# shellcheck disable=SC2139
alias own="sudo chown -R $(whoami)"

# tools
alias man="tldr"
alias hf="hyperfine"
alias tk="tokei"
alias ff="fastfetch"
alias g="git"
# alias npm="pnpm"
alias p="ipython"

# oxidizer
# export config
alias epf="oxf"
# import config
alias ipf="rdf"
# initialize config
alias iif="clzf"

# personal
alias -g wl="| wc -l"

# others
show_port() {
    lsof -i tcp:"$1"
}

##########################################################
# startup
##########################################################

# installer downloaded path: works for function `brp()`
# use `which brp` to check `brp()` in details
export OX_DOWNLOAD="${HOME}"/Documents
export OX_STARTUP=1

startup() {
    # clear
    cd "${HOME}"/Documents || exit
}
