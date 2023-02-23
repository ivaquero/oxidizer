##########################################################
# config
##########################################################

# config files
$Global:OX_ELEMENT.nj = "$HOME/.npmrc"

function up_node {
    echo "Update Node by $($Global:OX_OXIDE.bknjx)"
    $pkgs = (cat $($Global:OX_OXIDE.bknjx) | sd "`n" ' ')
    echo "Installing $pkgs"
    Invoke-Expression "npm install -g $pkgs --force"
}

function back_node {
    echo "Backup Node to $($Global:OX_OXIDE.bknjx)"
    $pkgs = $(npm list --depth 0 -g | rg --multiline --only-matching '[\s][@a-z].*[a-z]')
    $pkgs.Replace(' ', '').Replace('npm ', '') | sd "`n" ' ' > "$($Global:OX_OXIDE.bknjx)"
}

##########################################################
# packages
##########################################################

function nh { npm help $args }
function ncf { npm config $args }
function nis { npm install $args }
function nus { npm uninstall $args }
function nisg { npm install -g $args }
function nusg { npm uninstall -g $args }
function nup { npm update $args }
function nupg { npm update -g $args }
function nst { npm outdated }
function nls { npm list $args }
function nlsg { npm list -g $args }
function nlv { npm list --depth 0 }
function nlvg { npm list --depth 0 -g }
function nck { npm doctor }
function nsc { npm search $args }
function ncl { npm cache clean -f }
function nif { npm info }

function nfx {
    if ([string]::IsNullOrEmpty($args)) { npm audit fix --force }
    else { npm audit fix $args }
}

##########################################################
# project
##########################################################

function nii { npm init $args }
function nr { npm run $args }
function nts { npm test $args }
function nau { npm audit $args }
function nfx { npm audit fix $args }
function npb { npm publish $args }

##########################################################
# node
##########################################################

function nj {
    if ([string]::IsNullOrEmpty($args)) { node }
    else { node $args }
}
