#!/usr/bin/env bash
alias _="sudo"

alias cls='clear'

alias edit="$EDITOR"

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Print all broken symlinks
alias broken='find -xtype l -print'

# List declared functions
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"

alias externalip="dig +short myip.opendns.com @resolver1.opendns.com"


