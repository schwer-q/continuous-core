#!/bin/sh -

PKG_NAME="gcc"
PKG_VERSION="4.8.1"
PKG_ARCHIVE_EXT="tar.bz2"

USE_EXT_BUILD="yes"

_build() {
    cd $PKG_BUILD

    ${PKG_SOURCES}/libstdc++-v3/configure	\
	--host=$LFS_TGT				\
	--prefix=/tools				\
	--disable-multilib			\
	--disable-shared			\
	--disable-nls				\
	--disable-libstdcxx-threads		\
	--disable-libstdcxx-pch			\
	--with-gxx-include-dir=/tools/${LFS_TGT}/include/c++/$PKG_VERSION

    make
}

_install() {
    make install
}
