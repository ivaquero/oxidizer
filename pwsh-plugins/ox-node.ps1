##########################################################
# config
##########################################################

function up_node {
    Write-Output "Update Node by $($Global:Oxide.bknj)"
    $pkgs = (cat $Global:Oxide.bknj | sd "`n" ' ')
    Write-Output "Installing $pkgs"
    Invoke-Expression "npm install -g $pkgs --force"
}

function back_node {
    Write-Output "Backup Node to $($Global:Oxide.bknj)"
    $pkgs = $(npm list --depth 0 -g | rg --multiline --only-matching '[\s][@a-z].*[a-z]')
    $pkgs.Replace(' ', '').Replace('npm ', '') | sd "`n" ' ' | Out-File -FilePath "$($Global:Oxide.bknj)"
}

##########################################################
# packages
##########################################################

function nh { npm help }
function ncf { npm config $args }
function nis { npm install $args }
function nus { npm uninstall $args }
function nisg { npm install -g $args }
function nusg { npm uninstall -g $args }
function nup { npm update }
function nupg { npm update -g }
function nst { npm outdated }
function nls { npm list }
function nlsg { npm list -g }
function nlv { npm list --depth 0 }
function nlvg { npm list --depth 0 -g }
function nck { npm doctor }
function nsc { npm search }
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
function npb { npm publish $args }

##########################################################
# node
##########################################################

function nj {
    if ([string]::IsNullOrEmpty($args)) { node }
    else { node $args }
}
