#!/bin/sh -

PKG_NAME="sed"
PKG_VERSION="4.2.2"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
