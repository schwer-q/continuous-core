#!/bin/sh -

NAME="xz"
VERSION="5.0.5"
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
