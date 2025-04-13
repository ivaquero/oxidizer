if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    if ($env:OS) {
        $env:OXIDIZER = "$HOME\oxidizer"
    }
    else {
        $env:OXIDIZER = "$env:HOME/Documents/GitHub/oxidizer"
    }
}

##########################################################
# Oxidizer Configuration Files
##########################################################

# plugins
$Global:OX_CONFIG = cat "$env:OXIDIZER/defaults/config.json" | ConvertFrom-Json
$Global:OX_OXYGEN = $Global:OX_CONFIG.oxygen
$Global:OX_PLUGINS = $Global:OX_CONFIG.plugins_pwsh
$Global:OX_CUSTOM = cat "$env:OXIDIZER/custom.json" | ConvertFrom-Json
$Global:OX_BACKUP = $HOME + "/" + $Global:OX_CUSTOM.oxide_folder
$Global:OX_DOWNLOAD = $HOME + "/" + $Global:OX_CUSTOM.download_folder

##########################################################
# System Configuration Files
##########################################################

$Global:OX_ELEMENT = @{
    'wox' = "$env:OXIDIZER/custom.ps1"
    'jox' = "$env:OXIDIZER/custom.json"
    'g'   = "$HOME/.gitconfig"
    'vi'  = "$HOME/.vimrc"
    'ps'  = "$HOME/Documents\WindowsPowerShell\profile.ps1"
    'dk'  = "$HOME/.docker/custom.json"
    'dkd' = "$HOME/.docker/daemon.json"
}

if ( Test-Path "$env:LOCALAPPDATA\Packages\Microsoft.windowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" ) {
    $Global:OX_ELEMENT.wt = "$env:LOCALAPPDATA\Packages\Microsoft.windowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}
else { $Global:OX_ELEMENT.wt = "C:\Scoop\apps\windows-terminal/current\settings\settings.json" }

$Global:OX_ELEMENT.wz = "$HOME/.wezterm.lua"
if ( !(Test-Path $Global:OX_ELEMENT.wz) ) {
    New-Item -Path $Global:OX_ELEMENT.wz -ItemType File
}

# backup configuration files
$Global:OX_OXIDE = $Global:OX_CUSTOM.oxides

##########################################################
# Load Plugins
##########################################################

. $Global:OX_ELEMENT.wox

# load core plugins
. ("$env:OXIDIZER" + "/" + $Global:OX_PLUGINS.os_windows)
. ("$env:OXIDIZER" + "/" + $Global:OX_PLUGINS.pkg_scoop)
. ("$env:OXIDIZER" + "/" + $Global:OX_PLUGINS.utils_files)
. ("$env:OXIDIZER" + "/" + $Global:OX_PLUGINS.utils_formats)
. ("$env:OXIDIZER" + "/" + $Global:OX_PLUGINS.utils_networks)

$Global:OX_PLUGINS_LOAD = $(echo $Global:OX_CUSTOM.plugins_load | rg -o "\w+")
ForEach ($plugin in $Global:OX_PLUGINS_LOAD) {
    $plugin_path = "$env:OXIDIZER" + "/" + $Global:OX_PLUGINS.$plugin
    . $plugin_path
}
# load custom plugins
$Global:OX_PLUGINS_PLUS = $Global:OX_CUSTOM.plugins_plus
$Global:OX_PLUGINS_LOAD_PLUS = $(echo $Global:OX_CUSTOM.plugins_load_plus | rg -o "\w+")
if ($Global:OX_PLUGINS_LOAD_PLUS) {
    ForEach ($plugin in $Global:OX_PLUGINS_LOAD_PLUS) {
        $plugin_path = "$env:OXIDIZER" + "/" + $Global:OX_PLUGINS_PLUS.$plugin
        . $plugin_path
    }
}

##########################################################
# Oxidizer Management
##########################################################

# update Oxidizer
function upox {
    Set-Location $env:OXIDIZER
    Write-Output "Updating Oxidizer...`n"
    git fetch origin master
    git reset --hard origin/master

    if (!(Test-Path -Path "$env:OXIDIZER\addons")) {
        Write-Output "`n`nCloning Oxidizer Plugins...`n"
        git clone --depth=1 https://github.com/ivaquero/oxplugins-pwsh.git $env:OXIDIZER\addons
    }
    else {
        Set-Location "$env:OXIDIZER\addons"
        Write-Output "`n`nUpdating Oxidizer Plugins...`n"
        git fetch origin main
        git reset --hard origin/main
    }

    Set-Location $HOME
}

##########################################################
# Shell Settings
##########################################################

if ($env:OS) {
    function tt { hyperfine --warmup 3 --shell powershell '. $PROFILE' }
}
else {
    function tt { hyperfine --warmup 3 --shell pwsh '. $PROFILE' }
}

##########################################################
# Zoxide
##########################################################

if ($env:OS) {
    $env:_ZO_DATA_DIR = "$env:LOCALAPPDATA/zoxide"
}
else {
    $env:_ZO_DATA_DIR = "$HOME/.config/zoxide"
}

if (!(Test-Path -Path $env:_ZO_DATA_DIR)) {
    mkdir "$env:_ZO_DATA_DIR"
}
$Global:OX_ELEMENT.z = "$env:_ZO_DATA_DIR/db.zo"

function zh { zoxide --help }
function zii { zoxide init $args }
function za { zoxide add $args }
function zrm { zoxide remove $args }
function zed { zoxide edit $args }
function zsc { zoxide query $args }

Invoke-Expression (& { $hook = if ($PSVersionTable.PSVersion.Major -ge 6) { 'pwd' } else { 'prompt' } (zoxide init powershell --hook $hook | Out-String) })

##########################################################
# Starship
##########################################################

if (Get-Command starship -ErrorAction SilentlyContinue) {
    # system files
    $env:STARSHIP_CONFIG = "$HOME/.config/starship.toml"
    $Global:OX_ELEMENT.ss = $env:STARSHIP_CONFIG

    Invoke-Expression (&starship init powershell)
}

$Global:OX_STARTUP = $Global:OX_CUSTOM.startup_folder
if ($Global:OX_STARTUP) {
    cd "$Global:OX_STARTUP"
}

##########################################################
# Extras
##########################################################

if ($env:OS) {
    Import-Module PSReadLine
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
}
