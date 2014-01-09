#!/bin/sh -

PKG_NAME="libtool"
VERSION="2.4.2"
EXT="tar.gz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
