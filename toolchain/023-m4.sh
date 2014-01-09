#!/bin/sh -

NAME="m4"
VERSION="1.4.16"
EXT="tar.bz2"

build() {
    sed -i -e '/gets is a/d' lib/stdio.in.h
    
    ./configure \
	--prefix=/tools
    
    make
}

install_() {
    make install
}
