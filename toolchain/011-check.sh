#!/bin/sh -

PKG_NAME="check"
PKG_VERSION="0.9.10"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
