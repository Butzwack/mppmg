#!/bin/bash

cd ~/git
git clone https://github.com/Netflix/vmaf
cd vmaf/libvmaf
meson build --buildtype release -Dc_args="-march=native" -Dcpp_args="-O3 -march=native" -Db_lto=true -Denable_tests=false -Denable_docs=false -Dbuilt_in_models=true
ninja -vC build
sudo ninja -vC build install