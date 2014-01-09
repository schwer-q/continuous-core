#!/bin/sh -

PKG_NAME="diffutils"
PKG_VERSION="3.3"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
