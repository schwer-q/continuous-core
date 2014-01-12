#!/bin/sh -

PKG_NAME="less"
PKG_VERSION="458"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure			\
	--prefix=/usr		\
	--sysconfdir=/etc	\

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
