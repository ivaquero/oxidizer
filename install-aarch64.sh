if [ -z $OXIDIZER ]; then
    export OXIDIZER="$HOME/oxidizer"
fi

printf "Installing Oxidizer\n"

printf "Please note that Oxidizer has limited support for Linux-aarch64 yet."

###################################################
# Install Packages
###################################################

sudo apt install bat ripgrep sd hyperfine zoxide

###################################################
# Update Shell Settings
###################################################

case $SHELL in
*zsh)
    sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting
    export shell_conf=$HOME/.zshrc
    ;;
*bash)
    if [[ $(bash --version | head -n1 | cut -d' ' -f4 | cut -d'.' -f1) ]] <5; then
        printf "Installing Latest Bash...\n"
        sudo apt install bash bash-completion
    fi
    export shell_conf=$HOME/.profile
    echo 'export BASH_SILENCE_DEPRECATION_WARNING=1' >>$shell_conf
    ;;
esac

###################################################
# Injecting Oxidizer
###################################################

printf "Adding Oxidizer into $shell_conf...\n"

echo "# Oxidizer" >>$shell_conf

if [ -z $OXIDIZER ]; then
    echo '
    export OXIDIZER=$HOME/oxidizer
    source $OXIDIZER/oxidizer.sh
    ' >>$shell_conf
else
    echo "source $OXIDIZER/oxidizer.sh" >>$shell_conf
fi

echo "Adding Custom settings..."
cp $OXIDIZER/defaults.sh $OXIDIZER/custom.sh

# loading zoxide
sd ".* STARTUP=.*" "export STARTUP=1" $OXIDIZER/custom.sh

# set path of oxidizer
sd "source OXIDIZER=.*" "source OXIDIZER=$OXIDIZER/oxidizer.sh" $shell_conf

###################################################
# Editor
###################################################

if test ! "$(command -v code)"; then
    echo "No VS Code installed. "
    if test ! "$(command -v nvim)"; then
        echo "No NeoVim installed"
    else
        export EDITOR="vi"
    fi
fi

printf "Oxidizer installation complete!\n"
