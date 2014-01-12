#!/bin/sh -

PKG_NAME="make"
PKG_VERSION="3.82"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    patch -Np1 -i /sources/make-3.82-upstream_fixes-3.patch

    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
