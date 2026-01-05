if status is-interactive
    # Commands to run in interactive sessions can go here
set -U fish_greeting ""
set -gx PATH $PATH /home/marcondes/.local/bin
oh-my-posh init fish --config /home/marcondes/.cache/oh-my-posh/themes/amro.omp.json | source
alias ls='ls --color=auto'
alias fetch='clear && fastfetch'

#Arch 
alias pesquisar='sudo pacman -Ss'
alias instalar='sudo pacman -S --noconfirm'
alias remover='sudo pacman -Rns --noconfirm'
alias pesquisary='yay -Ss'
alias instalary='yay -S --noconfirm'
alias removery='yay -Rns --noconfirm'
alias atualizar='sudo pacman -Syu --noconfirm'
alias tempo="sudo tune2fs -l /dev/sda2 | grep 'Filesystem created:'"

#Arquivos
alias config.ini='sudo micro .config/polybar/config.ini'
alias config='sudo micro .config/i3/config'

#Git 
function acp
    if test (count $argv) -eq 0
        echo "Coloca alguma coisa viado..."
        return 1
    end
    
    git add .
    git commit -m "$argv"
    git push
end
alias gpull='git pull origin main'  # ajusta pra sua branch padrão

# ssh-git
    eval (ssh-agent -c)
    ssh-add ~/.ssh/id_ed25519
end
