#!/bin/sh -

PKG_NAME="gettext"
PKG_VERSION="0.18.3"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
