##########################################################
# config
##########################################################

Oxygen[oxvsx]=$OXIDIZER/defaults/vscode-exts.txt
# config files
# use `_` as a suffix flag for directory
Element[vs]=$APPDATA/Code/User/settings.json
Element[vsk]=$APPDATA/Code/User/keybindings.json
Element[vss_]=$APPDATA/Code/User/snippets

init_vscode() {
    echo "Initialize VSCode extensions by Oxidizer configuration"
    local exts=$(code --list-extensions)
    local num=$(cat ${Oxygen[bkvsx]} | wc -l | rg --only-matching "\d+")

    pueue group add vscode_init
    pueue parallel $num -g vscode_init

    cat ${Oxygen[bkvsx]} | while read line; do
        if echo $exts | rg $line; then
            echo "Extension $line is already installed."
        else
            echo "Installing $line"
            pueue add -g vscode_init "code --install-extension '$line'"
        fi
    done
    sleep 3 && pueue status
}

up_vscode() {
    echo "Update VSCode extensions by ${Oxide[bkvsx]}"
    local exts=$(code --list-extensions)
    local num=$(cat ${Oxide[bkvsx]} | wc -l | rg --only-matching "\d+")

    pueue group add vscode_init
    pueue parallel $num -g vscode_init

    cat ${Oxide[bkvsx]} | while read line; do
        if echo $exts | rg $line; then
            echo "Extension $line is already installed."
        else
            echo "Installing $line"
            pueue add -g vscode_init "code --install-extension '$line'"
        fi
    done
    sleep 3 && pueue status
}

back_vscode() {
    echo "Backup VSCode extensions to ${Oxide[bkvsx]}"
    code --list-extensions >${Oxide[bkvsx]}
}

##########################################################
# extensions
##########################################################

alias vsis="code --install-extension"
alias vsus="code --uninstall-extension"
alias vsls="code --list-extensions"

##########################################################
# integration
##########################################################

# shell
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    case $SHELL in
    *zsh)
        eval "$(code --locate-shell-integration-path zsh)"
        ;;
    *bash)
        eval "$(code --locate-shell-integration-path bash)"
        ;;
    esac
fi
