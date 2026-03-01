#!/usr/bin/env bash
clear
set -e
#Variaveis
SRC_DIR=".src"

if [ !  -d "$SRC_DIR" ]; then
echo "Diretorio .src não encontrado!"
exit 1
fi
while true; do
clear
echo "==============================="
echo "        ARCH SETUP"
echo "==============================="
echo "1) Instalar Drivers"
echo "2) Instalar Ambiente"
echo "3) Configurar Ambiente"
echo "0) Sair"
echo "==============================="
read -rp "Escolha uma opcao :" opcao

case "$opcao" in
1)
bash .src/Drivers.sh
;;
2)
bash .src/Setup.sh
;;
3)
bash .src/Dotconfig.sh
;;
0)
echo "Saindo..."
exit 0
;;
*)
echo "Opcao invalida!"
sleep 1
continue
;;
esac
done

