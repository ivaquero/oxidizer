##########################################################
# config
##########################################################

function open { param ( $path ) explorer $path }

##########################################################
# main
##########################################################

function clean {
    param ( $obj )
    switch ( $obj ) {
        sdl { Remove-Item -Recurse -Confirm $env:SCOOP\cache }
        Default { Clear-RecycleBin -Confirm }
    }
}

function hide {
    $file = Get-Item $args[0] -Force
    $file.attributes = 'Hidden'
}

function shutdown { Stop-Computer -Force }
function restart { Restart-Computer -Force }

##########################################################
# files
##########################################################

function sha1 { param ( $pkg ) Get-FileHash -Algorithm SHA1 $pkg }
function sha2 { param ( $pkg ) Get-FileHash $pkg }

##########################################################
# winget
##########################################################

function init_winget {
    Write-Output "Initialize WinGet to $($Global:OX_OXYGEN.oxw)"
    winget import -i $Global:OX_OXYGEN.oxw
}
function up_winget {
    Write-Output "Update Scoop by $($Global:OX_OXIDE.bkw)"
    winget import -i $Global:OX_OXIDE.bkw
}
function back_winget {
    Write-Output "Backup Scoop by $($Global:OX_OXIDE.bkw)"
    winget export -o $Global:OX_OXIDE.bkw
}

function w { winget $args }
function wis { winget install $args }
function wus { winget uninstall $args }
function wls { winget list $args }
function wif { winget show $args }
function wifs { winget --info }
function wsc { winget search $args }
function wup {
    if ([string]::IsNullOrEmpty($args)) { winget upgrade * }
    else { winget upgrade $args }
}
function wups { winget source update $args }
function wxa { param ( $repo ) winget source add $repo }
function wxrm { param ( $repo ) winget source remove $repo }
function wxls { param ( $repo ) winget source list }

##########################################################
# wsl
##########################################################

function wlis {
    if ([string]::IsNullOrEmpty($args)) { wsl --install }
    else { wsl --install -d $args }
}

function wlus { wslconfig /u $args }

function wlls { wsl -l -v }
function wllso { wsl -l -o }

function wlv {
    param ( $ver )
    switch ($ver) {
        { $ver -eq 2 } { 1 }
        Default { 2 }
    }
    wsl --set-version $ver
}


function wlcl {
    param ( $sys )
    switch ( $sys ) {
        kali { $file = "C:\Users\Ci\AppData\Local\Packages\KaliLinux.54290C8133FEE_ey8k8hqnwqnmg\LocalState\ext4.vhdx" }
        Default { $file = "C:\Users\Ci\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState\ext4.vhdx" }
    }
    diskpart
    Select-Object vdisk file=$file
    attach vdisk readonly
    compact vdisk
    detach vdisk
}
