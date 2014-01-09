#!/bin/sh -

PKG_NAME="gmp"
PKG_VERSION="5.1.2"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    ./configure		\
	--prefix=/usr	\
	--enable-cxx

    make
}

install_() {
    make install

    mkdir -pv /usr/share/doc/$PKG_SOURCES
    cp -v doc/isa_abi_headache doc/configuration doc/*.html \
	/usr/share/doc/$PKG_SOURCES
}
