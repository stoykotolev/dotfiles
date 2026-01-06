# Set environment variables
set -g fish_greeting ""
set -gx TERM xterm-256color

fish_add_path ~/.cargo/bin /opt/homebrew/bin

# General Aliases
alias .. "cd .."
alias ... "cd ../../"
alias .... "cd ../../../"
alias l "eza -lah -g --icons --git"
alias lt "eza -1 --icons --tree --git-ignore"
alias ls "eza -G"
alias lsa "eza -lah"
alias md "mkdir -p"
alias regen "source ~/.config/fish/config.fish"
alias rmd "rm -rf"
alias b "brew"
alias bi "brew install"
alias bic "brew install --cask"
alias cb "cargo build"
alias cr "cargo run"
alias d "z"
alias maelstrom "~/maelstrom/maelstrom"

command -qv nvim && alias v nvim

function cat
  bat $argv
end

# Git CLI aliases
alias gc "gh pr create"
alias gcb "gh pr create -B"

# Tmux Aliases
alias t "tmux"
alias tls "tmux ls"
alias tkl "tmux kill-server"
alias config "tmux new -A -s config"
alias mart "tmux new -A -s mart"
alias p "tmux new -A -s personal"

# Rust Aliases
alias caf "cargo add $argv[1] --features $argv[2]"

# Zoxide
zoxide init fish | source

# Starship
starship init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
