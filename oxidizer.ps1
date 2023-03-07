if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

##########################################################
# Oxidizer configuration files
##########################################################

# plugins
$Global:OX_OXYGEN = @{
    'oxd' = "$env:OXIDIZER\defaults.ps1"
    'oxz' = "$env:OXIDIZER\oxidizer.ps1"
    'oxwz' = "$env:OXIDIZER\defaults\wezterm.lua"
    'oxps' = "$env:OXIDIZER\plugins\ox-scoop.ps1"
    'oxpw' = "$env:OXIDIZER\plugins\ox-windows.ps1"
    'oxpg' = "$env:OXIDIZER\plugins\ox-git.ps1"
    'oxpc' = "$env:OXIDIZER\plugins\ox-conda.ps1"
    'oxpbw' = "$env:OXIDIZER\plugins\ox-bitwarden.ps1"
    'oxpcn' = "$env:OXIDIZER\plugins\ox-conan.ps1"
    'oxpdk' = "$env:OXIDIZER\plugins\ox-docker.ps1"
    'oxpes' = "$env:OXIDIZER\plugins\ox-espanso.ps1"
    'oxpfm' = "$env:OXIDIZER\plugins\ox-formats.ps1"
    'oxphx' = "$env:OXIDIZER\plugins\ox-helix.ps1"
    'oxpjl' = "$env:OXIDIZER\plugins\ox-julia.ps1"
    'oxpjn' = "$env:OXIDIZER\plugins\ox-jupyter.ps1"
    'oxpnj' = "$env:OXIDIZER\plugins\ox-node.ps1"
    'oxppu' = "$env:OXIDIZER\plugins\ox-pueue.ps1"
    'oxprb' = "$env:OXIDIZER\plugins\ox-ruby.ps1"
    'oxprs' = "$env:OXIDIZER\plugins\ox-rust.ps1"
    'oxptl' = "$env:OXIDIZER\plugins\ox-texlive.ps1"
    'oxput' = "$env:OXIDIZER\plugins\ox-utils.ps1"
    'oxpvs' = "$env:OXIDIZER\plugins\ox-vscode.ps1"
}

##########################################################
# System configuration files
##########################################################

$Global:OX_ELEMENT = @{
    'ox' = "$env:OXIDIZER\custom.ps1"
    'wz' = "$env:SCOOP\persist\wezterm\wezterm.lua"
    'ps' = $PROFILE
}

$Global:OX_OXIDE = @{}

$directories = @(
    "$env:OX_BACKUP\shell",
    "$env:OX_BACKUP\install",
    "$env:OX_BACKUP\apps"
)

ForEach ($directory in $directories) {
    if (!(Test-Path -Path "$directory")) {
        mkdir $directory
    }
}

$Global:OX_APPHOME = @{}

##########################################################
# PowerShell & Plugins
##########################################################

$Global:OX_CORE_PLUGINS = @('oxput', 'oxppu', 'oxpw')

ForEach ($core_plugin in $Global:OX_CORE_PLUGINS) {
    . $Global:OX_OXYGEN.$($core_plugin)
}

if ($(uname).Contains("Windows")) {
    . $Global:OX_OXYGEN.oxps
}

. $Global:OX_ELEMENT.ox

ForEach ($plugin in $Global:OX_PLUGINS) {
    . $Global:OX_OXYGEN.$($plugin)
}

##########################################################
# Oxidizer management
##########################################################

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
    $pkgs = cat "$env:OXIDIZER\defaults\Scoopfile.txt"

    ForEach ( $pkg in $pkgs ) {
        Switch ( $pkg ) {
            bottom { $cmd = 'btm' }
            ripgrep { $cmd = 'rg' }
            tealdeer { $cmd = 'tldr' }
            zoxide { $cmd = 'z' }
            Default { $cmd = $pkg }
        }
        if (Get-Command $cmd -ErrorAction SilentlyContinue) {
            echo "$pkg Already Installed"
        }
        else {
            echo "Installing $pkg"
            scoop install $pkg
        }
    }
}

# update Oxidizer
function upox {
    cd $env:OXIDIZER
    git fetch origin master
    git reset --hard origin/master

    ForEach ($core_plugin in $Global:OX_CORE_PLUGINS) {
        $core_plugin_file = $(basename $Global:OX_OXYGEN.$($core_plugin))
        curl -o $Global:OX_OXYGEN.$($core_plugin) https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/$core_plugin_file
    }

    if ( $(uname).Contains("Windows") ) {
        $scoop_plugin_file = $(basename $Global:OX_OXYGEN.oxps)
        curl -o $Global:OX_OXYGEN.oxps https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/$scoop_plugin_file
    }

    ForEach ($plugin in $Global:OX_PLUGINS) {
        $plugin_file = $(basename $Global:OX_OXYGEN.$($plugin))
        curl -o $Global:OX_OXYGEN.$($plugin) https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/$plugin_file
    }
}

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
