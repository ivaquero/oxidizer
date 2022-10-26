##########################################################
# basic settings
##########################################################

# donwload path: works for brew-aria2 function
$env:DOWNLOAD = "$HOME\Documents"
# backup folder
$env:BACKUP = "$env:DOWNLOAD\backup"

# default editor, can be changed by function `ched()`
$env:EDITOR = "code"
# terminal editor
$env:EDITOR_T = "vi"

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
# oxprb: ox-ruby
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
#
# other-shortcuts
# oxpfm: ox-formats
# oxpwg: ox-widgets
# oxpbw: ox-bitwarden
$Global:PLUGINS = @("oxpc", "oxpvs", "oxpfm")

##########################################################
# register proxy ports
##########################################################

# c: clash, v: v2ray
$Global:Proxy = @{}
$Global:Proxy.c = "7890"
$Global:Proxy.v = "1080"

##########################################################
# select initial and backup configurations
##########################################################

# options: scoop, conda, julia, node, texlive, vscode, espanso
$Global:INIT_OBJ = @("scoop")
$Global:BACK_OBJ = @("scoop")
$Global:UP_OBJ = @("scoop")

# backup file path
$Global:Oxide.bks = "$env:BACKUP\install\Scoopfile.txt"
$Global:Oxide.bkw = "$env:BACKUP\install\Wingetfile.json"
$Global:Oxide.bkps = "$env:BACKUP\shell\Profile.ps1"
$Global:Oxide.bkox = "$env:BACKUP\shell\custom.ps1"
# $Global:Oxide.bkwz = "$env:BACKUP\wezterm.lua"
# $Global:Oxide.bkar = "$env:BACKUP\aria2.conf"
# $Global:Oxide.bkvi = "$env:BACKUP\.vimrc"

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
$Global:EPF_OBJ = @("ox", "vs", "vsk", "vss_")

# files to be import from backup folder
# $Global:IPF_OBJ = @("ox", "vs", "vsk", "vss_")

# file to be copied from oxidizer\defaults
# wz: wezterm
# ar: aria2
# pu: pueue
# pua: pueue_aliases
$Global:IIF_OBJ = @("ar")
# $Global:IIF_OBJ = @("ar","wz")

##########################################################
# register conda environments
##########################################################

# predefined conda environments
# set the length of key < 3
$Global:Conda_Env = @{}
$Global:Conda_Env.b = "base"
# conda env stats with bkce, and should be consistent with Conda_Env
# $Global:Oxide.bkceb = "$env:BACKUP\conda\conda-base.txt"

##########################################################
# rust configurations
##########################################################

# rust mirrors for faster download, use `rsmr` to use
$Global:Rust_Mirror = @{}
$Global:Rust_Mirror.ts = "mirrors.tuna.tsinghua.edu.cn"
$Global:Rust_Mirror.zk = "mirrors.ustc.edu.cn"

##########################################################
# powerShell
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
function c { clear }

# tools
function z. { z .. }
function z.. { z ..\.. }
function zz { z - }
function hf { hyperfine $args }
function ar { aria2c --dir $env:DOWNLOAD $args }

##########################################################
# powerShell
##########################################################

function tt { hyperfine --warmup 3 --shell powershell '. $PROFILE' }

##########################################################
# startup & daily commands
##########################################################

$Global:STARTUP = 1

function startup {
}
