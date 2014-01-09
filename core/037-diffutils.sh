#!/bin/sh -

PKG_NAME="diffutils"
PKG_VERSION="3.3"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
