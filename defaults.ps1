##########################################################
# conventions
##########################################################

# uppercase for global variables
# lowercase for local variables

##########################################################
# basic settings
##########################################################

# default editor, can be changed by function `che()`
$env:EDITOR = 'code'
# terminal editor
$env:EDITOR_T = 'vi'

##########################################################
# select ox-plugins
##########################################################

# oxpg: ox-git
# oxpc: ox-conda
# oxpcn: ox-conan
# oxpfm: ox-formats
# oxphx: ox-helix
# oxpjl: ox-julia
# oxpnj: ox-nodejs
# oxprs: ox-rust
# oxpss: ox-starship
# oxpbw: ox-bitwarden
# oxpct: ox-container
# oxpes: ox-espanso
# oxpjn: ox-jupyter
# oxptl: ox-texlive
# oxpvs: ox-vscode

$Global:OX_PLUGINS = @(
    'oxpfm',
    'oxpvs'
)

##########################################################
# select initial and backup configurations
##########################################################

# options: scoop, conda, vscode, julia, texlive, node
$Global:OX_UPDATE_PROG = @('scoop')
$Global:OX_BACKUP_PROG = @('scoop')

# backup file path
$env:OX_BACKUP = "$HOME\Documents\backup"

# shell
$Global:OX_OXIDE.bkox = "$env:OX_BACKUP\custom.ps1"

# terminal
# $Global:OX_ELEMENT.al = "$env:APPDATA\alacritty\alacritty.yml"
# $Global:OX_ELEMENT.wz = "$env:APPDATA\wezterm\wezterm.lua"

# if (!(Test-Path -Path "$env:OX_BACKUP\terminal")) {
#     mkdir "$env:OX_BACKUP\terminal"
# }
# $Global:OX_OXIDE.bkal = "$env:OX_BACKUP\terminal\alacritty.yml"
# $Global:OX_OXIDE.bkwz = "$env:OX_BACKUP\terminal\wezterm.lua"

##########################################################
# register proxy ports
##########################################################

# c: clash, v: v2ray
$Global:OX_PROXY = @{
    'c' = '7890'
    'v' = '1080'
}

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

##########################################################
# git settings
##########################################################

# backup files
$Global:OX_OXIDE.bkg = "$env:OX_BACKUP\.gitconfig"
$Global:OX_OXIDE.bkgi = "$env:OX_BACKUP\git\.gitignore"

##########################################################
# helix settings
##########################################################

# $Global:OX_OXIDE.bkhx = "$env:OX_BACKUP\helix\config.toml"
# $Global:OX_OXIDE.bkhxl = "$env:OX_BACKUP\helix\languages.toml"

##########################################################
# pueue settings
##########################################################

# pueue demo
# function upp {
#     pueue group add up_all
#     pueue parallel 3 -g up_all
#     pueue add -g up_all 'scoop update *; scoop upgrade'
#     pueue add -g up_all 'conda update --all --yes'
#     pueue add -g up_all 'tlmgr update --all'
#     # or use predefined items in pueue_aliase
#     # pueue add -g up_all 'tlup'
# }

##########################################################
# conda settings
##########################################################

# # predefined conda environments
# # set the length of key < 3
# $Global:OX_CONDA_ENV = @{
#     b = 'base'
# }

# # conda env stats with bkce, and should be consistent with OX_CONDA_ENV
# # $Global:OX_OXIDE.bkceb = "$env:OX_BACKUP\conda\conda-base.txt"

##########################################################
# vscode settings
##########################################################

$Global:OX_OXIDE.bkvs = "$env:OX_BACKUP\vscode\settings.json"

##########################################################
# common aliases
##########################################################

# alternatives
function ls { lsd $args }
function ll { lsd -l $args }
function la { lsd -a $args }
function lla { lsd -la $args }
function cat { bat $args }
function man { tldr $args }
function du { dust $args }

# shortcuts
function e { echo $args }
function rr { rm -rf $args }
function c { clear }

# tools
function zz { z - }
function hf { hyperfine $args }
function tt { hyperfine --warmup 3 --shell powershell '. $PROFILE' }

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
        echo "param 1:`n city: new+york`n airport(codes): muc `n resort: ~Eiffel+Tower`n ip address: @github.com`n help: :help"
        echo "param 2:`n a: all`n d: day `n n: night`n g: {geographical`n f: format"
    }
    default { Invoke-WebRequest v2.wttr.in/$loc }
}

##########################################################
# startup & daily commands
##########################################################

# donwload path
$env:OX_DOWNLOAD = "$HOME\Desktop"

$Global:OX_STARTUP = 1

function startup {
    Set-Location "$HOME\Desktop"
}
