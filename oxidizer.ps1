if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

##########################################################
# Oxidizer Configuration Files
##########################################################

# plugins
$Global:OX_OXYGEN = @{
    'oxd'    = "$env:OXIDIZER\defaults.ps1"
    'oxwz'   = "$env:OXIDIZER\defaults\wezterm.lua"
    'oxpow'  = "$env:OXIDIZER\addons\ox-os-windows.ps1"
    'oxpcbw' = "$env:OXIDIZER\addons\ox-cli-bitwarden.ps1"
    'oxpces' = "$env:OXIDIZER\addons\ox-cli-espanso.ps1"
    'oxpcg'  = "$env:OXIDIZER\addons\ox-cli-git.ps1"
    'oxpcjr' = "$env:OXIDIZER\addons\ox-cli-jupyter.ps1"
    'oxpcvs' = "$env:OXIDIZER\addons\ox-cli-vscode.ps1"
    'oxpljl' = "$env:OXIDIZER\addons\ox-lang-julia.ps1"
    'oxplrb' = "$env:OXIDIZER\addons\ox-lang-ruby.ps1"
    'oxplrs' = "$env:OXIDIZER\addons\ox-lang-rust.ps1"
    'oxppc'  = "$env:OXIDIZER\addons\ox-pkg-conda.ps1"
    'oxppcn' = "$env:OXIDIZER\addons\ox-pkg-conan.ps1"
    'oxppn'  = "$env:OXIDIZER\addons\ox-pkg-npm.ps1"
    'oxpps'  = "$env:OXIDIZER\addons\ox-pkg-scoop.ps1"
    'oxpsct' = "$env:OXIDIZER\addons\ox-svc-container.ps1"
    'oxpspu' = "$env:OXIDIZER\addons\ox-svc-pueue.ps1"
    'oxptl'  = "$env:OXIDIZER\addons\ox-tlmgr.ps1"
    'oxptwr' = "$env:OXIDIZER\addons\ox-term-weather.ps1"
    'oxpuf'  = "$env:OXIDIZER\addons\ox-utils-files.ps1"
    'oxpufm' = "$env:OXIDIZER\addons\ox-utils-formats.ps1"
    'oxpunw' = "$env:OXIDIZER\addons\ox-utils-.ps1"
    'oxpxns' = "$env:OXIDIZER\addons\ox-xtra-notes.ps1"
}

##########################################################
# System Configuration Files
##########################################################

$Global:OX_ELEMENT = @{
    'ox' = "$env:OXIDIZER\custom.ps1"
    'vi' = "$HOME\.vimrc"
}

$Global:OX_OXIDE = @{}

##########################################################
# Load Plugins
##########################################################

# load system plugin
. $Global:OX_OXYGEN.oxpow

# load custom plugins
. $Global:OX_ELEMENT.ox

ForEach ($plugin in $Global:OX_PLUGINS) {
    if (Test-Path $Global:OX_OXYGEN.$($plugin)) {
        . $Global:OX_OXYGEN.$($plugin)
    }
    else {
        Write-Output "Plugin not found: $plugin"
    }
}

# load core plugins
$Global:OX_CORE_PLUGINS = @('oxps', 'oxput', 'oxpnw')

##########################################################
# PowerShell Settings
##########################################################

$Global:OX_ELEMENT.ps = $PROFILE
$Global:OX_OXIDE.bkps = "$env:OX_BACKUP\shell\Profile.ps1"

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
        git clone --depth=1 https://github.com/ivaquero/oxaddons.git $env:OXIDIZER\addons
    }
    else {
        Set-Location "$env:OXIDIZER\addons"
        Write-Output "`n`nUpdating Oxidizer Plugins...`n"
        git fetch origin main
        git reset --hard origin/main
    }

    Set-Location $env:OXIDIZER
    $ox_change = $(git diff defaults.ps1)
    if ([string]::IsNullOrEmpty($ox_change)) {
        Write-Output "`n`nDefaults changed, don't forget to update your custom.ps1 accordingly...`n"
        eWrite-Outputcho "Compare the difference using 'edf oxd'"
    }
    Set-Location $HOME
}

##########################################################
# Starship
##########################################################

if (Get-Command starship -ErrorAction SilentlyContinue) {
    # system files
    $env:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
    $Global:OX_ELEMENT.ss = $env:STARSHIP_CONFIG
    # backup files
    $Global:OX_OXIDE.ss = "$env:OX_BACKUP\shell\starship.toml"

    Invoke-Expression (&starship init powershell)
}

if ($Global:OX_STARTUP) {
    startup
}

##########################################################
# Extras
##########################################################

if ($(uname).Contains("Windows")) {
    Import-Module PSReadLine
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

    Import-Module "$env:SCOOP\modules\scoop-completion"
}
