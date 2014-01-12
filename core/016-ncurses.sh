#!/bin/sh -

PKG_NAME="ncurses"
PKG_VERSION="5.9"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    ./configure			\
	--prefix=/usr		\
	--mandir=/usr/share/man	\
	--with-shared		\
	--without-debug		\
	--enable-pc-files	\
	--enable-widec

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/usr/lib/libncursesw.so.5* ${DESTDIR}/lib
    ln -sfv ../../lib/libncursesw.so.5 ${DESTDIR}/usr/lib/libncursesw.so

    for lib in ncurses form panel menu ; do
	rm -fv				${DESTDIR}/usr/lib/${lib}.so
	echo "INPUT(-l${lib}w)" >	${DESTDIR}/usr/lib/lib${lib}.so
	ln -sfv lib${lib}w.a		${DESTDIR}/usr/lib/lib${lib}.a
	ln -sfv ${lib}w.pc		${DESTDIR}/usr/lib/pkgconfig/${lib}.pc
    done

    ln -sfv libncurses++w.a ${DESTDIR}/usr/lib/libncurses++.a

    rm -fv			${DESTDIR}/usr/lib/libcursesw.so
    echo "INPUT(-lncursesw)" >	${DESTDIR}/usr/lib/libcursesw.so
    ln -sfv libncurses.so	${DESTDIR}/usr/lib/libcurses.so
    ln -sfv libncursesw.a	${DESTDIR}/usr/lib/libcursesw.a
    ln -sfv libncurses.a	${DESTDIR}/usr/lib/libcurses.a

    mkdir -pv		${DESTDIR}/usr/share/$PKG_SOURCES
    cp -v -R doc/*	${DESTDIR}/usr/share/$PKG_SOURCES
}
