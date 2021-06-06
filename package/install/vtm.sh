#!/bin/bash

cd ~/git
git clone https://vcgit.hhi.fraunhofer.de/jvet/VVCSoftware_VTM
cd VVCSoftware_VTM
mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
cd ..
mv bin/EncoderAppStatic ~/bin/vvc_encoder
mv bin/DecoderAppStatic ~/bin/vvc_decoder
rm -rf build