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
    scoop import $($Global:OX_OXIDE.bks)
}

function back_scoop {
    Write-Output "Backup Scoop to $($Global:OX_OXIDE.bks)"
    scoop export > $($Global:OX_OXIDE.bks)
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
    if ([string]::IsNullOrEmpty($args)) { scoop update --all }
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
    else { scoop update --all }
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
    else { scoop update --all }
}
function scl {
    if ([string]::IsNullOrEmpty($args)) { scoop cleanup --all --cache }
    else { scoop cleanup $args --cache }
}

function sdp { scoop depends $args }
function sck { scoop checkup }
function ssc { scoop search }
function sat { scoop config aria2-enabled true }
function saf { scoop config aria2-enabled false }

# info & version
function sif {
    Switch ( $args[1] ) {
        --json { scoop cat $args[2] }
        Default { scoop info $args }
    }
}
function sst { scoop status }
function spn { scoop hold $args }
function supn { scoop unhold $args }

##########################################################
# extension
##########################################################

function sxa { scoop bucket add $args }
function sxrm { scoop bucket rm $args }
function sxls { scoop bucket list }

##########################################################
# project
##########################################################

function sii { param ( $pkg ) scoop create $pkg }
function sca { param ( $pkg ) scoop cat $pkg }

##########################################################
# mirrors
##########################################################

function smr {}
