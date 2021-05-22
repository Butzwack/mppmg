#!/bin/bash

cd ~/git
git clone https://github.com/lightspark/lightspark.git
cd lightspark
mkdir obj
cd obj
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j12
