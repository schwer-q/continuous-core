#!/bin/sh -

PKG_NAME="less"
PKG_VERSION="458"
EXT="tar.gz"

build() {
    ./configure			\
	--prefix=/usr		\
	--sysconfdir=/etc	\
	
    make
}

install_() {
    make install
}
