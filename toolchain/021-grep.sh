#!/bin/sh -

NAME="grep"
VERSION="2.14"
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
