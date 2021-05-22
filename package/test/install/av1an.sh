#!/bin/bash

cd ~/git
git clone https://github.com/master-of-zen/Av1an
cd Av1an
python3 -m venv env
source env/bin/activate
maturin develop --release -m av1an-pyo3/Cargo.toml
./av1an.py -i anything -l log.log 
