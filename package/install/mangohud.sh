#!/bin/bash

cd ~/git
git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
cd MangoHud
./build.sh build
./build.sh install
