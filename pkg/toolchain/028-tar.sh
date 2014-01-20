#!/bin/sh -

PKG_NAME="tar"
PKG_VERSION="1.26"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    sed -i -e '/gets is a/d' gnu/stdio.in.h

    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/tools

    make
}

_install() {
    make install
}
