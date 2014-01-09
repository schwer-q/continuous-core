#!/bin/sh -

PKG_NAME="mpc"
PKG_VERSION="1.0.1"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install

    make html
    make install-html
}
