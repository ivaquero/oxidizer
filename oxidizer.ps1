if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    if ($env:OS) {
        $env:OXIDIZER = "$HOME/oxidizer"
    }
    else {
        $env:OXIDIZER = "$env:HOME/Documents/GitHub/oxidizer"
    }
}

##########################################################
# oxidizer Configuration Files
##########################################################

# plugins
$env:OX_CONFIG = cat "$env:OXIDIZER/defaults/config.json" | ConvertFrom-Json
$env:OX_OXYGEN = $env:OX_CONFIG.oxygen
$env:OX_PLUGINS = $env:OX_CONFIG.plugins_pwsh
$env:OX_CUSTOM = cat "$env:OXIDIZER/custom.json" | ConvertFrom-Json
if ($env:OS) {
    $env:OX_BACKUP = $env:OX_PREFIX + $env:OX_CUSTOM.oxide_folder_win
}
else {
    $env:OX_BACKUP = $env:OX_PREFIX + $env:OX_CUSTOM.oxide_folder
}
$env:OX_DOWNLOAD = $env:OX_PREFIX + $env:OX_CUSTOM.download_folder

##########################################################
# System Configuration Files
##########################################################

$env:OX_ELEMENT = @{
    'wox' = "$env:OXIDIZER/custom.ps1"
    'jox' = "$env:OXIDIZER/custom.json"
    'g'   = "$HOME/.gitconfig"
    'vi'  = "$HOME/.vimrc"
    'ps'  = "$HOME/Documents\WindowsPowerShell\profile.ps1"
    'dk'  = "$HOME/.docker/custom.json"
    'dkd' = "$HOME/.docker/daemon.json"
}

if ( Test-Path "$env:LOCALAPPDATA\Packages\Microsoft.windowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" ) {
    $env:OX_ELEMENT.wt = "$env:LOCALAPPDATA\Packages\Microsoft.windowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}
else { $env:OX_ELEMENT.wt = "C:\Scoop\apps\windows-terminal/current\settings\settings.json" }

$env:OX_ELEMENT.wz = "$HOME/.wezterm.lua"
if ( !(Test-Path $env:OX_ELEMENT.wz) ) {
    New-Item -Path $env:OX_ELEMENT.wz -ItemType File
}

# backup configuration files
$env:OX_OXIDE = $env:OX_CUSTOM.oxides

##########################################################
# Load Plugins
##########################################################

. $env:OX_ELEMENT.wox

# load core plugins
. ("$env:OXIDIZER" + "/" + $env:OX_PLUGINS.os_windows)
. ("$env:OXIDIZER" + "/" + $env:OX_PLUGINS.pkg_scoop)
. ("$env:OXIDIZER" + "/" + $env:OX_PLUGINS.utils_files)
. ("$env:OXIDIZER" + "/" + $env:OX_PLUGINS.utils_formats)
. ("$env:OXIDIZER" + "/" + $env:OX_PLUGINS.utils_networks)

$env:OX_PLUGINS_LOAD = $(Write-Output $env:OX_CUSTOM.plugins_load | rg -o "\w+")
ForEach ($plugin in $env:OX_PLUGINS_LOAD) {
    $plugin_path = "$env:OXIDIZER" + "/" + $env:OX_PLUGINS.$plugin
    . $plugin_path
}
# load custom plugins
$env:OX_PLUGINS_PLUS = $env:OX_CUSTOM.plugins_plus
$env:OX_PLUGINS_LOAD_PLUS = $(Write-Output $env:OX_CUSTOM.plugins_load_plus | rg -o "\w+")
if ($env:OX_PLUGINS_LOAD_PLUS) {
    ForEach ($plugin in $env:OX_PLUGINS_LOAD_PLUS) {
        $plugin_path = "$env:OXIDIZER" + "/" + $env:OX_PLUGINS_PLUS.$plugin
        . $plugin_path
    }
}

##########################################################
# oxidizer Management
##########################################################

# update oxidizer
function upox {
    Set-Location $env:OXIDIZER
    Write-Output "Updating oxidizer...`n"
    git fetch origin master
    git reset --hard origin/master

    if (!(Test-Path -Path "$env:OXIDIZER\addons")) {
        Write-Output "`n`nCloning oxidizer Plugins...`n"
        git clone --depth=1 https://github.com/ivaquero/oxplugins-pwsh.git $env:OXIDIZER\addons
    }
    else {
        if ( $args[0] -eq "-f" ) {
            Remove-Item "$env:OXIDIZER\addons\*.*"
            git clone --depth=1 https://github.com/ivaquero/oxplugins-pwsh.git $env:OXIDIZER\addons
        }
        Set-Location "$env:OXIDIZER\addons"
        Write-Output "`n`nUpdating oxidizer Plugins...`n"
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
$env:OX_ELEMENT.z = "$env:_ZO_DATA_DIR/db.zo"

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
    $env:OX_ELEMENT.ss = $env:STARSHIP_CONFIG

    Invoke-Expression (&starship init powershell)
}

$env:OX_STARTUP = $env:OX_CUSTOM.startup_folder
if ($env:OX_STARTUP) {
    Set-Location "$env:OX_STARTUP"
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
