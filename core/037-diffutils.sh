#!/bin/sh -

PKG_NAME="diffutils"
VERSION="3.3"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
