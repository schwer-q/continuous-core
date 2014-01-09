#!/bin/sh -

NAME="sed"
VERSION="4.2.2"
EXT="tar.bz2"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
