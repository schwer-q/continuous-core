#!/bin/sh -

PKG_NAME="patch"
VERSION="2.7.1"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
