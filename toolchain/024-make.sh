#!/bin/sh -

NAME="make"
VERSION="3.82"
EXT="tar.bz2"

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
