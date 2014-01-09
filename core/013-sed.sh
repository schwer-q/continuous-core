#!/bin/sh -

PKG_NAME="sed"
PKG_VERSION="4.2.2"
PKG_ARCHIVE_EXT="tar.bz2"

build() {
    ./configure		\
	--prefix=/usr	\
	--bindir=/bin	\
	--htmldir=/usr/share/doc/$PKG_SOURCES

    make
    
    make html
}

install_() {
    make install
    
    make -C doc install-html
}
