#!/bin/sh -

PKG_NAME="xz"
PKG_VERSION="5.0.5"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    ./configure		\
	--prefix=/usr	\
	--libdir=/lib	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

install_() {
    make pkgconfigdir=/usr/lib/pkgconfig install
}
