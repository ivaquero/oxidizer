##########################################################
# config
##########################################################

$Global:APPHOME.es = "$env:APPDATA\espanso"
if ( !(Test-Path "$Global:APPHOME.es") ) {
    $Global:APPHOME.es = "$env:SCOOP\apps\espanso\current\.espanso"
}

$Global:OX_ELEMENT.es = "$($Global:APPHOME.es)\default.yml"
$Global:OX_ELEMENT.esx = "$($Global:APPHOME.es)\match\base.yml"
$Global:OX_ELEMENT.esx_ = "$($Global:APPHOME.es)\match\packages"

function up_espanso {
    ipf esx esx_
}

function back_espanso {
    epf esx esx_
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
function esa { param ( $path ) New-Item -Force -Path $($Global:APPHOME.es)\match\$path.yml }
function es { espanso $args }
function esh { espanso help $args }
function ese { espanso edit $args }
