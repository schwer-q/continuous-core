#!/bin/sh -

PKG_NAME="bzip2"
PKG_VERSION="1.0.6"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    patch -Np1 -i /sources/bzip2-1.0.6-install_docs-1.patch

    sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

    sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

    make -f Makefile-libbz2_so
    make clean

    make
}

_install() {
    make PREFIX=/usr install DESTDIR=$DESTDIR

    cp -v bzip2-shared ${DESTDIR}/bin/bzip2
    cp -av libbz2.so* ${DESTDIR}/lib
    ln -sfv ../../lib/libbz2.so.1.0 ${DESTDIR}/usr/lib/libbz2.so
    rm -v /usr/bin/bunzip2 /usr/bin/bzcat ${DESTDIR}/usr/bin/bzip2
    ln -sfv bzip2 ${DESTDIR}/bin/bunzip2
    ln -sfv bzip2 ${DESTDIR}/bin/bzcat
}
