#!/bin/sh -

NAME="gcc"
VERSION="4.8.1"
EXT="tar.bz2"
BUILDDIR="${NAME}-build"

build() {
    mkdir ../$BUILDDIR
    cd ../$BUILDDIR

    ../${SOURCES}/libstdc++-v3/configure	\
	--host=$LFS_TGT				\
	--prefix=/tools				\
	--disable-multilib			\
	--disable-shared			\
	--disable-nls				\
	--disable-libstdcxx-threads		\
	--disable-libstdcxx-pch			\
	--with-gxx-include-dir=/tools/${LFS_TGT}/include/c++/4.8.1

    make
}

install_() {
    make install
}
