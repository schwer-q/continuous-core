#!/bin/sh -

PKG_NAME="xz"
PKG_VERSION="5.0.5"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
