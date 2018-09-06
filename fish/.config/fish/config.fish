. ~/.config/fish/aliases.fish


function dotfiles
    git pull ~/.dotfiles
    stow -d ~/.dotfiles (ls -1  -d ~/.dotfiles/*/ | tr '\n' '\0' | xargs -0 -n 1 basename)
end


function dri
    docker rmi $argv (docker images -q);
end

function drc
    docker rm (docker ps -q -a);
end

function drv
    docker volume rm (docker volume ls -q)
end