#!/bin/sh -

PKG_NAME="diffutils"
PKG_VERSION="3.3"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
