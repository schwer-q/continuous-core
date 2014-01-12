#!/bin/sh -

PKG_NAME="sed"
PKG_VERSION="4.2.2"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    ./configure		\
	--prefix=/usr	\
	--bindir=/bin	\
	--htmldir=/usr/share/doc/$PKG_SOURCES

    make
    make html
}

_install() {
    make install DESTDIR=$DESTDIR
    make -C doc install-html DESTDIR=$DESTDIR
}
