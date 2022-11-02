# conventions
#
# uppercase for globvariables
# lowercase for locvariables
# titlecase for arrays

##########################################################
# basic settings
##########################################################

# change editor
function che {
    param ( $editor )
    sd 'EDITOR = .*' 'EDITOR = \'$editor\"" $Global:Element.ox
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
# register proxy ports
##########################################################

# c: clash, v: v2ray
$Global:Proxy = @{}
$Global:Proxy.c = '7890'
$Global:Proxy.v = '1080'

##########################################################
# select initial and backup configurations
##########################################################

# options: scoop, conda, julia, node, texlive, vscode, espanso
$Global:INIT_OBJ = @('scoop')
$Global:BACK_OBJ = @('scoop')
$Global:UP_OBJ = @('scoop')

# backup file path
$env:BACKUP = "$HOME\Documents\backup"

$Global:Oxide.bkox = "$env:BACKUP\custom.ps1"

$Global:Oxide.bks = "$env:BACKUP\install\Scoopfile.txt"
$Global:Oxide.bkw = "$env:BACKUP\install\Wingetfile.json"
$Global:Oxide.bkps = "$env:BACKUP\shell\Profile.ps1"
# $Global:Oxide.bkwz = "$env:BACKUP\terminal\wezterm.lua"

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
$Global:EPF_OBJ = @('ox', 'vs', 'vsk', 'vss_')

# files to be import from backup folder
# $Global:IPF_OBJ = @("ox", "vs", "vsk", "vss_")

# file to be copied from oxidizer\defaults
# wz: wezterm
# pu: pueue
# pua: pueue_aliases
$Global:IIF_OBJ = @('pu', 'pua')

##########################################################
# git settings
##########################################################

# backup files
$Global:Oxide.bkg = "$env:BACKUP\.gitconfig"
$Global:Oxide.bkgi = "$env:BACKUP\git\.gitignore"

##########################################################
# helix settings
##########################################################

# $Global:Oxide.bkhx = "$env:BACKUP\helix\config.toml"
# $Global:Oxide.bkhxl = "$env:BACKUP\helix\languages.toml"

##########################################################
# pueue settings
##########################################################

# backup files
$Global:Oxide.bkpu = "$env:BACKUP\pueue\pueue.yml"
$Global:Oxide.bkpua = "$env:BACKUP\pueue\pueue_aliases.yml"

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
# $Global:Oxide.bkc = "$env:BACKUP\conda\.condarc"

# # predefined conda environments
# # set the length of key < 3
# $Global:Conda_Env = @{}

# $Global:Conda_Env.b = 'base'

# # conda env stats with bkce, and should be consistent with Conda_Env
# # $Global:Oxide.bkceb = "$env:BACKUP\conda\conda-base.txt"

##########################################################
# rust settings
##########################################################

# if ( !(Test-Path "$env:BACKUP\rust") ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\rust"
# }

# $Global:Oxide.bkcg = "$env:BACKUP\rust\env.ps1"
# $Global:Oxide.bkcg_ = "$env:BACKUP\rust"

# # rust mirrors for faster download, use `rsmr` to use
# $Global:Rust_Mirror = @{}
# $Global:Rust_Mirror.ts = "mirrors.tuna.tsinghua.edu.cn"
# $Global:Rust_Mirror.zk = "mirrors.ustc.edu.cn"

##########################################################
# espanso settings
##########################################################

# $Global:Oxide.bkes = "$env:BACKUP\espanso\config\default.yml"
# $Global:Oxide.bkesm = "$env:BACKUP\espanso\match\base.yml"
# $Global:Oxide.bkesx = "$env:BACKUP\espanso\espanso-pkg.txt"

##########################################################
# julia settings
##########################################################

# if ( !(Test-Path "$env:BACKUP\julia") ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\julia"
# }

# $Global:Oxide.bkjl = "$env:BACKUP\julia\julia-pkgs.txt"
# $Global:Oxide.bkjls = "$env:BACKUP\julia\startup.jl"

##########################################################
# vscode settings
##########################################################

# if ( !(Test-Path "$env:BACKUP\vscode") ) {
#     New-Item -ItemType Directory -Force -Path "$env:BACKUP\vscode"
# }

# $Global:Oxide.bkvsk = "$env:BACKUP\vscode\settings.json"
# $Global:Oxide.bkvsk = "$env:BACKUP\vscode\keybindings.json"
# $Global:Oxide.bkvss_ = "$env:BACKUP\vscode\snippets"
# $Global:Oxide.bkvsx = "$env:BACKUP\vscode\vscode-exts.txt"

##########################################################
# podman configurations
##########################################################

##########################################################
# podman configurations
##########################################################

# # cnn
# $Global:Oxide.bkcn = "$env:backup\conan\default"
# $Global:Oxide.bkcnr = "$env:backup\conan\remote.json"
# # nodejs
# $Global:Oxide.bknj = "$env:BACKUP\javascript\node-pkgs.txt"
# # texlive
# $Global:Oxide.bktl = "$env:BACKUP\tex\texlive-pkgs.txt"

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
$env:DOWNLOAD = "$HOME\Download"

$Global:STARTUP = 1

function startup {
}

