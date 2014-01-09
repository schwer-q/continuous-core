#!/bin/sh -

PKG_NAME="procps-ng"
PKG_VERSION="3.3.8"
PKG_ARCHIVE_EXT="tar.xz"

build() {
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

install_() {
    make install
    
    mv -v /usr/lib/libprocps.so.* /lib
    ln -sfv ../../lib/libprocps.so.1.1.2 /usr/lib/libprocps.so
}
