#!/bin/sh -

PKG_NAME="tar"
PKG_VERSION="1.26"
PKG_ARCHIVE_EXT="tar.bz2"

build() {
    patch -Np1 -i /sources/tar-1.26-manpage-1.patch

    sed -i -e '/gets is a/d' gnu/stdio.in.h

    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/usr		\
        --bindir=/bin		\
        --libexecdir=/usr/sbin

    make
}

install_() {
    make install

    make -C doc install-html docdir=/usr/share/doc/$PKG_SOURCES

    perl tarman > /usr/share/man/man1/tar.1
}
