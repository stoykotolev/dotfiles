function dcl --wraps='docker compose logs -f' --description 'alias dcl docker compose logs -f'
  docker compose logs -f $argv
        
end
