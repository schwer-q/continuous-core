#!/bin/sh -

PKG_NAME="autoconf"
VERSION="2.69"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
