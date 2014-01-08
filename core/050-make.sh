#!/bin/sh -

NAME="make"
VERSION="3.82"
EXT="tar.bz2"

build() {
    patch -Np1 -i /sources/make-3.82-upstream_fixes-3.patch

    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
}
