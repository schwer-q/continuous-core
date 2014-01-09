#!/bin/sh -

PKG_NAME="libpipeline"
PKG_VERSION="1.2.4"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    PKG_CONFIG_PATH=/tools/lib/pkgconfig	\
    ./configure					\
	--prefix=/usr

    make
}

install_() {
    make install
}
