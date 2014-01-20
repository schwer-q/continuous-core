#!/bin/sh -

PKG_NAME="findutils"
PKG_VERSION="4.4.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure				\
	--prefix=/usr			\
	--libexecdir=/usr/lib/$PKG_NAME	\
	--localstatedir=/var/lib/locate

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/usr/bin/find ${DESTDIR}/bin

    sed -i 's/find:=${BINDIR}/find:=\/bin/' ${DESTDIR}/usr/bin/updatedb
}
