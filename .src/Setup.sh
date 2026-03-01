#!/usr/bin/env bash
#Script de pos instalação...
#Variaveis (Edite conforme a distro ou interface desejada).
BASE=("git" "curl" "nano" "wget" "ark" "unzip" "zip" "unrar" "redshift" "openssh" "ufw" "gparted" "dosfstools" "python" "python-pip" "android-tools" "usbutils" "gvfs" "gvfs-mtp" "xdg-user-dirs" "fastfetch" "bluez" "bluez-utils" "bluez-tools" "blueman")
LOGIN=("lxdm")
UTILITARIOS=("firefox" "alacritty" "kate" "mpv" "dialog" "flatpak" "rsync" "kodi" "gimp")
ARQUIVOS=("thunar" "thunar-archive-plugin" "thunar-media-tags-plugin" "thunar-shares-plugin"
"thunar-vcs-plugin" "thunar-volman")
FONTS=("ttf-terminus-nerd" "ttf-ubuntu-nerd" "ttf-jetbrains-mono-nerd" "ttf-inconsolata-nerd" "ttf-ibmplex-mono-nerd" "ttf-hack-nerd" "ttf-firacode-nerd")
OPENBOX=("openbox" "obconf-qt" "flameshot" "dunst" "lxappearance" "sxhkd" "xdotool" b"picom" "network-manager-applet")
YAY=("nitrogen" "apple-fonts" "lxappearance-obconf")
XFCE=("xfce4-panel-profiles" "xfce4-power-manager" "xfce4-pulseaudio-plugin" "xfce4-screensaver" "xfce4-windowck-plugin" "xfconf" "xfce4-panel" "xfce4-whiskermenu-plugin" "xfce4-settings" "xfce4-clipman-plugin" "xfce4-notifyd" "tumbler")
LOG="falhas_$(date +%Y-%m-%d).log"
check() {
if [ "$?" -ne 0 ]; then
echo "ERRO: $1"
exit 1
fi
}
#Detectar gerenciador de pacotes
GERENCIADORES=("pacman" "apt-get" "dnf" "xbps-install")

for gen in "${GERENCIADORES[@]}"; do
    if command -v "$gen" >/dev/null 2>&1; then
        PKG="$gen"
        break
    fi
done

if [[ -z $PKG ]]; then
    echo "Nenhum gerenciador suportado encontrado."
    exit 1
fi

case "$PKG" in
    pacman)
        INSTALL_CMD=(sudo pacman -S --needed --noconfirm)
        ;;
    apt-get)
        INSTALL_CMD=(sudo apt-get install -y)
        ;;
    dnf)
        INSTALL_CMD=(sudo dnf install -y)
        ;;
    xbps-install)
        INSTALL_CMD=(sudo xbps-install -Sy)
        ;;
esac

echo "Instalando Sistema"
> "$LOG"

for pkg in "${BASE[@]}" "${UTILITARIOS[@]}" "${ARQUIVOS[@]}" \
           "${LOGIN[@]}" "${OPENBOX[@]}" "${XFCE[@]}" "${FONTS[@]}"; do

    if ! "${INSTALL_CMD[@]}" "$pkg" 2>>"$LOG"; then
        echo "$pkg" >> "$LOG"
    fi
done

xdg-user-dirs-update
check "Erro ao instalar Sistema"
echo "Sistema Instalado!"

#Pacotes via Aur
echo "Instalado Programas Aur (Yay)"
if command -v yay >/dev/null 2>&1; then
    yay -S --noconfirm "${YAY[@]}"
fi
check "Erro ao instalar programas via Aur (Yay)"
echo "Programas via Aur (Yay) Instalados"

#Logs
if [[ -s "$LOG" ]]; then
    echo
    echo "Pacotes que falharam:"
    cat "$LOG"
else
    echo
    echo "Todos os pacotes foram instalados com sucesso."
    rm -f "$LOG"
fi

#Habilitando gerenciador de login
if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl enable lxdm
elif command -v sv >/dev/null 2>&1; then
    sudo ln -s /etc/sv/lxdm /var/service/
fi

#SSH
echo "Habilitando SSH!"
if command -v systemctl >/dev/null 2>&1; then
    if systemctl list-unit-files | grep -q '^sshd.service'; then
        sudo systemctl enable --now sshd
    else
        sudo systemctl enable --now ssh
    fi
elif command -v sv >/dev/null 2>&1; then
    [ -d /etc/sv/sshd ] && sudo ln -sf /etc/sv/sshd /var/service/
fi

echo "Configurando Firewall..."

if command -v ufw >/dev/null 2>&1; then
    sudo ufw allow ssh
    sudo ufw --force enable
    sudo ufw status
else
    echo "ufw nao instalado."
fi

echo "            Instalação Concluida  			   "
echo "====================================="
read -p "Deseja sair? (s/n)" sair
if [ "$sair" = "SsYy" ]; then
echo "Tchau..."
exit 1
fi
