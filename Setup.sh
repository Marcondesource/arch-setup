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
UTILITARIOS="mpv geany"
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
yay -S --noconfirm jdownloader2 freedownloadmanager vscodium  
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
cp -R configs/gtk-3.0 ~/.config
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 

echo "Checando se o VSCodium esta instalado"
if command -v VSCodium &> /dev/null; then
echo "sim o VSCodium esta instalado, configurando"
else
echo "VSCodium não instalado"
exit 1
fi
 
# Lista das extensões do VSCodium
EXTS=(
  "esbenp.prettier-vscode"
  "formulahendry.code-runner"
  "ms-python.python"
  "timonwong.shellcheck"
  "usernamehw.errorlens"
)

echo " Instalando extensões do VSCodium..."
for ext in "${EXTS[@]}"; do
  codium --install-extension "$ext"
done

if [ "$?" -eq 0 ]; then
echo "Extensões instaladas!"
else
echo "Erro ao instalar extensões"
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
sudo cp -R configs/.kodi/ ~/ 
if [ "$?" -eq 0 ]; then 
echo "Configurado"
else
echo "Erro"
exit 1
fi 

echo "Configurandos temas"
sudo mkdir -p /usr/share/themes
sudo mkdir -p /usr/share/icons
sudo mkdir -p /usr/share/backgrounds
cd config/Themes
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
if [ "$?" -eq 0 ]; then
echo "Configurado"
else
echo "Erro ao Configurar"
exit 1
fi 

echo "configurando cores do terminal"
mkdir -p ~/.local/share/
cp -R configs/Gogh/ ~/.local/share/
export TERMINAL="xfce4-terminal"
export GOGH_NONINTERACTIVE="true" 
export GOGH_USE_NEW_THEME="true"
~/.local/share/gogh/themes/dracula.sh
if [ "$?" -eq 0 ]; then
echo "Configurado"
else
echo "Erro ao Configurar"
exit 1
fi 

echo "Instalando fontes"
FONTS=("JetBrainsMono" "Hack" "FiraCode" "Inconsolata")

for font in "${FONTS[@]}"; do
  oh-my-posh font install "$font" --user
done

if [ "$?" -eq 0 ]; then
echo "Fontes instaladas"
else 
echo "Erro ao instalar as fontes"
exit 1 
fi 

fc-cache -fv

echo "Checando se o Rofi esta instalado"
if command -v rofi &> /dev/null; then 
echo "sim o Rofi esta instalado, configurando"
else
echo "ROfi não instalado"
exit 1
fi 

echo "Configurando Rofi"
mkdir -p ~/.config/rofi/themes
cd configs/themes/
cp *.rasi ~/.config/rofi/themes/
cd ../../
ln -sf ~/.config/rofi/themes/arc-dark.rasi ~/.config/rofi/config.rasi
if [ "$?" -eq 0 ]; then
echo "Rofi configurado"
else
echo "Erro ao configurar"
exit 1
fi

echo "Checando se o Fish esta instalado"
if command -v fish &> /dev/null; then 
echo "sim o Fish esta instalado, configurando"
else
echo "Fish não instalado"
exit 1
fi 

echo "Configurando Fish"
cp -R configs/fish/ ~/.config/
if [ "$?" -eq 0 ]; then
echo "Fish configurado"
else
echo "Erro ao configurar o fish"
exit 1 
fi  

echo "Configurando Firewall"
sudo ufw enable
sudo ufw allow 22
sudo ufw allow ssh
sudo ufw status  
if [ "$?" -eq 0 ]; then
echo "Firewall configurado"
else
echo "Erro ao configurar Firewall"
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
