# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Custom Neon Cyberpunk Prompt
export PS1='\[\e[1;34m\]┌─[\[\e[1;32m\]\u\[\e[1;37m\]@\[\e[1;36m\]\h\[\e[1;34m\]] - [\[\e[1;37m\]\w\[\e[1;34m\]] - [\[\e[1;33m\]\D{%Y-%m-%d %H:%M:%S}\[\e[1;34m\]]\n\[\e[1;34m\]└─[\[\e[1;35m\]$?\[\e[1;34m\]] \[\e[0m\]'
