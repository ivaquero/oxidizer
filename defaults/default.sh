#!/bin/bash /bin/zsh
##########################################################
# basic settings
##########################################################

export EDITOR='code'
# terminal editor
export EDITOR_T="vi"

##########################################################
# common aliases
##########################################################

# shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias zz="cd -"
alias cat="bat"
# alias ls="lsd"
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
