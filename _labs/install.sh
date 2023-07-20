#!/bin/bash
echo "------------installing dependencies-----------------"
sudo apt update
sudo apt upgrade
sudo apt install git zsh gdb libcamera-dev libjpeg-dev libtiff5-dev cmake libboost-program-options-dev libdrm-dev libexif-dev tmux vim -y
echo "------------done installing dependencies-----------"
echo "------------AutoDisplay IP Address on Boot------"
sudo sed -i '$ a\Hello World! My IP Address is \\4' /etc/issue
echo "------------setting up swapfile-----------"
sudo dphys-swapfile swapoff
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
echo "------------installing Oh My Zsh!--------------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
# Pretty sure Zsh will steal the terminal at this point, so nothing below will run
echo "-------------prepare for reboot----------------"
sudo reboot
