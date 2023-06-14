#!/bin/bash
echo "------------installing dependencies-----------------"
sudo apt update
sudo apt install git zsh gdb libcamera-dev libjpeg-dev libtiff5-dev cmake libboost-program-options-dev libdrm-dev libexif-dev tmux vim -y
echo "------------done installing dependencies-----------"
echo "------------setting up swapfile-----------"
sudo dphys-swapfile swapoff
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
echo "-------------prepare for reboot----------------"
sudo reboot
