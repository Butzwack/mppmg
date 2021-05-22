#!/bin/bash

cd ~/git
git clone https://github.com/shssoichiro/oxipng.git

cd ~/git/oxipng
cargo build --release
mv target/release/oxipng ~/bin
rm -rf target

