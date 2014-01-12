#!/bin/sh -

PKG_NAME="findutils"
PKG_VERSION="4.4.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
