#!/bin/sh -

PKG_NAME="ncurses"
PKG_VERSION="5.9"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure		\
	--prefix=/tools	\
	--with-shared	\
	--without-debug	\
	--without-ada	\
	--enable-overwrite

    make
}

_install() {
    make install
}
