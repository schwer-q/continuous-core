#!/bin/sh -

PKG_NAME="flex"
PKG_VERSION="2.5.37"
PKG_ARCHIVE_EXT="tar.bz2"

build() {
    sed -i -e '/test-bison/d' tests/Makefile.in

    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

install_() {
    make install

    ln -sfv libfl.a /usr/lib/libl.a

    tar -cvf - -C $PKG_FILES . | tar -xf - -C $DESTDIR

    chmod -v 755 /usr/bin/lex
}
