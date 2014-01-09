#!/bin/sh -

PKG_NAME="mpfr"
PKG_VERSION="3.1.2"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    ./configure			\
	--prefix=/usr		\
	--enable-thread-safe	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

install_() {
    make install

    make html
    make install-html
}
