#!/bin/bash
echo "------------installing dependencies-----------------"
sudo apt update
sudo apt upgrade
sudo apt install git zsh gdb libcamera-dev libjpeg-dev libtiff5-dev cmake libboost-program-options-dev libdrm-dev libexif-dev tmux vim -y
echo "------------done installing dependencies-----------"
echo "------------installing Oh My Zsh!--------------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -n
#ZSH will ask if you want to change your default at the moment. Doing so interrupts the rest of this script, so I put -n and changed it right after.
chsh -s $(which zsh)
echo "------------AutoDisplay IP Address on Boot------"
sudo sed -i '$ a\Hello World! My IP Address is \\4' /etc/issue
echo "------------setting up swapfile-----------"
sudo dphys-swapfile swapoff
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
echo "-------------prepare for reboot----------------"
sudo reboot
