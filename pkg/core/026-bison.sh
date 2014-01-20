#!/bin/sh -

PKG_NAME="bison"
PKG_VERSION="3.0"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
