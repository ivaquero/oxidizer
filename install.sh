#!/bin/bash /bin/zsh
export OXIDIZER=${OXIDIZER:-"${HOME}/oxidizer"}
printf "📦 Installing Oxidizer\n"

###################################################
# Install Homebrew
###################################################

if ! command -v brew >/dev/null 2>&1; then
    printf "📦 Homebrew not installed. Installing.\n"
    if [[ ${BREW_CN} ]]; then
        /bin/bash -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
fi

if [[ $(uname -s) = "Darwin" ]]; then
    printf "📦 Activating Homebrew on MacOS...\n"
    if [[ $(uname -m) = "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >>~/.zshrc
    else
        eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    fi
else
    printf "📦 Activating Homebrew on Linux...\n"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew tap brewforge/extras

###################################################
# Install Packages
###################################################

printf "📦 Installing essential Oxidizer toolchains...\n"

while read -r pkg; do
    case $pkg in
    ripgrep)
        cmd='rg'
        ;;
    tlrc)
        cmd='tldr'
        ;;
    zoxide)
        cmd='z'
        ;;
    *)
        cmd=$pkg
        ;;
    esac
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf "%s not found, installing...\n" "$pkg"
        brew install "$pkg"
    fi
done <"${OXIDIZER}"/defaults/install.txt

###################################################
# Install Zap
###################################################

if [[ $(uname -s) = "Linux" ]]; then
    printf "📦 Adding Tap linuxbrew/fonts...\n"
    brew tap "linuxbrew/fonts"
fi

###################################################
# Update Shell Settings
###################################################

printf "⚙️ Configuring Shell...\n"

case ${SHELL} in
*zsh)
    brew install zsh-completions zsh-autosuggestions zsh-syntax-highlighting
    export OX_SHELL=${HOME}/.zshrc
    ;;
*bash)
    if [[ $(bash --version | head -n1 | cut -d' ' -f4 | cut -d'.' -f1) -lt 5 ]]; then
        printf "📦 Installing latest Bash...\n"
        brew install bash bash-completion
    fi
    if [[ -f "${HOME}/.bashrc" ]]; then
        export OX_SHELL=${HOME}/.bashrc
    elif [[ -f "${HOME}/.bash_profile" ]]; then
        export OX_SHELL=${HOME}/.profile
    fi
    echo 'export BASH_SILENCE_DEPRECATION_WARNING=1' >>"${OX_SHELL}"
    ;;
esac

###################################################
# Inject Oxidizer
###################################################

printf '⚙️ Adding Oxidizer into %s...\n' "${OX_SHELL}"

echo "# Oxidizer" >>"${OX_SHELL}"

if [[ -z ${OXIDIZER} ]]; then
    OXIDIZER="${HOME}/oxidizer"
    append_str='export OXIDIZER='${OXIDIZER}' && source '${OXIDIZER}'/oxidizer.sh'
else
    append_str='source '${OXIDIZER}'/oxidizer.sh'
fi

echo "${append_str}" >>"${OX_SHELL}"

printf "⚙️ Adding Custom settings..."
if [[ ! -f "${OXIDIZER}/"custom.json ]]; then
    cp "${OXIDIZER}"/default.json "${OXIDIZER}/"custom.json
fi
if [[ ! -f "${OXIDIZER}/"custom.sh ]]; then
    cp "${OXIDIZER}"/default.sh "${OXIDIZER}/"custom.sh
fi

# load zoxide
sd '.* OX_STARTUP=.*' 'export OX_STARTUP=1' "${OXIDIZER}"/custom.sh
# set path of oxidizer
# echo "source OXIDIZER=${OXIDIZER}/oxidizer.sh" | xargs -I '{}' sd '' 'source OXIDIZER=.*' '{}' ${OX_SHELL}
# echo $(cat ${OX_SHELL} | rg -o 'source .+')

###################################################
# Load Plugins
###################################################

git clone --depth=1 https://github.com/ivaquero/oxplugins.git "${OXIDIZER}"/plugins

###################################################
# Editor
###################################################

printf "🎉 Oxidizer installation complete!\n"
printf "💡 Don't forget to restart your terminal and hit 'edf ox' to tweak your preferences.\n"
printf "😀 Finally, run 'upox' function to activate the plugins. Enjoy!\n"
