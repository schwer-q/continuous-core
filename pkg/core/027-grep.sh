#!/bin/sh -

PKG_NAME="grep"
PKG_VERSION="2.14"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--bindir=/bin

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
