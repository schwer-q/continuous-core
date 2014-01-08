#!/bin/sh -

NAME="gcc"
VERSION="4.8.1"
EXT="tar.bz2"

build() {
    mkdir ../${NAME}-build
    cd ../${NAME}-build

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

install() {
    make install
}

clean() {
    rm -rf $SOURCES
    rm -rf ${NAME}-build
}
