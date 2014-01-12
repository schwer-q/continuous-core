#!/bin/sh -

PKG_NAME="libtool"
PKG_VERSION="2.4.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
