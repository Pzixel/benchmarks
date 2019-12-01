#!/bin/sh

set -e
g++ -flto -O3 -o bin_cpp bf.cpp
rustc -C opt-level=3 -C lto bf.rs -o bin_rs