function dcb --wraps='docker compose up --build' --description 'alias dcb docker compose up --build'
  docker compose up --build $argv
        
end
