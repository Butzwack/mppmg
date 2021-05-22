#!/bin/bash
#git clone https://github.com/shssoichiro/oxipng.git

cd ~/git/rav1e
up_to_date=0
git pull | grep "Already up to date." && up_to_date=1
if [ $up_to_date == 0 ]; then
	rm ~/bin/rav1e
	RUSTFLAGS="-C target-cpu=native" cargo build --release
	mv target/release/rav1e ~/bin
	rm -rf target
fi
