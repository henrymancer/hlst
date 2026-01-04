#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PURPLE='\[\e[38;5;129m\]'
YELLOW='\[\e[1;33m\]'
CYAN='\[\e[1;36m\]'
BLUE='\[\e[1;34m\]'
RED='\[\e[0;31m\]'
WHITE='\[\e[1;37m\]'
RESET='\[\e[0m\]'

PS1="${PURPLE}┌─[${RESET}${YELLOW}\u${RESET}${CYAN}@${RESET}${YELLOW}${HOSTNAME}${RESET}${PURPLE}]─[${RESET}${BLUE}\w${RESET}${PURPLE}]─[${RESET}${RED}\A${RESET}${PURPLE}]${RESET}\n${PURPLE}└─[${RESET}${WHITE}\\\$${RESET}${PURPLE}]› ${RESET} "
