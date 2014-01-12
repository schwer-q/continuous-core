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
	--build=$LFS_TGT		\
	--host=$LFS_TGT			\
	--disable-nls			\
	--with-lib-path=/tools/lib	\
	--with-sysroot

    make
}

install_() {
    make install

    make -C ld clean
    make -C ld LIB_PATH="/usr/lib:/lib"
    cp ld/ld-new /tools/bin
}
