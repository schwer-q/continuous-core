#!/bin/sh -

PKG_NAME="procps-ng"
PKG_VERSION="3.3.8"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure					\
	--prefix=/usr				\
	--exec-prefix=				\
	--libdir=/usr/lib			\
	--docdir=/usr/share/doc/$PKG_SOURCES	\
	--disable-static			\
	--disable-skill				\
	--disable-kill

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/usr/lib/libprocps.so.* ${DESTDIR}/lib
    ln -sfv ../../lib/libprocps.so.1.1.2 ${DESTDIR}/usr/lib/libprocps.so
}
