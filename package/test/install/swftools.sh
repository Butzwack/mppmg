#!/bin/bash

cd ~/git/swftools
git clone git://github.com/matthiaskramm/swftools
cd swftools
./configure
make
make install
