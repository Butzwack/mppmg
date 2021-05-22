#!/bin/bash
#git clone https://github.com/shssoichiro/oxipng.git

cd ~/git/oxipng
up_to_date=0
git pull | grep "Already up to date." && up_to_date=1
if [ $up_to_date == 0 ]; then
	rm ~/bin/oxipng
	cargo build --release
	mv target/release/oxipng ~/bin
	rm -rf target
fi
