#!/bin/bash
export THREAD_COUNT=$(grep -c ^processor /proc/cpuinfo)

cd ~/git
git clone https://aomedia.googlesource.com/aom
cd ~/git/aom
mkdir ../aom_build
cd ../aom_build
cmake ../aom
make -j$THREAD_COUNT
mv aomenc aomdec ~/bin/
cd ..
rm -rf aom_build

