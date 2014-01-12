#!/bin/sh -

PKG_NAME="grep"
PKG_VERSION="2.14"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
