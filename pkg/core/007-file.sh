#!/bin/sh -

PKG_NAME="file"
PKG_VERSION="5.14"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install
}
