#
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[90m\]\h\[\e[0m\] \[\e[$([ "$EUID" -eq 0 ] && echo 31 || echo 90)m\]\$\[\e[0m\] ❯ '
[[ -r /usr/share/bash-completion/bash_completion ]] && \
  source /usr/share/bash-completion/bash_completion

#Arch

alias pesquisar='sudo pacman -Ss'
alias instalar='sudo pacman -S --noconfirm'
alias remover='sudo pacman -Rns --noconfirm'
alias pesquisary='yay -Ss'
alias instalary='yay -S --noconfirm'
alias removery='yay -Rns --noconfirm'
alias atualizar='sudo pacman -Syu --noconfirm'
alias tempo="sudo tune2fs -l /dev/sda2 | grep 'Filesystem created:'"

alias config.ini='sudo micro ~/.config/polybar/config.ini'
alias config='sudo micro ~/.config/i3/config'

#Git

acp() {
    [ $# -eq 0 ] && echo "Coloca alguma coisa viado..." && return 1
    git add .
    git commit -m "$*"
    git push
}

alias gpull='git pull origin main'

