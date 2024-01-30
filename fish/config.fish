# Set environment variables
set -g fish_greeting ""
set -gx TERM xterm-256color

set PATH $PATH ~/.cargo/bin
set -x GO_PATH ~/go
set -Ux NPM_TOKEN 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
fish_add_path /opt/homebrew/bin

alias mydocker 'docker build -t mydocker . && docker run --cap-add="SYS_ADMIN" mydocker'

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

function typeorm
  npm run typeorm:$argv[1]
end

function cat 
  bat $argv
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
alias gcan "git commit --amend --no-edit"
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

set -gx PATH "/Users/stoykotolev/Library/Caches/fnm_multishells/63072_1698222515583/bin" $PATH;
set -gx FNM_MULTISHELL_PATH "/Users/stoykotolev/Library/Caches/fnm_multishells/63072_1698222515583";
set -gx FNM_DIR "/Users/stoykotolev/Library/Application Support/fnm";
set -gx FNM_VERSION_FILE_STRATEGY "local";
set -gx FNM_COREPACK_ENABLED "false";
set -gx FNM_RESOLVE_ENGINES "false";
set -gx FNM_LOGLEVEL "info";
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -gx FNM_ARCH "arm64";
function _fnm_autoload_hook --on-variable PWD --description 'Change Node version on directory change'
    status --is-command-substitution; and return
    if test -f .node-version -o -f .nvmrc
    fnm use --silent-if-unchanged
end

end

_fnm_autoload_hook
