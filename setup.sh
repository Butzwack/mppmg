#!/bin/bash

timedatectl set-local-rtc 1 --adjust-system-clock
git config pull.rebase false
chmod a+x ./package/*/*.sh
cp -r .config/ /home/markus/
cat .bashrc >> ~/.bashrc
cp {.bash_aliases,.vimrc} ~/
cd ~
mkdir git bin
cp mppmg/qencoder bin
sudo add-apt-repository ppa:mozillateam/firefox-next
sudo apt update
sudo apt install $(cat ~/mppmg/package.list)
flatpak install flathub $(cat ~/mppmg/flatpak.list)
