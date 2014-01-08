#!/bin/sh -

NAME="texinfo"
VERSION="5.1"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/tools
    
    make
}

install() {
    make install
}

clean() {
    rm -rf $SOURCES
}
