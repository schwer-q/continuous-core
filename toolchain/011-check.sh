#!/bin/sh -

NAME="check"
VERSION="0.9.10"
EXT="tar.gz"

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
