#!/usr/bin/env sh

set -e

if ! sudo -v; then
  echo "Superuser not granted, aborting installation"
  exit 1
fi

function eval_brew() {
    eval "$(/opt/homebrew/bin/brew shellenv)" > /dev/null
}

REPO_URL=https://github.com/stoykotolev/dotfiles.git
INSTALL_PATH=$HOME/.config

if ! eval_brew; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval_brew
fi
brew install git &> /dev/null

if ! test -e "$HOME/.config/"; then
    git clone $REPO_URL $INSTALL_PATH --recurse-submodules > /dev/null
else
    git --git-dir $INSTALL_PATH/.git pull > /dev/null
fi

$INSTALL_PATH/setup.sh
Footer
