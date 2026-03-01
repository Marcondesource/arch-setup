#!/usr/bin/env bash
#Iniciado Config
if [ -d "$HOME/.config/" ]; then
echo "Configurando programas"
else
mkdir -p "$HOME/.config"
echo "Diretorio criado, configurando programas"
fi

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
cp -v .dotfiles/pacman/xorg/xorg.conf /etc/X11/
fi

if command -v openbox &> /dev/null; then
cp -Rv .dotfiles/pacman/openbox/ "$HOME/.config"
fi

if command -v sxhkd &> /dev/null; then
cp -Rv .dotfiles/pacman/sxhkd/ "$HOME/.config"
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

echo "            Instalação Concluida  			   "
echo "====================================="
read -p "Deseja sair agora? (s/n)" sair
if [ "$sair" = "s" ]; then
echo "Saindo...."
exit 1
fi
