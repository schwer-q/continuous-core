#!/bin/sh -

PKG_NAME="libtool"
PKG_VERSION="2.4.2"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
