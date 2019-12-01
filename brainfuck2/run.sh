#!/bin/sh

set -e
echo Cpp
../xtime.rb ./bin_cpp mandel.b > /dev/null
echo Rust
../xtime.rb ./bin_rs mandel.b > /dev/null