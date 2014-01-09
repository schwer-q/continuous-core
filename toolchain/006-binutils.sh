#!/bin/sh -

NAME="binutils"
VERSION="2.23.2"
EXT="tar.bz2"

build() {
    sed -i -e 's/@colophon/@@colophon/' \
	-e 's/doc@cygnus.com/doc@@cygnus.com/' bfd/doc/bfd.texinfo

    mkdir ../${NAME}-build
    cd ../${NAME}-build

    ../${SOURCES}/configure		\
	--prefix=/tools			\
	--build=$LFS_TGT		\
	--host=$LFS_TGT			\
	--disable-nls			\
	--with-lib-path=/tools/lib	\
	--with-sysroot

    make
}

install() {
    make install

    make -C ld clean
    make -C ld LIB_PATH="/usr/lib:/lib"
    cp ld/ld-new /tools/bin
}

clean() {
    rm -rf $SOURCES
    rm -rf ${NAME}-build
}
