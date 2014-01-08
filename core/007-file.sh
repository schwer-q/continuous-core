#!/bin/sh -

NAME="file"
VERSION="5.14"
EXT="tar.gz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
