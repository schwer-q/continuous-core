#!/bin/sh -

PKG_NAME="patch"
PKG_VERSION="2.7.1"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
