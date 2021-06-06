#!/bin/bash
export CFLAGS="-O3 -march=native" CXXFLAGS="-O3 -march=native" LDFLAGS="-O3 -march=native"
export CC=/usr/bin/clang && export CXX=/usr/bin/clang++

cd ~/git
git clone https://aomedia.googlesource.com/aom
cd aom
mkdir aom_build
cd aom_build
cmake -DCONFIG_AV1_DECODER=0 -DENABLE_TESTS=0 -DENABLE_DOCS=0 -DBUILD_SHARED_LIBS=0 -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-march=native -O3" -DCMAKE_C_FLAGS="-march=native -O3" ../
make -j$(nproc)
mv aomenc ~/bin/
cd ..
rm -rf aom_build