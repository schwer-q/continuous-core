#!/bin/sh -

NAME="file"
VERSION="5.14"
EXT="tar.gz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
