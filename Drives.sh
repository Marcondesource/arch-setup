#!/usr/bin/env bash
#Script de instalação de drives (GTX 550TI)
#Variaveis
tmpdir="$(mktemp -d)"
UTILS="base-devel git linux-lts-headers"
check() {
if [ "$?" -ne 0 ]; then
echo "ERRO: $1"
exit 1
fi
}

{
#1 Habilitar o multilib e instalar o yay
echo ">>>>>Habilitando multilib e instalando o yay"

sudo sed -i '/\[multilib\]/s/^#//' /etc/pacman.conf
sudo sed -i '/Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf

echo "Atualizando repositorio"
sudo pacman -Syu --noconfirm
check "Falha ao Atualizar"
echo "Atualizado com sucesso"

echo "Instalando pacotes necessarios"
sudo pacman -S --noconfirm $UTILS
check "Falha ao Instalar"
echo "Pacotes instalados"

echo "Instalando yay"
git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
chown -R marcondes:marcondes "$tmpdir"
cd "$tmpdir/yay"
pwd
sudo -u marcondesv makepkg -si --noconfirm
check "Falha ao Instalar"
echo "Instalado com sucesso"

echo "Limpando Lixos"
cd && pwd
rm -rf "$tmpdir"

#2 Instalando drives Nvidia
echo "Instalando drives Nvidia"
yay -S --noconfirm nvidia-390xx-dkms nvidia-390xx-utils nvidia-390xx-settings lib32-nvidia-390xx-utils
check "Falha ao Instalar"
echo "Instalado com sucesso"

#Colocando Noveau em blacklist 
echo "Removendo Noveau e habilitando Nvidia"
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf > /dev/null
check "Falha"
echo "Tudo certo"

echo "Gerando initramfs"
sudo mkinitcpio -P
check "Falha"
echo "Tudo certo"

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

