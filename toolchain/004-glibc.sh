#!/bin/sh -

NAME="glibc"
VERSION="2.18"
EXT="tar.xz"
BUILDDIR="${NAME}-build"

build() {
    if test ! -r /usr/include/rpc/types.h; then
	mkdir -p /usr/include/rpc
	cp sunrpc/rpc/*.h /usr/include/rpc
    fi

    sed -i -e 's/static __m128i/inline &/' sysdeps/x86_64/multiarch/strstr.c

    mkdir ../$BUILDDIR
    cd ../$BUILDDIR

    ../${SOURCES}/configure				\
	--prefix=/tools					\
	--host=$LFS_TGT					\
	--build=`../${SOURCES}/scripts/config.guess`	\
	--disable-profile				\
	--enable-kernel=2.6.32				\
	--with-headers=/tools/include			\
	libc_cv_forced_unwind=yes			\
	libc_cv_ctors_header=yes			\
	libc_cv_c_cleanup=yes 

    make
}

install_() {
    make install
}
