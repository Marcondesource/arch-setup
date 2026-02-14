#!/usr/bin/env bash
#Variaveis

echo "Ambiente Grafico"
echo "1-I3WM"
echo "2-XFCE"
read -p "Escolha um :" ambiente

#Iniciado Config
if [ -d "$HOME/.config/" ]; then
echo "Configurando programas"
else
mkdir -p "$HOME/.config"
echo "Diretorio criado, configurando programas"
fi

case $ambiente in
1)
#Pacman
if command -v alacritty &> /dev/null; then
cp -Rv .dotfiles/pacman/alacritty/ "$HOME/.config/"
fi

if command -v bash &> /dev/null; then
cp -v .dotfiles/outros/bash/.bashrc "$HOME"
fi

if command -v fastfetch &> /dev/null; then
cp -Rv .dotfiles/pacman/fastfetch/ "$HOME/.config/"
fi

if command -v i3 &> /dev/null; then
cp -Rv .dotfiles/pacman/i3/ "$HOME/.config/"
fi

if command -v polybar &> /dev/null; then
cp -Rv .dotfiles/pacman/polybar/ "$HOME/.config/"
fi

if command -v Xorg &> /dev/null; then
sudo cp -v .dotfiles/pacman/xorg/xorg.conf /etc/X11/
fi

#Flatpak
if command -v gimp &> /dev/null; then
cp -Rv .dotfiles/flatpak/gimp/.config/ "$HOME/.config/"
cp -v .dotfiles/flatpak/gimp/.local/share/applications/org.gimp.GIMP.desktop "$HOME/.local/share/applications/"
cp -Rv .dotfiles/flatpak/gimp/.local/share/icons/ "$HOME/.local/share/"
fi

if command -v tv.kodi.Kodi &> /dev/null; then
sudo cp -v .dotfiles/flatpak/kodi/ "$HOME"
fi
;;
2)
#Pacman

if command -v alacritty &> /dev/null; then
cp -Rv .dotfiles/pacman/alacritty/ "$HOME/.config/"
fi

if command -v bash &> /dev/null; then
cp -v .dotfiles/outros/bash/.bashrc "$HOME"
fi

if command -v fastfetch &> /dev/null; then
cp -Rv .dotfiles/pacman/fastfetch/ "$HOME/.config/"
fi

if command -v Xorg &> /dev/null; then
sudo cp -v .dotfiles/pacman/xorg/xorg.conf /etc/X11/
fi

if command -v tint2 &> /dev/null; then
sudo cp -v .dotfiles/pacman/tint2/ "$HOME/.config"
fi

if command -v xfce4-panel &> /dev/null; then
xfce4-panel-profiles load .dotfiles/outros/unity.tar.bz2
fi

#Flatpak
if command -v gimp &> /dev/null; then
cp -Rv .dotfiles/flatpak/gimp/.config/ "$HOME/.config/"
cp -v .dotfiles/flatpak/gimp/.local/share/applications/org.gimp.GIMP.desktop "$HOME/.local/share/applications/"
cp -Rv .dotfiles/flatpak/gimp/.local/share/icons/ "$HOME/.local/share/"
fi

if command -v tv.kodi.Kodi &> /dev/null; then
sudo cp -v .dotfiles/flatpak/kodi/ "$HOME"
fi

esac

#Icones, Temas & Wallpapers
if [ ! -d "$HOME/.icons" ]; then
mkdir -p "$HOME/.icons"
cp -Rv .dotfiles/outros/.icons "$HOME"
fi

if [ ! -d "$HOME/.themes" ]; then
mkdir -p "$HOME/.themes"
cp -Rv .dotfiles/outros/.themes "$HOME"
fi

if [ ! -d "$HOME/Imagens" ]; then
mkdir -p "$HOME/Imagens"
cp -Rv .dotfiles/outros/Wallpapers "$HOME/Imagens/"
fi

echo "Configurando Firewall"
sudo ufw enable
sudo ufw allow 22
sudo ufw allow ssh
sudo ufw status
echo "            Instalação Concluida  			   "
echo "====================================="
read -p "Deseja sair agora? (s/n)" sair
if [ "$sair" = "s" ]; then
echo "Saindo...."
exit 1
fi
