#!/bin/sh -

PKG_NAME="bash"
PKG_VERSION="4.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    patch -Np1 -i /sources/bash-4.2-fixes-12.patch

    ./configure					\
	--prefix=/usr				\
	--bindir=/bin				\
	--htmldir=/usr/share/doc/$PKG_SOURCES	\
	--without-bash-malloc			\
	--with-installed-readline

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
