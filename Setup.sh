#!/usr/bin/env bash
#Script de pos instalação...
#Variaveis (Edite conforme a distro ou interface desejada).
BASE="git curl nano wget ark unzip zip unrar redshift openssh ufw gparted dosfstools python python-pip android-tools usbutils
gvfs gvfs-mtp xdg-user-dirs"
XFCE="xfwm4 xfdesktop xfconf xfce4-whiskermenu-plugin xfce4-terminal xfce4-taskmanager xfce4-session 
xfce4-settings xfce4-screenshooter xfce4-screensaver xfce4-pulseaudio-plugin xfce4-power-manager xfce4-clipman-plugin 
xfce4-panel xfce4-notifyd xfce4-mpc-plugin tumbler"
LOGIN="lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings"
LOGIN_I3="ly"
UTILITARIOS="mpv geany syncthing"
OUTROS="firefox firefox-i18n-pt-br"
I3="3-wm polybar picom lxappearance pacman-contrib polkit-gnome"
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
check "Erro ao instalar"
echo "Pacotes Instalados"
;;
   2) 
	echo "Instalando I3-WM"
sudo pacman -S --noconfirm $BASE $I3 $LOGIN_I3 #ARQUIVOS $UTILITARIOS $OUTROS 
sudo systemctl enable ly
check "Erro ao instalar"
echo "Pacotes Instalados"
;;
	*)
	  echo "Opção invalida"
exit 1
;;
esac

#Instalando pacotes via Yay (Modifique conforme seu uso...)
echo "Instalando pacotes via Yay"
yay -S --noconfirm jdownloader2 freedownloadmanager vscodium  
check "Erro ao Instalar"
echo "Pacotes instalados"

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
check "Erro ao Instalar" 
echo "Configurado"

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

echo "Configurando gtk"
cp -R configs/gtk-3.0 ~/.config
check "Erro ao Configurar"
echo "Configurado"

echo "Checando se o VSCodium esta instalado"
if command -v codium &> /dev/null; then
echo "sim o VSCodium esta instalado, configurando"
else
echo "VSCodium não instalado"
exit 1
fi
 
# Lista das extensões do VSCodium
EXTS=(
  "formulahendry.code-runner"
)

echo " Instalando extensões do VSCodium..."
for ext in "${EXTS[@]}"; do
  codium --install-extension "$ext"
done

check "Erro ao Instalar"
echo "Extensões instaladas!"

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
cp -R colorschemes ~/.config/geany/
cd ..
rm -rf geany-themes

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

case "$XDG_CURRENT_DESKTOP" in
i3)
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
gsettings set org.gnome.desktop.interface icon-theme "BluecurveRH"
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "volantes_light_cursors"
;; 
XFCE)
xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "BluecurveRH"
xfconf-query -c xfwm4 -p /general/theme -s "Nordic-darker-v40"
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "volantes_light_cursors"
;;
*)echo "Desktop não identificado, usando configurações genéricas"
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
gsettings set org.gnome.desktop.interface icon-theme "BluecurveRH"
gsettings set org.gnome.desktop.interface cursor-theme "volantes_light_cursors"
;;
esac
check "Erro ao Configurar"
echo "Configurado"

echo "configurando cores do terminal"
mkdir -p ~/.local/share/
cp -R configs/Gogh/ ~/.local/share/
export TERMINAL="xfce4-terminal"
export GOGH_NONINTERACTIVE="true" 
export GOGH_USE_NEW_THEME="true"
~/.local/share/gogh/themes/dracula.sh
check "Erro ao Configurar"
echo "Configurado"

echo "Instalando fontes"
FONTS=("JetBrainsMono" "Hack" "FiraCode" "Inconsolata")

for font in "${FONTS[@]}"; do
  oh-my-posh font install "$font" --user
done

check "Erro ao Instalar"
echo "Fontes instaladas"

fc-cache -fv

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

echo "Checando se o Fish esta instalado"
if command -v fish &> /dev/null; then 
echo "sim o Fish esta instalado, configurando"
else
echo "Fish não instalado"
exit 1
fi 

echo "Configurando Fish"
cp -R configs/fish/ ~/.config/
check "Erro ao Configurar"
echo "Fish configurado"

echo "Configurando Syncthing"
systemctl --user enable --now syncthing.service

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
