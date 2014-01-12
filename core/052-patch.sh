#!/bin/sh -

PKG_NAME="patch"
PKG_VERSION="2.7.1"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
