if [[ -z $OXIDIZER ]]; then
    export OXIDIZER='.'
fi

printf "Installing Oxidizer\n"

# if [[ $(uname -s) == "Darwin" ]]; then
#     printf "📦 Installing XCode CL tools...\n"
#     xcode-select --install >/dev/null 2>&1
# fi

###################################################
# Install Homebrew
###################################################

if test ! "$(command -v brew)"; then
    info "📦 Homebrew not installed. Installing."
    if [ $BREW_CN ]; then
        brew_installer="$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    else
        brew_installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    eval "/bin/bash -c ${brew_installer}"
fi

printf "⚙️ Adding Custom settings...\n"
cp -i -v $OXIDIZER/demo-custom.sh $OXIDIZER/custom.sh

printf "⚙️ Activating Homebrew...\n"

if [[ $(uname -s) == "Darwin" ]]; then
    printf "📦 Installing Homebrew on MacOS...\n"
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    fi
else
    printf "📦 Installing Homebrew on Linux...\n"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

###################################################
# Install Homebrew Packages
###################################################

printf "📦 Installing essential Oxidizer toolchains...\n"
brew bundle install --file $OXIDIZER/defaults/Brewfile

###################################################
# Update Zsh Settings
###################################################

printf "📦 Adding Oxidizer into $HOME/.zshrc...\n"
echo '
# Oxidizer
if [[ -z $OXIDIZER ]]; then
    export OXIDIZER=$HOME/oxidizer
fi
source $OXIDIZER/oxidizer.sh' >>$HOME/.zshrc

echo "⚙️ Adding Custom settings..."
cp $OXIDIZER/demo-custom.sh $OXIDIZER/custom.sh

# loading starship & zoxide
sd ".* STARTUP=.*" "export STARTUP=1" $OXIDIZER/custom.sh

# set path of oxidizer
sd "source OXIDIZER=.*" "source OXIDIZER=$OXIDIZER/oxidizer.sh" $HOME/.zshrc

if [[ $(uname -s) == "Linux" ]]; then
    echo "export SHELL=$(which zsh)" >>$HOME/.profile
    echo "exec $(which zsh) -l" >>$HOME/.profile
else
    echo "export SHELL=$(which zsh)" >>$HOME/.bash_profile
    echo "exec $(which zsh) -l" >>$HOME/.bash_profile
fi

if test ! "$(command -v vi)"; then
    brew install neovim
    export EDITOR="nvim"
else
    export EDITOR="vi"
fi

printf "🥳 Oxidizer installation complete!\n"

echo "
If you have administrator priviledge, you can add zsh to system by 'which zsh | sudo tee -a /etc/shells' and then activate shell by 'sudo chsh -s $(which zsh) ${USER}'
"
