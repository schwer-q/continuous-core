#!/bin/sh -

PKG_NAME="mpc"
PKG_VERSION="1.0.1"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure \
	--prefix=/usr

    make
    make html
}

_install() {
    make install DESTDIR=$DESTDIR
    make install-html DESTDIR=$DESTDIR
}
