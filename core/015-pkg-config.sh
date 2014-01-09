#!/bin/sh -

PKG_NAME="pkg-config"
PKG_VERSION="0.28"
EXT="tar.gz"

build() {
    ./configure			\
	--prefix=/usr		\
	--with-internal-glib	\
	--disable-host-tool	\
	--docdir=/usr/share/doc/$PKG_SOURCES
    
    make
}

install_() {
    make install
}
