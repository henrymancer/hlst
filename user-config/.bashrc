#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\e[38;5;129m┌─[\e[0m\e[1;33m\u\e[0m\e[1;36m@\e[0m\e[1;33m'$HOSTNAME'\e[0m\e[38;5;129m]─[\e[0m\e[1;34m\w\e[0m\e[38;5;129m\e[38;5;129m─[\e[0m\e[0;31m\A\e[0m\e[38;5;129m]\e[0m\n\e[38;5;129m└─[\e[0m\e[1;37m$\e[0m\e[38;5;129m]› \e[0m '
