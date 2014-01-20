#!/bin/sh -

PKG_NAME="xz"
PKG_VERSION="5.0.5"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--libdir=/lib	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

_install() {
    make pkgconfigdir=/usr/lib/pkgconfig install DESTDIR=$DESTDIR
}
