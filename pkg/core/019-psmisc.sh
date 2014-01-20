#!/bin/sh -

PKG_NAME="psmisc"
PKG_VERSION="22.20"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install $DESTDIR

    mv -v ${DESTDIR}/usr/bin/fuser	${DESTDIR}/bin
    mv -v ${DESTDIR}/usr/bin/killall	${DESTDIR}/bin
}
