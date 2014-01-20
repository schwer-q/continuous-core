#!/bin/sh -

PKG_NAME="gawk"
PKG_VERSION="4.1.0"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
