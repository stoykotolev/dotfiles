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

CONFIG=$HOME/.config

mkdir -p $CONFIG

symlink $CONFIG/zshrc $HOME/.zshrc
symlink $CONFIG/tmux/tmux.conf $HOME/.tmux.conf
log_end "Dotfile symlinks created"
echo

log_start "Installing 'brew' and dependencies from 'Brewfile'"
if ! eval_brew; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   
    eval_brew

    log_end 'Brew installed'
else
    log_end 'Brew detected'
fi
brew bundle --file $DOT/Brewfile
echo

osascript -e '
tell application "System Events"
    tell dock preferences
	set properties to {autohide:true,screen edge:bottom}
    end tell
end tell'
defaults write com.apple.dock autohide-delay -float 0
killall Dock
log_end "Dock configured"
echo

log_start "Installing Rust"
if ! command -v rustc &> /dev/null; then
    rustup-init -y
    log_end "Rust installed"
else
    rustc -V
    log_end "Rust detected"
fi

echo

log_start "Installing NodeJS"
if ! command -v node &> /dev/null; then
    fnm use 16 --install-if-missing
    log_end "NodeJS installed"
else
    node -v
    log_end "NodeJS detected"
fi
echo

log_start "Configuring neovim"
if ! test -e $CONFIG/nvim; then
    symlink $DOT/nvim $CONFIG
    log_end "nvim config setup"
else
    log_end "nvim config detected"
fi

# Install packer
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &> /dev/null
# Install plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &> /dev/null
log_end "packer.nvim plugins synced"

echo
