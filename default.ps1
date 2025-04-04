##########################################################
# conventions
##########################################################

# uppercase for global variables
# lowercase for local variables

##########################################################
# basic settings
##########################################################

$env:EDITOR = 'code'
# terminal editor
$env:EDITOR_T = 'vi'

##########################################################
# select initial and backup configurations
##########################################################

# backup file path
$env:OX_BACKUP = "$HOME\Documents\backup"

# shell
$Global:OX_OXIDE.bkox = "$env:OX_BACKUP\shell\custom.ps1"

##########################################################
# git
##########################################################

# default files
$Global:OX_OXYGEN.oxg = "$env:OXIDIZER\defaults\.gitconfig"
# system files
$Global:OX_ELEMENT.g = "$HOME\.gitconfig"
# backup files
$Global:OX_OXIDE.bkg = "$env:OX_BACKUP\projects\.gitconfig"

##########################################################
# terminal
##########################################################

if ( Test-Path "$env:LOCALAPPDATA\Packages\Microsoft.windowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" ) {
    $Global:OX_ELEMENT.wt = "$env:LOCALAPPDATA\Packages\Microsoft.windowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}
else { $Global:OX_ELEMENT.wt = "C:\Scoop\apps\windows-terminal\current\settings\settings.json" }

if ( Test-Path $Global:OX_ELEMENT.wt ) {
    $Global:OX_OXIDE.bkwt = "$env:OX_BACKUP\terminal\windows-terminal.jsonc"
}
else {
    $Global:OX_ELEMENT.wz = "$HOME\.wezterm.lua"
    if ( !(Test-Path $Global:OX_ELEMENT.wz) ) {
        New-Item -Path $Global:OX_ELEMENT.wz -ItemType File
    }
    $Global:OX_OXIDE.bkwz = "$env:OX_BACKUP\terminal\wezterm.lua"
}

##########################################################
# proxy settings
##########################################################

# c: clash, m: clash-meta, v: v2ray
$Global:OX_PROXY = @{
    'c' = '7898'
    'm' = '7897'
    'v' = '1080'
}

##########################################################
# conda settings
##########################################################

# predefined conda environments
# set the length of key < 3
$Global:OX_CONDA_ENV = @{
    b = 'base'
}

# # conda env stats with bkce, and should be consistent with OX_CONDA_ENV
# # $Global:OX_OXIDE.bkceb = "$env:OX_BACKUP\conda\conda-base.txt"

##########################################################
# julia settings
##########################################################

# predefined julia environments
# set the length of key <= 3
# if ([string]::IsNullOrEmpty($env:JULIA_DEPOT_PATH)) {
#     $env:JULIA_DEPOT_PATH = "$HOME\.julia"
# }
# $Global:OX_JULIA_ENV = @{
#     b = "$env:JULIA_DEPOT_PATH\environments\v$(julia -v | rg -o '\d+\.\d+')"
#     # t = "tutorial"
# }

# # julia env stats with bkjl, and should be consistent with OX_JULIA_ENV
# $Global:OX_OXIDE.bkjlb = "$env:OX_BACKUP\julia\julia-base.txt"

##########################################################
# others settings
##########################################################

# zoxide
$Global:OX_OXIDE.bkz = "$env:OX_BACKUP\apps\db.zo"

##########################################################
# common aliases
##########################################################

# shortcuts
function .. { cd .. }
function ... { cd ../.. }
function cat { bat $args }
function ls { lsd $args }
function ll { lsd -l $args }
function la { lsd -a $args }
function lla { lsd -la $args }
function e { echo $args }
function rr { rm -rf $args }
function c { clear }

# tools
Remove-Item alias:man -Force -ErrorAction SilentlyContinue
function man { tldr $args }
function hf { hyperfine $args }

# oxidizer
# export config
function epf { oxf $args }
# import config
function ipf { rdf $args }
# initialize config
function iif { clzf $args }

##########################################################
# powershell
##########################################################

function tt { hyperfine --warmup 3 --shell powershell '. $PROFILE' }

##########################################################
# startup & daily commands
##########################################################

# download path
$env:OX_DOWNLOAD = "$HOME\Desktop"

$Global:OX_STARTUP = 1

function startup {
    Set-Location "$HOME\Desktop"
}

##########################################################
# docker
##########################################################

# docker
$Global:OX_ELEMENT.dk="$HOME/.docker/config.json"
$Global:OX_OXIDE.bkdk="$env:OX_BACKUP/docker/docker.json"
# daemon
$Global:OX_ELEMENT.dkd="$HOME/.docker/daemon.json"
$Global:OX_OXIDE.bkdkd="$env:OX_BACKUP/docker/daemon.json"

##########################################################
# notes apps
##########################################################

# $Global:OX_OXIDIAN = ""
