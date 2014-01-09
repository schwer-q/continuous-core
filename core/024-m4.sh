#!/bin/sh -

PKG_NAME="m4"
VERSION="1.4.16"
EXT="tar.bz2"

build() {
    sed -i -e '/gets is a/d' lib/stdio.in.h

    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
