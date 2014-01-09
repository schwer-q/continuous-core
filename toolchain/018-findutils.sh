#!/bin/sh -

NAME="findutils"
VERSION="4.4.2"
EXT="tar.gz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
