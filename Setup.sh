#!/usr/bin/env bash
#Script de pos instalação...
#Variaveis (Edite conforme a distro ou interface desejada).
BASE="git curl nano wget ark unzip zip unrar redshift openssh ufw gparted dosfstools python python-pip android-tools usbutils gvfs gvfs-mtp ufw xdg-user-dirs fastfetch"
LOGIN="lxdm"
UTILITARIOS="mpv syncthing dialog audacious"
I3="i3-wm polybar picom rofi flameshot dunts lxappearance pacman-contrib polkit-gnome"
ARQUIVOS="thunar thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin 
thunar-vcs-plugin thunar-volman"
FONTS="ttf-terminus-nerd ttf-ubuntu-nerd ttf-jetbrains-mono-nerd ttf-inconsolata-nerd tf-ibmplex-mono-nerd ttf-hack-nerd ttf-firacode-nerd"
XFCE="tint2 xfwm4-themes xfdesktop xfce4-whiskermenu-plugin xfce4-settings xfce4-session xfce4-screenshooter xfce4-mixer xfce4-screensaver xfce4-pulseaudio-plugin xfce4-power-manager"
YAY="nitrogen"
FLATPAK="kodi freedownloadmanager jdownloader2"
check() {
if [ "$?" -ne 0 ]; then
echo "ERRO: $1"
exit 1
fi
}
#Instalação de desktop
echo "Atualizando & instalando pacotes"
sudo pacman -Syu
check "Erro ao Atualizar"
echo "Atualizado com sucesso, instalando pacotes"

echo"Ambiente Grafico"
echo "1-XFCE"
echo "2-I3WM"
read -p "Escolha um ambiente :" opcao

case $opcao in
1)
echo "Instalando XFCE"
sudo pacman -S --noconfirm $BASE $XFCE $FONTS $LOGIN $ARQUIVOS $UTILITARIOS || true
sudo systemctl enable lxdm
xdg-user-dirs-update
check "Erro ao instalar XFCE"
echo "XFCE Instalado"
;;
2)
echo "Instalando I3-WM"
sudo pacman -S --noconfirm $BASE $I3 $FONTS $LOGIN $ARQUIVOS $UTILITARIOS || true
sudo systemctl enable lxdm
xdg-user-dirs-update
check "Erro ao instalar I3WM"
echo "I3WM Instalado"
sleep 0.5S
echo "Instalado Programas Aur (Yay)"
yay -S --noconfirm $YAY
check "Erro ao instalar programas via Aur (Yay)"
echo "Programas via Aur (Yay) Instalados"
esac

#Programas via Flatpak
echo "Instalado Programas Flatpak"
flatpak install -y flathub $FLATPAK
check "Erro ao instalar Flatpak"
echo "Programas via Flatpak Instalados"

echo "            Instalação Concluida  			   "
echo "====================================="
read -p "Deseja reiniciar agora? (s/n)" reiniciar
if [ "$reiniciar" = "s" ]; then
echo "Reiniciando em 10s"
sleep 10s 
sudo systemctl reboot
else
echo "Ok, saindo do script" 
exit 1
fi
