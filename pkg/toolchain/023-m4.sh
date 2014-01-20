#!/bin/sh -

PKG_NAME="m4"
PKG_VERSION="1.4.16"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    sed -i -e '/gets is a/d' lib/stdio.in.h

    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install
}
