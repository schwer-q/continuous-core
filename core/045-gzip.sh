#!/bin/sh -

PKG_NAME="gzip"
PKG_VERSION="1.6"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--bindir=/bin

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
