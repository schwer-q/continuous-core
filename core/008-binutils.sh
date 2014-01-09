#!/bin/sh -

NAME="binutils"
VERSION="2.23.2"
EXT="tar.bz2"
BUILDDIR="../${NAME}-build"

build() {
    rm -fv etc/standards.info
    sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in
    
    sed -i -e 's/@colophon/@@colophon/' \
	-e 's/doc@cygnus.com/doc@@cygnus.com/' bfd/doc/bfd.texinfo

    mkdir -v $BUILDDIR
    cd $BUILDDIR

    ../${SOURCES}/configure	\
	--prefix=/usr		\
	--enable-shared

    make tooldir=/usr
}

install_() {
    make tooldir=/usr install

    cp -v ../${SOURCES}/include/libiberty.h /usr/include
}
