#!/bin/bash

timedatectl set-local-rtc 1 --adjust-system-clock
git config --global pull.rebase false
chmod a+x ./package/*/*.sh
cp -r .config/ /home/naomi/
cat .bashrc >> ~/.bashrc
cp {.bash_aliases,.vimrc} ~/
sudo add-apt-repository ppa:ernstp/mesarc
sudo cp corectrl /etc/apt/preferences.d/
cd ~
mkdir git bin
sudo apt update
sudo apt install $(cat ~/mppmg/package.list) -y
flatpak install flathub $(cat ~/mppmg/flatpak.list) -y
mkdir ~/.config/autostart
cp /usr/share/applications/org.corectrl.CoreCtrl.desktop ~/.config/autostart/org.corectrl.CoreCtrl.desktop
sudo cp 90-corectrl.rules /etc/polkit-1/rules.d/
sudo kernelstub -a "amdgpu.ppfeaturemask=0xffffffff"
