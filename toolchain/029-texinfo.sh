#!/bin/sh -

PKG_NAME="texinfo"
PKG_VERSION="5.1"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
