# conventions
#
# uppercase for globvariables
# lowercase for locvariables

##########################################################
# basic settings
##########################################################

# change editor
function che {
    param ( $editor )
    sd "EDITOR = \'.*\'" "EDITOR = \'$editor\'" $Global:OX_ELEMENT.ox
}

# default editor, can be changed by function `che()`
$env:EDITOR = 'code'
# terminal editor
$env:EDITOR_T = 'vi'

##########################################################
# select ox-plugins
##########################################################

# toolchain specific (highly recommended)
# oxpg: ox-git
#
# language & software-specific
# oxpc: ox-conda
# oxpcc: ox-cpp
# oxpdk: ox-docker
# oxpes: ox-espanso
# oxphx: ox-helix
# oxpjl: ox-julia
# oxpjn: ox-jupyter
# oxpnj: ox-node
# oxppd: ox-podman
# oxprb: ox-ruby
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
#
# other-shortcuts
# oxpfm: ox-formats
# oxpbw: ox-bitwarden
$Global:PLUGINS = @(
    'oxpg',
    'oxpfm'
)

##########################################################
# select initial and backup configurations
##########################################################

# options: scoop, conda, vscode, espanso
$Global:OX_INIT_PROG = @('scoop')

# options: scoop, conda, vscode, espanso, julia, texlive, node
$Global:OX_UPDATE_PROG = @('scoop')
$Global:OX_BACKUP_PROG = @('scoop')

# backup file path
$env:BACKUP = "$HOME\Documents\backup"

$Global:OX_OXIDE.bkox = "$env:BACKUP\custom.ps1"

$Global:OX_OXIDE.bks = "$env:BACKUP\install\Scoopfile.txt"
$Global:OX_OXIDE.bkw = "$env:BACKUP\install\Wingetfile.json"
$Global:OX_OXIDE.bkps = "$env:BACKUP\shell\Profile.ps1"

# system file
# $Global:OX_ELEMENT.vi = "$HOME\.vimrc"
# $Global:OX_ELEMENT.al = "$env:APPDATA\alacritty\alacritty.yml"
# $Global:OX_ELEMENT.wz = "$env:APPDATA\wezterm\wezterm.lua"

# if ( !(Test-Path "$env:BACKUP\terminal" ) ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\terminal"
# }
# $Global:OX_OXIDE.bkal = "$env:BACKUP\terminal\alacritty.yml"
# $Global:OX_OXIDE.bkwz = "$env:BACKUP\terminal\wezterm.lua"

##########################################################
# register proxy ports
##########################################################

# c: clash, v: v2ray
$Global:OX_PROXY = @{}
$Global:OX_PROXY.c = '7890'
$Global:OX_PROXY.v = '1080'

##########################################################
# select export and import configurations
##########################################################

# files to be exported to backup folder
# ox: custom.sh of Oxidizer
# rs: cargo's env
# pu: pueue's config.yml
# pua: pueue's aliases.yml
# jl: julia's startup.jl
# vs: vscode's settings.json
# vsk: vscode's keybindings.json
# vss_: vscode's snippets folder
$Global:OX_EXPORT_FILE = @('ox', 'vs', 'vsk', 'vss_')

# files to be import from backup folder
# $Global:OX_IMPORT_FILE = @("ox", "vs", "vsk", "vss_")

# file to be copied from oxidizer\defaults
# wz: wezterm
# pu: pueue
# pua: pueue_aliases
$Global:OX_INIT_FILE = @('pu', 'pua')

##########################################################
# git settings
##########################################################

# backup files
$Global:OX_OXIDE.bkg = "$env:BACKUP\.gitconfig"
$Global:OX_OXIDE.bkgi = "$env:BACKUP\git\.gitignore"

##########################################################
# helix settings
##########################################################

# $Global:OX_OXIDE.bkhx = "$env:BACKUP\helix\config.toml"
# $Global:OX_OXIDE.bkhxl = "$env:BACKUP\helix\languages.toml"

##########################################################
# pueue settings
##########################################################

# backup files
$Global:OX_OXIDE.bkpu = "$env:BACKUP\pueue\pueue.yml"
$Global:OX_OXIDE.bkpua = "$env:BACKUP\pueue\pueue_aliases.yml"

# pueue demo
function upp {
    pueue group add up_all
    pueue parallel 3 -g up_all
    pueue add -g up_all 'scoop update *; scoop upgrade'
    pueue add -g up_all 'conda update --all --yes'
    pueue add -g up_all 'tlmgr update --all'
    # or use predefined items in pueue_aliase
    # pueue add -g up_all 'tlup'
}

##########################################################
# conda settings
##########################################################

# # backup files
# $Global:OX_OXIDE.bkc = "$env:BACKUP\conda\.condarc"

# # predefined conda environments
# # set the length of key < 3
# $Global:Conda_Env = @{}

# $Global:Conda_Env.b = 'base'

# # conda env stats with bkce, and should be consistent with Conda_Env
# # $Global:OX_OXIDE.bkceb = "$env:BACKUP\conda\conda-base.txt"

##########################################################
# rust settings
##########################################################

# if ( !(Test-Path "$env:BACKUP\rust") ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\rust"
# }

# $Global:OX_OXIDE.bkcg = "$env:BACKUP\rust\config.toml"
# $Global:OX_OXIDE.bkrs = "$env:BACKUP\rust\settings.toml"

##########################################################
# espanso settings
##########################################################

# $Global:OX_OXIDE.bkes = "$env:BACKUP\espanso\config\default.yml"
# $Global:OX_OXIDE.bkesx = "$env:BACKUP\espanso\match\base.yml"
# $Global:OX_OXIDE.bkesx_ = "$env:BACKUP\espanso\match\packages"

##########################################################
# julia settings
##########################################################

# if ( !(Test-Path "$env:BACKUP\julia") ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\julia"
# }

# $Global:OX_OXIDE.bkjl = "$env:BACKUP\julia\julia-pkgs.txt"
# $Global:OX_OXIDE.bkjls = "$env:BACKUP\julia\startup.jl"

##########################################################
# vscode settings
##########################################################

# if ( !(Test-Path "$env:BACKUP\vscode") ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\vscode"
# }

# $Global:OX_OXIDE.bkvsk = "$env:BACKUP\vscode\settings.json"
# $Global:OX_OXIDE.bkvsk = "$env:BACKUP\vscode\keybindings.json"
# $Global:OX_OXIDE.bkvss_ = "$env:BACKUP\vscode\snippets"
# $Global:OX_OXIDE.bkvsx = "$env:BACKUP\vscode\vscode-exts.txt"

##########################################################
# podman configurations
##########################################################

##########################################################
# podman configurations
##########################################################

# # cnn
# $Global:OX_OXIDE.bkcn = "$env:backup\conan\default"
# $Global:OX_OXIDE.bkcnr = "$env:backup\conan\remote.json"
# # nodejs
# $Global:OX_OXIDE.bknj = "$env:BACKUP\javascript\node-pkgs.txt"
# # texlive
# $Global:OX_OXIDE.bktl = "$env:BACKUP\tex\texlive-pkgs.txt"

##########################################################
# common aliases
##########################################################

# alternatives
function ls { lsd $args }
function ll { lsd -l $args }
function la { lsd -a $args }
function lla { lsd -la $args }
function lt { lsd --tree $args }
function cat { bat $args }
function man { tldr $args }
function du { dust $args }

# shortcuts
function e { Write-Output $args }
function rr { Remove-Item -Recurse $args }
function c { Clear-Host }

# tools
function z. { z .. }
function z.. { z ..\.. }
function zz { z - }
function hf { hyperfine $args }
function tt { hyperfine --warmup 3 --shell powershell '. $PROFILE' }

# ##########################################################
# # starship
# ##########################################################

# Invoke-Expression (&starship init powershell)

# $env:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
# $Global:OX_ELEMENT.ss = $env:STARSHIP_CONFIG

##########################################################
# weather
##########################################################

# -a: all, -g: geographical, -d: day, -n: night
function weaher {
    param ( $loc, $mode )
    case $mode in
    -a
    { Invoke-WebRequest wttr.in/$loc }
    -d
    { Invoke-WebRequest v2d.wttr.in/$loc }
    -n
    { Invoke-WebRequest v2d.wttr.in/$loc }
    -g
    { Invoke-WebRequest v3.wttr.in/$loc }
    -h {
        Write-Output "param 1:`n city: new+york`n airport(codes): muc `n resort: ~Eiffel+Tower`n ip address: @github.com`n help: :help"
        Write-Output "param 2:`n a: all`n d: day `n n: night`n g: {geographical`n f: format"
    }
    default { Invoke-WebRequest v2.wttr.in/$loc }
}

##########################################################
# startup & daily commands
##########################################################

# donwload path
$env:OX_DOWNLOAD = "$HOME\Download"

$Global:OX_STARTUP = 1

function startup {
}
