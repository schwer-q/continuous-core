#!/bin/sh -

PKG_NAME="mpfr"
PKG_VERSION="3.1.2"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure			\
	--prefix=/usr		\
	--enable-thread-safe	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
    make html
}

_install() {
    make install DESTDIR=$DESTDIR
    make install-html DESTDIR=$DESTDIR
}
