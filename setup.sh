#!/bin/bash

timedatectl set-local-rtc 1 --adjust-system-clock
git config --global pull.rebase false
chmod a+x ./package/*/*.sh
cp -r .config/ /home/markus/
cat .bashrc >> ~/.bashrc
cp {.bash_aliases,.vimrc} ~/
cd ~
mkdir git bin
sudo apt update
sudo apt install $(cat ~/mppmg/package.list)
flatpak install flathub $(cat ~/mppmg/flatpak.list)
