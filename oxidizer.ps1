if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

##########################################################
# Oxidizer configuration files
##########################################################

$Global:Oxygen = @{}
# defaults
$Global:Oxygen.oxd = "$env:OXIDIZER\defaults.ps1"
$Global:Oxygen.oxz = "$env:OXIDIZER\oxidizer.ps1"
$Global:Oxygen.oxwz = "$env:OXIDIZER\defaults\wezterm.lua"
# plugins
$Global:Oxygen.oxps = "$env:OXIDIZER\pwsh-plugins\ox-scoop.ps1"
$Global:Oxygen.oxpw = "$env:OXIDIZER\pwsh-plugins\ox-windows.ps1"
$Global:Oxygen.oxpg = "$env:OXIDIZER\pwsh-plugins\ox-git.ps1"
$Global:Oxygen.oxpc = "$env:OXIDIZER\pwsh-plugins\ox-conda.ps1"
$Global:Oxygen.oxpbw = "$env:OXIDIZER\pwsh-plugins\ox-bitwarden.ps1"
$Global:Oxygen.oxpcc = "$env:OXIDIZER\pwsh-plugins\ox-cpp.ps1"
$Global:Oxygen.oxpdk = "$env:OXIDIZER\pwsh-plugins\ox-docker.ps1"
$Global:Oxygen.oxpes = "$env:OXIDIZER\pwsh-plugins\ox-espanso.ps1"
$Global:Oxygen.oxpfm = "$env:OXIDIZER\pwsh-plugins\ox-formats.ps1"
$Global:Oxygen.oxphx = "$env:OXIDIZER\pwsh-plugins\ox-helix.ps1"
$Global:Oxygen.oxpjl = "$env:OXIDIZER\pwsh-plugins\ox-julia.ps1"
$Global:Oxygen.oxpjn = "$env:OXIDIZER\pwsh-plugins\ox-jupyter.ps1"
$Global:Oxygen.oxpnj = "$env:OXIDIZER\pwsh-plugins\ox-node.ps1"
$Global:Oxygen.oxppu = "$env:OXIDIZER\pwsh-plugins\ox-pueue.ps1"
$Global:Oxygen.oxprb = "$env:OXIDIZER\pwsh-plugins\ox-ruby.ps1"
$Global:Oxygen.oxprs = "$env:OXIDIZER\pwsh-plugins\ox-rust.ps1"
$Global:Oxygen.oxptl = "$env:OXIDIZER\pwsh-plugins\ox-texlive.ps1"
$Global:Oxygen.oxput = "$env:OXIDIZER\pwsh-plugins\ox-utils.ps1"
$Global:Oxygen.oxpvs = "$env:OXIDIZER\pwsh-plugins\ox-vscode.ps1"

##########################################################
# System configuration files
##########################################################

$Global:Element = @{}

$Global:Element.ox = "$env:OXIDIZER\custom.ps1"
$Global:Element.wz = "$env:SCOOP\persist\wezterm\wezterm.lua"
$Global:Element.ps = $PROFILE

$Global:Oxide = @{}

. $Global:Element.ox

if ( !(Test-Path "$env:BACKUP\shell") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP\shell"
}

if ( !(Test-Path "$env:BACKUP\install") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP\install"
}

if ( !(Test-Path "$env:BACKUP\apps") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP\apps"
}

$Global:APPHOME = @{}

##########################################################
# PowerShell & Plugins
##########################################################

# import ox-windows
. $Global:Oxygen.oxpw
# import ox-utils
. $Global:Oxygen.oxput
# import pueue
. $Global:Oxygen.oxppu
# import ox-scoop
if ( [Environment]::OSVersion.VersionString.Contains("Windows") ) {
    . $Global:Oxygen.oxps
}

ForEach ($plugin in $Global:PLUGINS) {
    . $Global:Oxygen.$($plugin)
}

##########################################################
# Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
function init_all {
    ForEach ($obj in $Global:INIT_OBJ) {
        Invoke-Expression init_$obj
    }
}

# update packages
function back_all {
    ForEach ($obj in $Global:UP_OBJ) {
        Invoke-Expression up_$obj
    }
}

# backup packages lists
function back_all {
    ForEach ($obj in $Global:BACK_OBJ) {
        Invoke-Expression back_$obj
    }
}

# export configurations
function epall {
    ForEach ($obj in $Global:EPF_OBJ) {
        epf $obj
    }
}

# export configurations
function ipall {
    ForEach ($obj in $Global:IPF_OBJ) {
        ipf $obj
    }
}

# initialize Oxidizer
function iiox {
    ForEach ($obj in $Global:IIF_OBJ) {
        iif $obj
    }
}

# update Oxidizer
function upox {
    z $env:OXIDIZER
    git fetch origin master
    git reset --hard origin/master
}

if ($Global:STARTUP) {
    Invoke-Expression (&zoxide init powershell --hook prompt | Out-String)
    startup
}

if (Get-Command code -ErrorAction SilentlyContinue) {
    $env:EDITOR = "code"
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
