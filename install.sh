#!/bin/bash


prompt_confirm() {
  while true; do
    print_question "${1:-Continue?} [y/n]: "
    read REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid option"
    esac
  done
}

print_error() {
    # Print output in red
    printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
    # Print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

print_warning() {
    # Print output in purple
    printf "\n\e[0;33m $1\e[0m"
}

print_question() {
    # Print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

print_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

print_result() {
    [[ $1 -eq 0 ]] \
        && print_success "$2" \
        || print_error "$2"

    [[ "$3" == "true" ]] && [[ $1 -ne 0 ]] \
        && exit
}

execute() {
    $1 &> /dev/null
    print_result $? "${2:-$1}"
}

cmd_exists() {
    [[ -x "$(command -v "$1")" ]] && printf 0 || printf 1
}


backup_dotfiles() {
cd || exit
shopt -s dotglob
for file in ./*rc ./*profile tmux.conf; do
    [[ -e ${file} ]] || continue
    mkdir -pv bak
    mv "$file" bak/
done
}

reload_shell() {
    case "$SHELL" in
    "/usr/bin/fish" )
           source ~/fish/config.fish
        ;;
    "/bin/bash")
        	source ~/.bash_profile;
        ;;

    *)
        exit 0
    esac
}

print_info  "WARNING! This script will backup existing dotfiles to ${HOME}/bak\n"
prompt_confirm "Do you wish to continue?" || exit 0

sleep .5
execute "cmd_exists stw" "Check if stow command exists"
execute "backup_dotfiles" "Backing up existing dotfiles..."
execute "git -C ${HOME}/.dotfiles pull origin master" "Updating .dotfiles"
execute "stow -d ${HOME}/.dotfiles $(ls -1 -d ${HOME}/.dotfiles/*/ | tr '\n' '\0' | xargs -0 -n 1 basename)" "Create symlinks"
execute "reload_shell" "Reloading shell"
