if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

##########################################################
# Oxidizer configuration files
##########################################################

$Global:OX_OXYGEN = @{}
# defaults
$Global:OX_OXYGEN.oxd = "$env:OXIDIZER\defaults.ps1"
$Global:OX_OXYGEN.oxz = "$env:OXIDIZER\oxidizer.ps1"
$Global:OX_OXYGEN.oxwz = "$env:OXIDIZER\defaults\wezterm.lua"
# plugins
$Global:OX_OXYGEN.oxps = "$env:OXIDIZER\plugins\ox-scoop.ps1"
$Global:OX_OXYGEN.oxpw = "$env:OXIDIZER\plugins\ox-windows.ps1"
$Global:OX_OXYGEN.oxpg = "$env:OXIDIZER\plugins\ox-git.ps1"
$Global:OX_OXYGEN.oxpc = "$env:OXIDIZER\plugins\ox-conda.ps1"
$Global:OX_OXYGEN.oxpbw = "$env:OXIDIZER\plugins\ox-bitwarden.ps1"
$Global:OX_OXYGEN.oxpcn = "$env:OXIDIZER\plugins\ox-conan.ps1"
$Global:OX_OXYGEN.oxpdk = "$env:OXIDIZER\plugins\ox-docker.ps1"
$Global:OX_OXYGEN.oxpes = "$env:OXIDIZER\plugins\ox-espanso.ps1"
$Global:OX_OXYGEN.oxpfm = "$env:OXIDIZER\plugins\ox-formats.ps1"
$Global:OX_OXYGEN.oxphx = "$env:OXIDIZER\plugins\ox-helix.ps1"
$Global:OX_OXYGEN.oxpjl = "$env:OXIDIZER\plugins\ox-julia.ps1"
$Global:OX_OXYGEN.oxpjn = "$env:OXIDIZER\plugins\ox-jupyter.ps1"
$Global:OX_OXYGEN.oxpnj = "$env:OXIDIZER\plugins\ox-node.ps1"
$Global:OX_OXYGEN.oxppu = "$env:OXIDIZER\plugins\ox-pueue.ps1"
$Global:OX_OXYGEN.oxprb = "$env:OXIDIZER\plugins\ox-ruby.ps1"
$Global:OX_OXYGEN.oxprs = "$env:OXIDIZER\plugins\ox-rust.ps1"
$Global:OX_OXYGEN.oxptl = "$env:OXIDIZER\plugins\ox-texlive.ps1"
$Global:OX_OXYGEN.oxput = "$env:OXIDIZER\plugins\ox-utils.ps1"
$Global:OX_OXYGEN.oxpvs = "$env:OXIDIZER\plugins\ox-vscode.ps1"

##########################################################
# System configuration files
##########################################################

$Global:OX_ELEMENT = @{}

$Global:OX_ELEMENT.ox = "$env:OXIDIZER\custom.ps1"
$Global:OX_ELEMENT.wz = "$env:SCOOP\persist\wezterm\wezterm.lua"
$Global:OX_ELEMENT.ps = $PROFILE

$Global:OX_OXIDE = @{}

. $Global:OX_ELEMENT.ox

if ( !(Test-Path "$env:OX_BACKUP\shell") ) {
    mkdir "$env:OX_BACKUP\shell"
}

if ( !(Test-Path "$env:OX_BACKUP\install") ) {
    mkdir "$env:OX_BACKUP\install"
}

if ( !(Test-Path "$env:OX_BACKUP\apps") ) {
    mkdir "$env:OX_BACKUP\apps"
}

$Global:OX_APPHOME = @{}

##########################################################
# PowerShell & Plugins
##########################################################

# import ox-windows
. $Global:OX_OXYGEN.oxpw
# import ox-utils
. $Global:OX_OXYGEN.oxput
# import pueue
. $Global:OX_OXYGEN.oxppu
# import ox-scoop
if ( [Environment]::OSVersion.VersionString.Contains("Windows") ) {
    . $Global:OX_OXYGEN.oxps
}

ForEach ($plugin in $Global:OX_PLUGINS) {
    . $Global:OX_OXYGEN.$($plugin)
}

##########################################################
# Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
function init_all {
    ForEach ($obj in $Global:OX_INIT_PROG) {
        Invoke-Expression init_$obj
    }
}

# update packages
function up_all {
    ForEach ($obj in $Global:OX_UPDATE_PROG) {
        Invoke-Expression up_$obj
    }
}

# backup packages lists
function back_all {
    ForEach ($obj in $Global:OX_BACKUP_PROG) {
        Invoke-Expression back_$obj
    }
}

# export configurations
function epall {
    ForEach ($obj in $Global:OX_EXPORT_FILE) {
        epf $obj
    }
}

# export configurations
function ipall {
    ForEach ($obj in $Global:OX_IMPORT_FILE) {
        ipf $obj
    }
}

# initialize Oxidizer
function iiox {
    ForEach ($obj in $Global:OX_INIT_FILE) {
        iif $obj
    }
}

# update Oxidizer
function upox {
    z $env:OXIDIZER
    git fetch origin master
    git reset --hard origin/master
}

Invoke-Expression (&zoxide init powershell --hook prompt | Out-String)

if ($Global:OX_STARTUP) {
    startup
}

##########################################################
# Extras
##########################################################

Import-Module posh-git

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

if ( [Environment]::OSVersion.VersionString.Contains("Windows") ) {
    Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion" -ErrorAction SilentlyContinue
}
