#!/bin/sh -

PKG_NAME="gawk"
PKG_VERSION="4.1.0"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure		\
	--prefix=/usr	\
	--libexecdir=/usr/lib

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mkdir -pv ${DESTDIR}/usr/share/doc/$PKG_SOURCES
    cp -v doc/awkforai.txt		${DESTDIR}/usr/share/doc/$PKG_SOURCES
    cp -v doc/*.eps doc/*.pdf doc/*.jpg	${DESTDIR}/usr/share/doc/$PKG_SOURCES
}
