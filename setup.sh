#!/bin/bash

chmod a+x ./package/*/*.sh
cp -r .config ~/
cat .bashrc >> ~/.bashrc
cp {.bash_aliases,.vimrc} ~/
mkdir git bin
cp qencoder bin
sudo apt install vim ffmpeg build-essential clang python3-pip python-is-python3 doxygen meson vpx-tools aom-tools htop cmake gettext python3-opencv kdenlive mesa-utils libsm6 libcurl4-gnutls-dev libsdl2-mixer-dev libsdl2-dev libpango1.0-dev libcairo2-dev libavcodec-dev libavresample-dev libglew-dev librtmp-dev libjpeg-dev libavformat-dev liblzma-dev neofetch scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libudev-dev libxi-dev libxrandr-dev yasm nasm
