#!/bin/sh -

PKG_NAME="gmp"
PKG_VERSION="5.1.2"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--enable-cxx

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mkdir -pv ${DESTDIR}/usr/share/doc/$PKG_SOURCES
    cp -v doc/isa_abi_headache doc/configuration doc/*.html \
	${DESTDIR}/usr/share/doc/$PKG_SOURCES
}
