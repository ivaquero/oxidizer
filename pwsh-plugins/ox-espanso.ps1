##########################################################
# config
##########################################################

$Global:OX_APPHOME.es = "$env:APPDATA\espanso"
if ( !(Test-Path "$Global:OX_APPHOME.es") ) {
    $Global:OX_APPHOME.es = "$env:SCOOP\apps\espanso\current\.espanso"
}

$Global:OX_ELEMENT.es = "$($Global:OX_APPHOME.es)\default.yml"
$Global:OX_ELEMENT.esx = "$($Global:OX_APPHOME.es)\match\base.yml"
$Global:OX_ELEMENT.esx_ = "$($Global:OX_APPHOME.es)\match\packages"

##########################################################
# packages
##########################################################

function esis { espanso package install $args }
function esus { espanso package uninstall $args }
function esls { espanso package list }

function esup {
    param ( $pkg )
    if ([string]::IsNullOrEmpty($pkg)) {
        $pkgs = $(espanso package list | rg --only-matching '\w+.*\w\s-' | rg --only-matching '\w+.*\w')
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
function esst { espanso status }
function esq { espanso stop }

##########################################################
# main
##########################################################

function esa { param ( $path ) touch $($Global:OX_APPHOME.es)\match\$path.yml }
function esh { espanso help $args }
function esed { espanso edit $args }
