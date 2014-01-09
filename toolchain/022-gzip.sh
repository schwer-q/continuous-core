#!/bin/sh -

NAME="gzip"
VERSION="1.6"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
