##########################################################
# config
##########################################################

# config files
OX_ELEMENT[nj]=${HOME}/.npmrc

export NODE_EXTRA_CA_CERTS="${HOMEBREW_PREFIX}/share/ca-certificates/cacert.pem"

up_node() {
    echo "Update Node by ${OX_OXIDE[bknjx]}"
    local pkgs=$(cat ${OX_OXIDE[bknjx]} | sd "\n" " ")
    echo "Installing $pkgs"
    eval "npm install -g $pkgs --force"
}

back_node() {
    echo "Backup Node to ${OX_OXIDE[bknjx]}"
    npm list --depth 0 -g | rg --multiline --only-matching "[\s][@a-z].*[a-z]" | sd " " "" | sd "npm " "" | sd "\n" " " >${OX_OXIDE[bknjx]}
}

##########################################################
# packages
##########################################################

alias nh="npm help"
alias ncf="npm config"
alias nis="npm install"
alias nus="npm uninstall"
alias nisg="npm install -g"
alias nusg="npm uninstall -g"
alias nup="npm update"
alias nupg="npm update -g"
alias nst="npm outdated"
alias nls="npm list"
alias nlsg="npm list -g"
alias nlv="npm list --depth 0"
alias nlvg="npm list --depth 0 -g"
alias nck="npm doctor"
alias nsc="npm search"
alias ncl="npm cache clean -f"
alias nif="npm info"

##########################################################
# project
##########################################################

alias nii="npm init"
alias nr="npm run"
alias nts="npm test"
alias nau="npm audit"
alias nfx="npm audit fix"
alias npb="npm publish"

##########################################################
# node
##########################################################

alias nj="node"
