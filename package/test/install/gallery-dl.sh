#!/bin/bash

cd ~/git/gallery-dl
up_to_date=0
git pull | grep "Already up to date." && up_to_date=1
if [ $up_to_date == 0 ]; then
	python3 setup.py install --user
fi
