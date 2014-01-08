#!/bin/sh -

NAME="bison"
VERSION="3.0"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
