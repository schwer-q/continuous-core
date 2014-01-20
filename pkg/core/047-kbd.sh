#!/bin/sh -

PKG_NAME="kbd"
PKG_VERSION="1.15.5"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    patch -Np1 -i /sources/kbd-1.15.5-backspace-1.patch

    sed -i -e '326 s/if/while/' src/loadkeys.analyze.l

    sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
    sed -i 's/resizecons.8 //' man/man8/Makefile.in

    ./configure		\
	--prefix=/usr	\
	--disable-vlock

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mkdir -pv		${DESTDIR}/usr/share/doc/$PKG_SOURCES
    cp -R -v doc/*	${DESTDIR}/usr/share/doc/$PKG_SOURCES
}
