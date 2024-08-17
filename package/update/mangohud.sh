#!/bin/bash

cd ~/git/MangoHud
./build.sh uninstall
./build.sh pull
./build.sh build
./build.sh install
