#!/bin/sh -

PKG_NAME="make"
PKG_VERSION="3.82"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
