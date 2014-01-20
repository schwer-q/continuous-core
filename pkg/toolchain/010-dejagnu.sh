#!/bin/sh -

PKG_NAME="dejagnu"
PKG_VERSION="1.5.1"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    cp configure configure.orig
    sed 's:/usr/local/bin:/bin:' configure.orig > configure

    ./configure \
	--prefix=/tools
}

_install() {
    make install
}
