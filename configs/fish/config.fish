if status is-interactive
    # Commands to run in interactive sessions can go here
set -gx PATH $PATH /home/marcondes/.local/bin
oh-my-posh init fish --config /home/marcondes/.cache/oh-my-posh/themes/amro.omp.json | source
alias ls='ls --color=auto'
alias fetch='clear && fastfetch'

#Arch 
alias pesquisar='sudo pacman -Ss'
alias instalar='sudo pacman -S --noconfirm'
alias remover='sudo pacman -Rns --noconfirm'
alias pesquisary='yay -Ss'
alias instalary='yay -S'
alias removery='yay -Rns'
alias atualizar='sudo pacman -Syu'

#Arquivos
alias config.ini='sudo micro .config/polybar/config.ini'
alias config='sudo micro .config/i3/config'

#Git 
alias ga='git add .'
alias commit='git commit -m'
alias gp='git push'
alias gpull='git pull origin main'  # ajusta pra sua branch padrão
end
