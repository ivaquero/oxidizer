##########################################################
# config
##########################################################

# oxidizer files
$Global:Oxygen.oxvsx = "$env:OXIDIZER\defaults\vscode-exts.txt"
# config files
# use `_` as a suffix flag for directory
$Global:APPHOME.vs = "$env:APPDATA\Code\User"
if ( !(Test-Path "$Global:APPHOME.vs") ) {
    $Global:APPHOME.vs = "$env:SCOOP\persist\vscode\data\user-data\User"
}

$Global:Element.vs = "$($Global:APPHOME.vs)\settings.json"
$Global:Element.vsk = "$($Global:APPHOME.vs)\keybindings.json"
$Global:Element.vss_ = "$($Global:APPHOME.vs)\snippets"

function init_vscode {
    Write-Output 'Initialize VSCode extensions by Oxidizer configuration'
    $exts = (code --list-extensions)
    $file = (cat $Global:Oxygen.oxvsx)
    $num = (cat $Global:Oxygen.oxvsx | Measure-Object -Line).Lines

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

function up_vscode {
    Write-Output "Update VSCode extensions by $($Global:Oxide.bkvsx)"
    $exts = (code --list-extensions)
    $file = (cat $Global:Oxide.bkvsx)
    $num = (cat $Global:Oxide.bkvsx | Measure-Object -Line).Lines

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
    Write-Output "Backup VSCode extensions to $($Global:Oxide.bkvsx)"
    code --list-extensions | Out-File -FilePath "$($Global:Oxide.bkvsx)"
}

##########################################################
# extensions
##########################################################

function vsis { code --install-extension $args }
function vsus { code --uninstall-extension $args }
function vsls { code --list-extensions }

##########################################################
# integration
##########################################################

# shell
if ($env:TERM_PROGRAM -eq 'vscode') { . "$(code --locate-shell-integration-path pwsh)" }
