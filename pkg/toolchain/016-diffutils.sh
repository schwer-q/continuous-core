#!/bin/sh -

PKG_NAME="diffutils"
PKG_VERSION="3.3"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
