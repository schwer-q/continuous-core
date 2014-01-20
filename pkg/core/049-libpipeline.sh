#!/bin/sh -

PKG_NAME="libpipeline"
PKG_VERSION="1.2.4"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    PKG_CONFIG_PATH=/tools/lib/pkgconfig	\
    ./configure					\
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
