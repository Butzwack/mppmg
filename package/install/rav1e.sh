#!/bin/bash

cd ~/git
git clone https://github.com/xiph/rav1e
cd ~/git/rav1e
RUSTFLAGS="-C target-cpu=native" cargo build --release
strip target/release/rav1e
mv target/release/rav1e ~/bin
rm -rf target
