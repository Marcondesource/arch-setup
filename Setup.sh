#!/usr/bin/env bash
{
#Script de pos instalação...
#Variaveis (Edite conforme a distro ou interface desejada).
BASE="git curl nano wget ark unzip zip redshift openssh ufw gparted dosfstools python python-pip android-tools usbutils
gvfs gvfs-mtp xdg-user-dirs"
XFCE="xfwm4 xfdesktop xfconf xfce4-whiskermenu-plugin xfce4-terminal xfce4-taskmanager xfce4-session 
xfce4-settings xfce4-screenshooter xfce4-screensaver xfce4-pulseaudio-plugin xfce4-power-manager xfce4-clipman-plugin 
xfce4-panel xfce4-notifyd xfce4-mpc-plugin tumbler"
LOGIN="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
LOGIN_I3="ly"
UTILITARIOS="geany mpv"
OUTROS="firefox firefox-i18n-pt-br"
I3="3-wm polybar picom lxappearance pacman-contrib polkit-gnome"
ARQUIVOS="thunar thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin 
thunar-vcs-plugin thunar-volman ark unzip"

echo "Atualizando & instalando pacotes"
sudo pacman -Syu  
if [ "$?" -eq 0 ]; then
echo "Atualizado com sucesso, instalando pacotes"
else
echo "Erro ao atualizar"
exit 1
fi 

echo "             Interfaces  			   "
echo "====================================="
echo "1-Xfce4"
echo "2-I3-WM"
echo "====================================="
read -p "Qual interface voce vai utilizar?" opcao

case $opcao in
    1) 
      echo "Instalando Xfce4"
sudo pacman -S --noconfirm $BASE $XFCE $LOGIN $ARQUIVOS $UTILITARIOS $OUTROS 
sudo systemctl enable lightdm
if [ "$?" -eq 0 ]; then
echo "Pacotes Instalados"
else
echo "Erro ao instalar pacotes"
exit 1
fi 
;;
   2) 
	echo "Instalando I3-WM"
sudo pacman -S --noconfirm $BASE $I3 $LOGIN_I3 #ARQUIVOS $UTILITARIOS $OUTROS 
sudo systemctl enable ly
if [ "$?" -eq 0 ]; then
echo "Pacotes Instalados"
else
echo "Erro ao instalar pacotes"
exit 1
fi 
;;
	*)
	  echo "Opção invalida"
exit 1
;;
esac

#Instalando pacotes via Yay (Modifique conforme seu uso...)
echo "Instalando pacotes via Yay"
yay -S --noconfirm jdownloader2 freedownloadmanager
if [ "$?" -eq 0 ]; then
echo "Pacotes instalados"
else
echo "Erro ao instalar pacotes"
exit 1
fi 

#Configurando.....
echo "Checando se o Firefox esta instalado"
if command -v firefox &> /dev/null; then 
echo "sim o Firefox esta instalado, configurando"
else
echo "Firefox não instalado"
exit 1
fi 

echo "Configurando Firefox"
mkdir -p ~/.config
cp -R configs/.mozilla ~/.config
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 

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
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 

echo "Configurando Xorg"
sudo cp configs/xorg.conf /etc/X11 
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 

echo "Configurando gtk"
cp -R configs/gtk-3.0 ~/.configs
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 

echo "Checando se o Geany esta instalado"
if command -v geany &> /dev/null; then
echo "sim o Geany esta instalado, configurando"
else
echo "Geany não instalado"
exit 1
fi
 
echo "Configurando Geany"
mkdir -p ~/.config/geany
cd /tmp
pwd
git clone https://github.com/geany/geany-themes.git
cd geany-themes
sudo cp -R colorschemes ~/.config/geany/
cd ..
rm -rf geany-themes

if [ "$?" -eq 0 ]; then
echo "Geany configurado"
else
echo "Erro ao configurar"
exit 1
fi

echo "Checando se o Kodi esta instalado"
if command -v geany &> /dev/null; then
echo "sim o Kodi esta instalado, configurando"
else
echo "Kodi não instalado"
exit 1
fi

echo "Configurando kodi"
sudo cp -R configs/.kodi/ ~/ 
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 
} | tee ~/Documentos/Install-logs.txt

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
