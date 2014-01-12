#!/bin/sh -

PKG_NAME="pkg-config"
PKG_VERSION="0.28"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure			\
	--prefix=/usr		\
	--with-internal-glib	\
	--disable-host-tool	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
