#!/bin/sh -

NAME="grep"
VERSION="2.14"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
