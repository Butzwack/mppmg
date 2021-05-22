#!/bin/bash

cd ~/git/VVCSoftware_VTM
up_to_date=0
git pull | grep "Already up to date." && up_to_date=1
if [ $up_to_date == 1 ]; then
	rm ~/bin/vtm*
	mkdir build
	cd build
	cmake ../
	make -j12
	cd ..
	mv bin/EncoderAppStatic ~/bin/vvc_encoder
	mv bin/DecoderAppStatic ~/bin/vvc_decoder
	rm -rf build
fi
