#!/bin/sh -

PKG_NAME="readline"
PKG_VERSION="6.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    sed -i '/MV.*old/d' Makefile.in
    sed -i '/{OLDSUFF}/c:' support/shlib-install

    patch -Np1 -i /sources/readline-6.2-fixes-1.patch

    ./configure		\
	--prefix=/usr	\
	--libdir=/lib

    make SHLIB_LIBS=-lncurses
}

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/lib/libreadline.a ${DESTDIR}/usr/lib
    mv -v ${DESTDIR}/lib/libhistory.a  ${DESTDIR}/usr/lib

    rm -v ${DESTDIR}/lib/libreadline.so
    rm -v ${DESTDIR}/lib/libhistory.so

    ln -sfv ../../lib/libreadline.so.6 ${DESTDIR}/usr/lib/libreadline.so
    ln -sfv ../../lib/libhistory.so.6 ${DESTDIR}/usr/lib/libhistory.so

    mkdir -pv ${DESTDIR}/usr/share/doc/$PKG_SOURCES
    install -v -m 644 doc/*.ps doc/*.pdf doc/*.html doc/*.dvi \
	${DESTDIR}/usr/share/doc/$PKG_SOURCES
}
