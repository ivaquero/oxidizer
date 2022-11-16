##########################################################
# config
##########################################################

$Global:OX_OXYGEN.oxs = "$env:OXIDIZER\defaults\Scoopfile.txt"

Import-Module "$($(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName)\modules\scoop-completion" -ErrorAction SilentlyContinue

##########################################################
# config
##########################################################

function init_scoop {
    Write-Output "Initialize Scoop by Oxidizer configuration"
    $scoop_pkgs = (cat $($Global:OX_OXYGEN.oxs) | sd "\n" "")
    scoop install $scoop_pkgs
}

function up_scoop {
    Write-Output "Update Scoop by $($Global:OX_OXIDE.bks)"
    $file = (cat $($Global:OX_OXIDE.bks))
    $num = (cat $($Global:OX_OXIDE.bks) | Measure-Object -Line).Lines

    pueue group add up_scoop
    pueue parallel $num -g up_scoop

    Foreach ( $line in $file ) {
        Write-Output "Installing $line"
        pueue add -g up_scoop "scoop install $line"
    }
    Start-Sleep -s 3
    pueue status
}

function back_scoop {
    Write-Output "Backup Scoop to $($Global:OX_OXIDE.bks)"
    scoop list | Out-File -FilePath "$($Global:OX_OXIDE.bks)"
}

##########################################################
# packages
##########################################################

function sis { scoop install $args }

function sus { scoop uninstall $args }

Remove-Item alias:sls -Force -ErrorAction SilentlyContinue
function sls { scoop list }
function sups { scoop update }

function sup {
    if ([string]::IsNullOrEmpty($args)) { scoop update * }
    else { scoop update $args }
}

function sisp {
    $num = (Write-Output $args | Measure-Object -Line).Lines
    if ( $num -ge 1 ) {
        pueue group add scoop_install
        pueue parallel $num -g scoop_install

        ForEach ($pkg in $args) {
            Write-Output "Installing $pkg"
            pueue add -g scoop_install "scoop install $pkg"
        }
        Start-Sleep -s 3
        pueue status
    }
    else { scoop update * }
}

function supp {
    $num = (scoop status | Measure-Object -Line).Lines
    if ( $num -ge 1 ) {
        pueue group add scoop_update
        pueue parallel $num -g scoop_update

        ForEach ($pkg in $args) {
            Write-Output "Installing $pkg"
            pueue add -g scoop_update "scoop update $pkg"
        }
        Start-Sleep -s 3
        pueue status
    }
    else { scoop update * }
}
function scl {
    if ([string]::IsNullOrEmpty($args)) { scoop cleanup * }
    else { scoop cleanup $args }
}

function sdp { scoop depends $args }
function sck { scoop checkup }
function sat { scoop config aria2-enabled true }
function saf { scoop config aria2-enabled false }

# info & version
function sif { scoop info $args }
function sst { scoop status }
function spn { scoop hold $args }
function supn { scoop unhold $args }

##########################################################
# extension
##########################################################

function sxa { param ( $bucket ) scoop bucket add $bucket }
function sxrm { param ( $bucket ) scoop bucket rm $bucket }
function sxls { scoop bucket list }

##########################################################
# project
##########################################################

function sii { param ( $pkg ) scoop create $pkg }

##########################################################
# mirrors
##########################################################

function smr {}
