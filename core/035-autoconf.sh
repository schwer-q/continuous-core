#!/bin/sh -

PKG_NAME="autoconf"
PKG_VERSION="2.69"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
