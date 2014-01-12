#!/bin/sh -

PKG_NAME="binutils"
PKG_VERSION="2.23.2"
PKG_ARCHIVE_EXT="tar.bz2"

USE_EXT_BUILD="yes"

_build() {
    rm -fv etc/standards.info
    sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

    sed -i -e 's/@colophon/@@colophon/' \
	-e 's/doc@cygnus.com/doc@@cygnus.com/' bfd/doc/bfd.texinfo

    cd $PKG_BUILD

    ${PKG_SOURCES}/configure	\
	--prefix=/usr		\
	--host=$LFS_TGT		\
	--enable-shared

    make tooldir=/usr
}

_install() {
    make tooldir=/usr install DESTDIR=$DESTDIR

    cp -v ${PKG_SOURCES}/include/libiberty.h ${DESTDIR}/usr/include
}
