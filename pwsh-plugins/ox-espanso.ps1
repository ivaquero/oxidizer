##########################################################
# config
##########################################################

# oxidizer files
$Global:Oxygen.oxesx = "$env:OXIDIZER\defaults\espanso-pkg.txt"
# config files
$Global:APPHOME.es = "$env:APPDATA\espanso"
if ( !(Test-Path "$Global:APPHOME.es") ) {
    $Global:APPHOME.es = "$env:SCOOP\apps\espanso\current\.espanso"
}

$Global:Element.es = "$($Global:APPHOME.es)\config\default.yml"
$Global:Element.esm = "$($Global:APPHOME.es)\match\base.yml"
# backup files
$Global:Oxide.bkes = "$env:BACKUP\espanso\config\default.yml"
$Global:Oxide.bkesm = "$env:BACKUP\espanso\match\base.yml"
$Global:Oxide.bkesx = "$env:BACKUP\espanso\espanso-pkg.txt"

function init_espanso {
    Write-Output "Initialize Espanso using Oxidizer configuration"
    $pkgs = (espanso package list)
    $file = (cat $Global:Oxygen.oxesx | sd " " "")
    Foreach ( $line in $file ) {
        if (Write-Output $pkgs | rg $line) {
            Write-Output "Extension $line is already installed."
        }
        else {
            Write-Output "Installing $line"
            Invoke-Expression "espanso package install $line"
        }
    }
}

function up_espanso {
    Write-Output "Update Espanso by $($Global:Oxide.bkesx)"
    $pkgs = (espanso package list)
    $file = (cat $Global:Oxide.bkesx | sd " " "")
    Foreach ( $line in $file ) {
        if (Write-Output $pkgs | rg $line) {
            Write-Output "Extension $line is already installed."
        }
        else {
            Write-Output "Installing $line"
            Invoke-Expression "espanso package install $line"
        }
    }
}

function back_espanso {
    Write-Output "Backup Espanso to $($Global:Oxide.bkesx)"
    espanso package list | rg --only-matching "\w+.*\w\s-" | rg --only-matching "\w+.*\w" | Out-File -FilePath "$($Global:Oxide.bkesx)"
}

##########################################################
# packages
##########################################################

function esis { espanso package install $args }
function esus { espanso package uninstall $args }
function esls { espanso package list }

function esup {
    param ( $pkg )
    if ([string]::IsNullOrEmpty($pkg)) {
        $pkgs = $(espanso package list | rg --only-matching "\w+.*\w\s-" | rg --only-matching "\w+.*\w")
        ForEach ( $line in $pkgs ) {
            espanso package update $line
        }
    }
    else {
        espanso package update $pkg
    }
}

##########################################################
# management
##########################################################

function ess { espanso start }
function esr { espanso restart }
function ess { espanso status }
function esq { espanso stop }

##########################################################
# main
##########################################################
function esa { param ( $path ) New-Item -Force -Path $path.yml }
function es { espanso $args }
function esh { espanso help }
function ese { espanso edit $args }
