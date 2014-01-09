#!/bin/sh -

PKG_NAME="less"
PKG_VERSION="458"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    ./configure			\
	--prefix=/usr		\
	--sysconfdir=/etc	\
	
    make
}

install_() {
    make install
}
