#!/bin/sh -

PKG_NAME="bc"
PKG_VERSION="1.06.95"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    ./configure			\
	--prefix=/usr		\
	--mandir=/usr/share/man	\
	--with-readline

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
