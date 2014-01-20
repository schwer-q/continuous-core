#!/bin/sh -

PKG_NAME="zlib"
PKG_VERSION="1.2.8"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/usr/lib/libz.so.* ${DESTDIR}/lib
    ln -sfv ../../lib/libz.so.$PKG_VERSION ${DESTDIR}/usr/lib/libz.so
}
