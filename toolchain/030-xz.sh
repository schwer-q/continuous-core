#!/bin/sh -

NAME="xz"
VERSION="5.0.5"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
