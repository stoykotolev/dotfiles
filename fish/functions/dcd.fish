function dcd --wraps='docker compose down' --description 'alias dcd docker compose down'
  docker compose down $argv
        
end
