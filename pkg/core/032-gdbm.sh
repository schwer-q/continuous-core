#!/bin/sh -

PKG_NAME="gdbm"
PKG_VERSION="1.10"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--enable-libgdbm-compat

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
