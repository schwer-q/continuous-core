#!/bin/sh -

PKG_NAME="groff"
PKG_VERSION="1.22.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    PAGE="A4"	\
    ./configure	\
	--prefix=/usr

    make
}

_install() {
    mkdir -pv ${DESTDIR}/usr/share/doc/${PKG_SOURCES}/pdf

    make install DESTDIR=$DESTDIR

    ln -sfv eqn ${DESTDIR}/usr/bin/geqn
    ln -sfv tbl ${DESTDIR}/usr/bin/gtbl
}
