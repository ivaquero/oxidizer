##########################################################
# config
##########################################################

$Global:APPHOME.vs = "$env:APPDATA\Code\User"
if ( !(Test-Path "$Global:APPHOME.vs") ) {
    $Global:APPHOME.vs = "$env:SCOOP\persist\vscode\data\user-data\User"
}

$Global:OX_ELEMENT.vs = "$($Global:APPHOME.vs)\settings.json"
$Global:OX_ELEMENT.vsk = "$($Global:APPHOME.vs)\keybindings.json"
$Global:OX_ELEMENT.vss_ = "$($Global:APPHOME.vs)\snippets"

function up_vscode {
    Write-Output "Update VSCode extensions by $($Global:OX_OXIDE.bkvsx)"
    $exts = (code --list-extensions)
    $file = (cat $($Global:OX_OXIDE.bkvsx))
    $num = (cat $($Global:OX_OXIDE.bkvsx) | Measure-Object -Line).Lines

    pueue group add vscode_update
    pueue parallel $num -g vscode_update

    Foreach ( $line in $file ) {
        if (Write-Output $exts | rg $line) {
            Write-Output "Extension $line is already installed."
        }
        else {
            Write-Output "Installing $line"
            pueue add -g vscode_update " code --install-extension '$line'"
        }
    }
    Start-Sleep -s 3
    pueue status
}

function back_vscode {
    Write-Output "Backup VSCode extensions to $($Global:OX_OXIDE.bkvsx)"
    code --list-extensions | Out-File -FilePath "$($Global:OX_OXIDE.bkvsx)"
}

##########################################################
# extensions
##########################################################

function vsis { code --install-extension $args }
function vsus { code --uninstall-extension $args }
function vsls { code --list-extensions $args }

##########################################################
# integration
##########################################################

# shell
if ($env:TERM_PROGRAM -eq 'vscode') { . "$(code --locate-shell-integration-path pwsh)" }
