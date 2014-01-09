#!/bin/sh -

NAME="diffutils"
VERSION="3.3"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
