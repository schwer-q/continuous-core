#!/bin/sh -

PKG_NAME="grep"
VERSION="2.14"
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
