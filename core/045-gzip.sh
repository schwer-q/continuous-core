#!/bin/sh -

PKG_NAME="gzip"
PKG_VERSION="1.6"
EXT="tar.xz"

build() {
    ./configure		\
	--prefix=/usr	\
	--bindir=/bin

    make
}

install_() {
    make install
}
