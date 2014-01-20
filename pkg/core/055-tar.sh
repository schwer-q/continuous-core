#!/bin/sh -

PKG_NAME="tar"
PKG_VERSION="1.26"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    patch -Np1 -i /sources/tar-1.26-manpage-1.patch

    sed -i -e '/gets is a/d' gnu/stdio.in.h

    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/usr		\
        --bindir=/bin		\
        --libexecdir=/usr/sbin

    make
}

_install() {
    make install DESTDIR=$DESTDIR
    make -C doc install-html docdir=/usr/share/doc/$PKG_SOURCES DESTDIR=$DESTDIR

    perl tarman > ${DESTDIR}/usr/share/man/man1/tar.1
}
