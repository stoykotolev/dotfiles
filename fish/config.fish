# Set environment variables
set -g fish_greeting ""
set -gx TERM xterm-256color

set PATH $PATH ~/.cargo/bin
set -x GO_PATH ~/go

# Set OpenJDK path
set -x PATH /opt/homebrew/opt/openjdk/bin $PATH

# Check for pyenv and initialize if available
if command -q pyenv
    eval (pyenv init - | source)
end

# General Aliases
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
alias build "npm run build"
alias dev "npm run dev"
alias d "z"
alias maelstrom "~/maelstrom/maelstrom"

command -qv nvim && alias v nvim

function dev
  if test -n "$argv[1]" -a "$argv[1]" = "start"
      npm run start:dev
  else
      npm run dev
  end
end


### GIT ### 
function git_current_branch
    set ref (__git_prompt_git symbolic-ref --quiet HEAD ^ /dev/null)
    if test $status -ne 0
        if test $status -eq 128
            return
        end
        set ref (__git_prompt_git rev-parse --short HEAD ^ /dev/null)
        if test $status -ne 0
            return
        end
    end
    echo (string sub -i 11 $ref)
end

function git_main_branch
    if test -d (git rev-parse --git-dir)
        for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}
            if git show-ref -q --verify $ref
                echo (string sub -i 11 $ref)
                return
            end
        end
    end
    echo "master"
end

function git_develop_branch
    if test -d (git rev-parse --git-dir)
        for branch in dev devel development
            if git show-ref -q --verify refs/heads/$branch
                echo $branch
                return
            end
        end
    end
    echo "develop"
end


# GitHub Aliases
alias g "git"
alias gst "git status"
alias gcmsg "git commit -m"
alias gsw "git switch"
alias gswc "git switch --create"
alias gswm "git switch (git_main_branch) && git pull"
alias gswd "git switch (git_develop_branch) && git pull"
alias gac "git add -p"
alias ga "git add"
alias glog "git log --oneline --decorate --graph"
alias gl "git pull"
alias gp "git push"
alias gpsup "git push --set-upstream origin (git_current_branch)"
alias gf "git fetch"
alias gco "git checkout"
alias gdiff "git diff --name-only --diff-filter=U --relative"
alias sb "find . -type d -name '.git' -exec echo {} \; -exec sh -c 'cd {} && git branch --show-current' \;"
alias gmd "git fetch --all && git merge (git_develop_branch)"
alias gmm "git fetch --all && git merge (git_main_branch)"
alias mp "find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull"


# Tmux Aliases
alias t "tmux"
alias tls "tmux ls"
alias tkl "tmux kill-server"
alias config "tmux new -A -s config"
alias mart "tmux new -A -s mart"
alias personal "tmux new -A -s personal"
alias rust "tmux new -A -s rust"
alias tgo "tmux new -A -s tgo"
alias dsa "tmux new -A -s dsa"
alias work "tmux new -A -s work"

# Rust Aliases
alias caf "cargo add $argv[1] --features $argv[2]"

# Zoxide
zoxide init fish | source

# Starship
starship init fish | source
