##########################################################
# config
##########################################################

$Global:OX_APPHOME.vs = "$env:OX_APPDATA\Code\User"
if ( !(Test-Path "$Global:OX_APPHOME.vs") ) {
    $Global:OX_APPHOME.vs = "$env:SCOOP\persist\vscode\data\user-data\User"
}

$Global:OX_ELEMENT.vs = "$($Global:OX_APPHOME.vs)\settings.json"
$Global:OX_ELEMENT.vsk = "$($Global:OX_APPHOME.vs)\keybindings.json"
$Global:OX_ELEMENT.vss_ = "$($Global:OX_APPHOME.vs)\snippets"

function up_vscode {
    echo "Update VSCode extensions by $($Global:OX_OXIDE.bkvsx)"
    $exts = (code --list-extensions)
    $file = (cat $($Global:OX_OXIDE.bkvsx))
    $num = (cat $($Global:OX_OXIDE.bkvsx) | wc -l)

    pueue group add vscode_update
    pueue parallel $num -g vscode_update

    Foreach ( $line in $file ) {
        if (echo $exts | rg $line) {
            echo "Extension $line is already installed."
        }
        else {
            echo "Installing $line"
            pueue add -g vscode_update " code --install-extension '$line'"
        }
    }
    sleep 3
    pueue status
}

function back_vscode {
    echo "Backup VSCode extensions to $($Global:OX_OXIDE.bkvsx)"
    code --list-extensions > "$($Global:OX_OXIDE.bkvsx)"
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
