#!/bin/sh -

NAME="diffutils"
VERSION="3.3"
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
