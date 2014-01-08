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
	--with-sysroot=$LFS		\
	--with-lib-path=/tools/lib	\
	--target=$LFS_TGT		\
	--disable-nls			\
	--disable-werror

    make
}

install() {
    case `uname -m` in
	'x86_64')
	    mkdir /tools/lib && ln -f -s lib /tools/lib64
	    ;;
    esac

    make install
}

clean() {
    rm -rf $SOURCES
    rm -rf ${NAME}-build
}
