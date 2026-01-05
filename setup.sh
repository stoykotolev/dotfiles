#!/bin/bash

# This has all been taken from Brendonovich's configuration
# which you can find here - https://github.com/Brendonovich/.dotfiles/blob/master/setup.sh
trap "exit" INT

# https://gist.github.com/vratiu/9780109
Color_Off="\033[0m"       # Text Reset
Black="\033[0;30m"        # Black
Red="\033[0;31m"          # Red
Green="\033[0;32m"        # Green
Yellow="\033[0;33m"       # Yellow
Blue="\033[0;34m"         # Blue
Purple="\033[0;35m"       # Purple
Cyan="\033[0;36m"         # Cyan
White="\033[0;37m"        # White

CONFIG=$HOME/.config

function cmd_missing() {
    if command -v $1 > /dev/null; then
        false
    else
        true
    fi
}

function symlink() {
    ln -sf $1 $2
}

function log_start() {
    echo -e "${Blue}$1${Color_Off}"
}

function log_end() {
    echo -e "${Green}$1${Color_Off}"
}

function eval_brew() {
    eval "$(/opt/homebrew/bin/brew shellenv)" > /dev/null
}

function setup_brew() {
    log_start "Installing 'brew' and dependencies from 'Brewfile'"
    if ! eval_brew; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        eval_brew

        log_end 'Brew installed'
    else
        log_end 'Brew detected'
    fi
    brew bundle --file $CONFIG/Brewfile
    echo
}

function setup_dock() {
    osascript -e '
    tell application "System Events"
        tell dock preferences
            set properties to {autohide:true,screen edge:bottom}
        end tell
    end tell'
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true
    killall Dock
    log_end "Dock configured"
    echo
}

function setup_rust() {
    log_start "Installing Rust"
    if ! command -v rustc &> /dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        log_end "Rust installed"
    else
        rustc -V
        log_end "Rust detected"
    fi
    echo
}

function setup_shell() {
    log_start "Setting up fish as default shell"
    if [ -x "/opt/homebrew/bin/fish" ]; then
        FISH="/opt/homebrew/bin/fish"
    elif [ -x "/usr/local/bin/fish" ]; then
        FISH="/usr/local/bin/fish"
    elif command -v fish >/dev/null 2>&1; then
        FISH="$(command -v fish)"
    else
        log_end "Fish not found. Install it first (e.g.,: brew install fish)."
    fi

    # Ensure fish is listed in /etc/shells (required for chsh on macOS)
    if ! grep -qx "$FISH" /etc/shells; then
        echo "Adding $FISH to /etc/shells (requires sudo)..."
        # Use tee so it works with sudo redirection
        printf "%s\n" "$FISH" | sudo tee -a /etc/shells >/dev/null
    fi

    # Change default shell for current user
    chsh -s "$FISH"

    log_end "Fish setup as default shell"
    echo
}

mkdir -p $CONFIG

# Create symlink for tmux config and hammerspoon
symlink $CONFIG/tmux/tmux.conf $HOME/.tmux.conf
symlink $CONFIG/.hammerspoon/ $HOME/.hammerspoon/
log_end "Dotfile symlinks created"
echo

setup_brew
setup_dock
setup_shell
setup_rust
