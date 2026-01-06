#!/usr/bin/env bash
#Script de pos instalação...
#Variaveis (Edite conforme a distro ou interface desejada).
BASE="git curl nano wget ark unzip zip unrar redshift openssh ufw gparted dosfstools python python-pip android-tools usbutils
gvfs gvfs-mtp xdg-user-dirs fastfetch"
LOGIN="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
UTILITARIOS="chromium mpv geany kodi qemu-desktop syncthing dialog audacious"
I3="i3-wm polybar picom rofi lxappearance pacman-contrib polkit-gnome"
ARQUIVOS="thunar thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin 
thunar-vcs-plugin thunar-volman"
check() {
if [ "$?" -ne 0 ]; then
echo "ERRO: $1"
exit 1
fi
}

{
echo "Atualizando & instalando pacotes"
sudo pacman -Syu  
check "Erro ao Atualizar"
echo "Atualizado com sucesso, instalando pacotes"

echo "Instalando I3-WM"
sudo pacman -S --noconfirm $BASE $I3 $LOGIN $ARQUIVOS $UTILITARIOS || true
sudo systemctl enable lightdm
check "Erro ao instalar"
echo "Pacotes Instalados"

#Instalando pacotes via Yay (Modifique conforme seu uso...)
echo "Instalando pacotes via Yay"
if command -v yay &>/dev/null; then
yay -S --noconfirm jdownloader2 freedownloadmanager 
else
echo "yay não instalado, pulando AUR"
fi
check "Erro ao Instalar"
echo "Pacotes instalados"

#Configurando.....

echo "Checando se o Fastfetch esta instalado"
if command -v fastfetch &> /dev/null; then
echo "sim o Fastfetch esta instalado, configurando"
else
echo "Fastfetch não instalado"
exit 1
fi 

echo "Configurando Fastfetch"
mkdir -p ~/.config/fastfetch
cp configs/config.jsonc ~/.config/fastfetch
check "Erro ao Configurar" 
echo "Configurado"

echo "Configurando Xorg"
sudo cp configs/xorg.conf /etc/X11 
check "Erro ao Configurar"
echo "Configurado"

echo "Checando se o Kodi esta instalado"
if command -v kodi &> /dev/null; then
echo "sim o Kodi esta instalado, configurando"
else
echo "Kodi não instalado"
exit 1
fi

echo "Configurando kodi"
cp -R configs/.kodi/ ~/ 
check "Erro ao Configurar"
echo "Configurado"

echo "Configurandos temas"
sudo mkdir -p /usr/share/themes
sudo mkdir -p /usr/share/icons
sudo mkdir -p /usr/share/backgrounds
cd configs/Themes
sudo cp -R * /usr/share/themes 
cd ../
cd Icons/
sudo cp -R * /usr/share/icons
cd ../
sudo cp -R Wallpapers/ /usr/share/backgrounds
cd ../

echo "Checando se o Rofi esta instalado"
if command -v rofi &> /dev/null; then 
echo "sim o Rofi esta instalado, configurando"
else
echo "Rofi não instalado"
exit 1
fi 

echo "Configurando Rofi"
mkdir -p ~/.config/rofi/themes
cd configs/themes/
cp *.rasi ~/.config/rofi/themes/
cd ../../
ln -sf ~/.config/rofi/themes/arc-dark.rasi ~/.config/rofi/config.rasi
check "Erro ao Configurar"
echo "Rofi configurado"

echo "Configurando makepkg"
sudo cp configs/makepkg.conf /etc/ 
check "Erro ao Configurar"
echo "Makepkg configurado"

echo "Configurando Qemu"
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
check "Erro ao Configurar"
echo "Qemu configurado"

echo "Configurando Firewall"
sudo ufw enable
sudo ufw allow 22
sudo ufw allow ssh
sudo ufw status  
check "Erro ao Configurar"
echo "Firewall configurado"
} 2>&1 | tee "$HOME/Documentos/Install-logs.txt"
echo "            Instalação Concluida  			   "
echo "====================================="
echo "Os logs foram salvos em ~/Documentos"
echo "====================================="
read -p "Reiniciar agora? (s/n)" reiniciar
if [ "$reiniciar" = "s" ]; then
echo "Reiniciando em 10s"
sleep 10s 
sudo systemctl reboot
else
echo "Ok, saindo do script" 
exit 1
fi
