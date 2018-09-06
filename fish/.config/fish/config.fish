. ~/.config/fish/aliases.fish


function fish_prompt
    set last_status $status

    echo ' '

    set user (whoami)

    set_color magenta
    printf '%s' $user
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname -s)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')
    set_color normal

    git_prompt
    virtualenv_prompt

    set_color normal
    printf ' (%s)' (date +%H:%M)
    echo

    #if test $last_status -eq 0
    #    set_color white -o
    #    printf '><((°> '
    #else
    #    set_color red -o
    #    printf '><((ˣ> '
    #    set_color white -o
    #    printf '[%d] ' $last_status
    #end

    if test $last_status -ne 0
        set_color white -o
        printf '[%d] ' $last_status
        set_color normal
    end
    printf '$ '

    set_color normal
end
