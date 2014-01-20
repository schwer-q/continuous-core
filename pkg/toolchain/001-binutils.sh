#!/bin/sh -

PKG_NAME="binutils"
PKG_VERSION="2.23.2"
PKG_ARCHIVE_EXT="tar.bz2"

USE_EXT_BUILD="yes"

_build() {
    sed -i -e 's/@colophon/@@colophon/' \
	-e 's/doc@cygnus.com/doc@@cygnus.com/' bfd/doc/bfd.texinfo

    cd $PKG_BUILD

    ${PKG_SOURCES}/configure		\
	--prefix=/tools			\
	--with-sysroot=$LFS		\
	--with-lib-path=/tools/lib	\
	--target=$LFS_TGT		\
	--disable-nls			\
	--disable-werror

    make
}

_install() {
    case `uname -m` in
	'x86_64')
	    mkdir /tools/lib && ln -f -s lib /tools/lib64
	    ;;
    esac

    make install
}
