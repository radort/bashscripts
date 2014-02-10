alias l='ls -lAh'
alias dmesg='dmesg --color'
alias x='sudo -i'
alias pls='sudo $(history -p !!)'
alias md=mkdir
alias -- -='cd -'
alias :e=vim
alias cal='cal -m'

[ $EUID == 0 ] &&
PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W \[\033[33m\]\$([ \$? == 0 ] && echo '^^' || echo ':(')\[\033[34m\] \$\[\033[00m\] " ||
PS1="\[\033[01;04;32m\]\u\[\033[00;01;32m\]@\h\[\033[01;34m\] \w \[\033[33m\]\$([ \$? == 0 ] && echo '^^' || echo ':(')\[\033[34m\] \$\[\033[00m\] "

export EDITOR=vim
export HISTCONTROL=ignoredups:erasedups

shopt -s autocd
