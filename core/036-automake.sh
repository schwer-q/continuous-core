#!/bin/sh -

PKG_NAME="automake"
PKG_VERSION="1.14"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    patch -Np1 -i /sources/automake-1.14-test-1.patch

    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
