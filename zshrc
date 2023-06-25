source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export CONFIG=$HOME/.config
export ZSHRC=$CONFIG/zshrc
export BREWFILE=$CONFIG/Brewfile

export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

### This is needed because node-gyp
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

### Add case insensitive searches
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


### General Aliases ###
alias ..="cd ../"
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias history='fc -l 1'
alias l='ls -lah'
alias la='ls -lAh'
# alias ll='ls -lh'
alias l="exa -lah -g --icons --git"
alias lt="exa -1 --icons --tree --git-ignore"
alias ls='ls -G'
alias lsa='ls -lah'
alias md='mkdir -p'
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias regen="source ~/.zshrc"
alias rmd='rm -rf'
alias b='brew'
alias bi='brew install'
alias bic='brew install --cask'
alias cb="cargo build"
alias cr="cargo run"
alias build="npm run build"
alias dev="npm run dev"
alias tu='tilt up --namespace=`./scripts/namespace.sh`'
alias d="z"

# Multipreplace
function multireplace(){
for file in $1 
do 
  mv "$file" "${file/$2/$3}"
done

}



### Git Aliases
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}


# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}


### Github aliases ###
alias g="git"
alias gst="git status"
alias gcmsg="git commit -m"
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(git_main_branch) && git pull'
alias gswd='git switch $(git_develop_branch) && git pull'
alias gac="git add -p"
alias ga="git add"
alias glog='git log --oneline --decorate --graph'
alias gl='git pull'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gf='git fetch'
alias gco='git checkout'
alias gdiff='git diff --name-only --diff-filter=U --relative'
alias sb="find . -type d -name '.git' -exec echo {} \; -exec git -C {} branch \;"
alias gmd='git fetch --all && git merge $(git_develop_branch)'
alias gmm='git fetch --all && git merge $(git_main_branch)'
alias mp='find . -maxdepth 3 -name .git -type d | rev | cut -c 6- | rev | xargs -I {} git -C {} pull'

### tmux aliases ###
alias t='tmux'
alias tls='tmux ls'
alias tkl='tmux kill-server'
alias config='tmux new -A -s config'
alias mart='tmux new -A -s mart'
alias personal='tmux new -A -s personal'
alias rust='tmux new -A -s rust'
alias dsa='tmux new -A -s dsa'
alias work='tmux new -A -s work'


# Remove all local docker images
rd(){
docker system prune -a
docker image prune
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export STARSHIP_CONFIG=$CONFIG/starship.toml
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


