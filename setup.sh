#!/bin/bash

timedatectl set-local-rtc 1 --adjust-system-clock
chmod a+x ./package/*/*.sh
cp -r .config ~/
cat .bashrc >> ~/.bashrc
cp {.bash_aliases,.vimrc} ~/
echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile
cd ~
mkdir git bin
cp mppmg/qencoder bin
sudo add-apt-repository ppa:mozillateam/firefox-next
sudo apt update
sudo apt install vim ffmpeg build-essential clang gnome-tweaks github-desktop python3-pip python-is-python3 atom doxygen opus-tools steam-installer vlc mpv wine lutris qt5-style-kvantum ninja-build p7zip-full libx264-dev libx265-dev libnuma-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev meson vpx-tools aom-tools htop cmake gettext python3-opencv kdenlive mesa-utils libsm6 libcurl4-gnutls-dev libsdl2-mixer-dev libsdl2-dev libpango1.0-dev libcairo2-dev libavcodec-dev libavresample-dev libglew-dev librtmp-dev libjpeg-dev libavformat-dev liblzma-dev neofetch scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm nasm autoconf automake build-essential cmake git-core libass-dev libfreetype6-dev libgnutls28-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev meson ninja-build pkg-config texinfo wget yasm zlib1g-dev
