#!/bin/sh -

PKG_NAME="bzip2"
PKG_VERSION="1.0.6"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    patch -Np1 -i /sources/bzip2-1.0.6-install_docs-1.patch

    sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

    sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

    make -f Makefile-libbz2_so
    make clean

    make
}

install_() {
    make PREFIX=/usr install

    cp -v bzip2-shared /bin/bzip2
    cp -av libbz2.so* /lib
    ln -sfv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
    rm -v /usr/bin/bunzip2 /usr/bin/bzcat /usr/bin/bzip2
    ln -sfv bzip2 /bin/bunzip2
    ln -sfv bzip2 /bin/bzcat
}
