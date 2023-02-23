##########################################################
# config
##########################################################

OX_ELEMENT[vs]=${APPDATA}/Code/User/settings.json
OX_ELEMENT[vsk]=${APPDATA}/Code/User/keybindings.json
OX_ELEMENT[vss_]=${APPDATA}/Code/User/snippets

up_vscode() {
    echo "Update VSCode extensions by ${OX_OXIDE[bkvsx]}"
    local exts=$(code --list-extensions)
    local num=$(cat ${OX_OXIDE[bkvsx]} | wc -l | rg --only-matching "\d+")

    pueue group add vscode_init
    pueue parallel $num -g vscode_init

    cat ${OX_OXIDE[bkvsx]} | while read line; do
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
    echo "Backup VSCode extensions to ${OX_OXIDE[bkvsx]}"
    code --list-extensions >${OX_OXIDE[bkvsx]}
}

##########################################################
# Cache
##########################################################

if [[ $(uname -s) = "Darwin" ]]; then
    vscl() {
        echo "Cleaning up VSCode Cache.\n"
        rm -rfv $APPDATA/Code/Cache/*

        case $1 in
        -a)
            echo "Cleaning up VSCode Workspace Storage.\n"
            rm -rfv $APPDATA/Code/User/workspaceStorage/*
            ;;
        esac
    }
fi

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
if [[ ${TERM_PROGRAM} == "vscode" ]]; then
    case ${SHELL} in
    *zsh)
        eval "$(code --locate-shell-integration-path zsh)"
        ;;
    *bash)
        eval "$(code --locate-shell-integration-path bash)"
        ;;
    *fish)
        eval "$(code --locate-shell-integration-path fish)"
        ;;
    esac
fi
