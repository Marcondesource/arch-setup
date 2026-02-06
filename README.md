## Arch-Setup Config ## 

**Scripts para automatizar a configuração inicial do Arch Linux, incluindo drivers, ambiente gráfico e dotfiles de acordo com meu uso!**

**Drivers.sh**

Responsável pela configuração dos drivers de vídeo.

- Instalação de drivers da **GTX 550 TI**
- Habilita o `multilib`
- Instala o `Yay`
- Faz o download do drivers 
- Coloca o **Noveau** em blacklist

**Setup.sh**

Script principal de configuração do sistema.

- Mostra um dialogo pra escolha de interface grafica (Xfce ou i3wm)
- Instala todos os pacotes necessarios
- Habilita gerenciador de login e firewall `ufw`

**Dotconfig.sh**

- Dialogo para selecionar interface (Selecione a mesma que você selecionou anteriormente no `Setup.sh`)
- Configurar os programas de acordo com a interface escolhida

## ⚠️ Avisos

- Este projeto é **de uso pessoal** e foi feito para o meu hardware e preferências.
- Os drivers NVIDIA são voltados para a **GTX 550 Ti** (placa antiga).
- Recomenda-se rodar os scripts em uma **instalação minima do Arch Linux**.
- Leia os scripts antes de executar para evitar comportamentos inesperados.

## ▶️ Como usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/Marcondesource/arch-setup.git
   cd arch-setup
   #Dando permissção de execução pros Scripts
   chmod +x *.sh
   #Agora basta executar os scripts exemplo:
   ./Drivers.sh
   # Setup principal
   ./Setup.sh
   # Dotfiles
   ./Dotconfig.sh
   
   ⚠️ Durante a execução, selecione sempre a mesma interface gráfica
   (Xfce ou i3wm) quando solicitado.