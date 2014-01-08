#!/bin/sh -

NAME="gawk"
VERSION="4.1.0"
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
