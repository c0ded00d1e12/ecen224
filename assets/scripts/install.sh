#!/bin/bash
echo "-----------------Installing Dependencies-----------------"
sudo apt update
sudo apt upgrade
sudo apt install git zsh gdb libcamera-dev libjpeg-dev libtiff5-dev cmake libboost-program-options-dev libdrm-dev libexif-dev tmux vim -y
echo "--------------Done Installing Dependencies---------------"
echo "---------------AutoDisplay IP Addr on Boot---------------"
sudo sed -i '$ a\Hello World! My IP Address is \\4' /etc/issue
echo "-------------------Setting up Swapfile-------------------"
sudo dphys-swapfile swapoff
sudo sed -i 's/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g' /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
echo "------------------Installing Oh My Zsh!------------------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
# Pretty sure Zsh will steal the terminal at this point, so nothing below will run
echo "-----------Write IP Addr to Screen on Boot---------------"
wget "https://raw.githubusercontent.com/Chaser2143/ecen224/fall_2023/assets/scripts/ip_addr.bin"
chmod +x ip_addr.bin
sudo mv ip_addr.bin /opt/
cat << EOF
[Unit]
Description=IP Address Display

[Service]
ExecStart=/opt/ip_addr.bin

[Install]
WantedBy=multi-user.target
EOF > ip_addr.service
sudo mv ip_addr.service /etc/systemd/system/
sudo systemctl enable ip_addr.service
echo "--------------------Prepare for Reboot-------------------"
sudo reboot
