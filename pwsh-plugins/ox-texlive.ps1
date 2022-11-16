##########################################################
# config
##########################################################

function up_texlive {
    Write-Output "Update TeXLive by $($Global:OX_OXIDE.bktl)"
    $file = (cat $($Global:OX_OXIDE.bktl))
    $num = (cat $($Global:OX_OXIDE.bktl) | Measure-Object -Line).Lines

    pueue group add texlive_update
    pueue parallel $num -g texlive_update

    Foreach ( $line in $file ) {
        Write-Output "Installing $line"
        pueue add -g texlive_update "tlmgr install $line"
    }
    Start-Sleep -s 3
    pueue status
}

function back_texlive {
    Write-Output "Backup TeXLive to $($Global:OX_OXIDE.bktl)"
    tlmgr list --only-installed | rg --only-matching 'collection-\w+' | rg --invert-match 'basic' | Out-File -FilePath "$($Global:OX_OXIDE.bktl)"
}

##########################################################
# packages
##########################################################

function tlup { tlmgr update --all }
function tlups { tlmgr update --all --self }
function tlck { tlmgr check }
function tlis { tlmgr install $args }
function tlus { tlmgr remove $args }
function tllsa { tlmgr list $args }
function tlls { tlmgr list --only-installed }
function tlif { tlmgr info $args }
function tlifc { tlmgr info collections }
function tlifs { tlmgr info schemes }
function tlh { tlmgr -h }
