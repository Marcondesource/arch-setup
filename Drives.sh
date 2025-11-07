#!/usr/bin/env bash
{
#Script de reinstalação de drives (GTX 550TI)

#1 Habilitar o multilib e instalar o yay
echo ">>>>>Habilitando multilib e instalando o yay"

sudo sed -i '/\[multilib\]/s/^#//' /etc/pacman.conf
sudo sed -i '/Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf

echo "Atualizando repositorio"
sudo pacman -Syu --noconfirm
if [ "$?" -eq 0 ]; then
echo "Atualizado com sucesso"
else
echo "Erro ao Atualizar"
exit 1
fi

echo "Instalando pacotes necessarios"
sudo pacman -S --noconfirm base-devel git linux-lts-headers
if [ "$?" -eq 0 ]; then
echo "Pacotes instalados"
else
echo "Erro ao instalar"
exit 1
fi

echo "Instalando yay"
cd /tmp
pwd
git clone https://aur.archlinux.org/yay.git
cd yay
pwd
makepkg -si
if [ "$?" -eq 0 ]; then
echo "Instalado com sucesso"
else
echo "Erro ao instalar"
exit 1
fi

echo "Limpando Lixos"
cd && pwd
rm -rf /tmp/yay

#2 Instalando drives Nvidia
echo "Instalando drives Nvidia"
yay -S --noconfirm nvidia-390xx-dkms nvidia-390xx-utils nvidia-390xx-settings lib32-nvidia-390xx-utils
if [ "$?" -eq 0 ]; then
echo "Instalado com sucesso"
else
echo "Erro ao instalar"
exit 1
fi

#Colocando Noveau em blacklist 
echo "Removendo Noveau e habilitando Nvidia"
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf > /dev/null
if [ "$?" -eq 0 ]; then
echo "Tudo certo"
else
echo "Erro"
exit 1
fi

echo "Gerando initramfs"
sudo mkinitcpio -P
if [ "$?" -eq 0 ]; then
echo "Tudo certo"
else
echo "Erro"
exit 1
fi

} | tee ~/Documentos/Install_Drives-logs.txt

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

