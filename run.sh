#! /usr/bin/bash

BUILD_DIR="./build"
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
    echo "Directory $BUILD_DIR created."
else
    echo "Directory $BUILD_DIR  already exists."
fi

# for better debugging you can uncomment below line
# set -xe

clang++ -Wall -Wextra $1 -o ./build/out
echo "[output]:"
./build/out

