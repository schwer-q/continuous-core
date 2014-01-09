#!/bin/sh -

PKG_NAME="gettext"
PKG_VERSION="0.18.3"
EXT="tar.gz"

build() {
    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

install_() {
    make install
}
