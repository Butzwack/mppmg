#!/bin/bash

timedatectl set-local-rtc 1 --adjust-system-clock
git config --global pull.rebase false
chmod a+x ./package/*/*.sh
cp -r .config/ /home/markus/
cat .bashrc >> ~/.bashrc
cp {.bash_aliases,.vimrc} ~/
sudo add-apt-repository ppa:ernstp/mesarc
sudo cp corectl /etc/apt/preferences.d/
cd ~
mkdir git bin
sudo apt update
sudo apt install $(cat ~/mppmg/package.list)
flatpak install flathub $(cat ~/mppmg/flatpak.list)
cp /usr/share/applications/org.corectrl.corectrl.desktop ~/.config/autostart/org.corectrl.corectrl.desktop
sudo cp 90-corectrl.pkla /etc/polkit-1/localauthority/50-local.d/
sudo kernelstub -a "amdgpu.ppfeaturemask=0xffffffff"
