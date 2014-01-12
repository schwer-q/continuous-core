#!/bin/sh -

PKG_NAME="flex"
PKG_VERSION="2.5.37"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    sed -i -e '/test-bison/d' tests/Makefile.in

    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    ln -sfv libfl.a ${DESTDIR}/usr/lib/libl.a

    dump_files $PKG_FILES $DESTDIR
    chmod -v 755 ${DESTDIR}/usr/bin/lex
}
