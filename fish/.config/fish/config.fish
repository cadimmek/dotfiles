. ~/.config/fish/aliases.fish


function dri
    docker rmi $argv (docker images -q);
end

function drc
    docker rm (docker ps -q -a);
end

function drv
    docker volume rm (docker volume ls -q)
end
