#!/bin/bash

cd ~/git/HandBrake
git pull
./configure --launch-jobs=$(nproc) --launch
