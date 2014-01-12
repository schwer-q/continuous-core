#!/bin/sh -

PKG_NAME="glibc"
PKG_VERSION="2.18"
PKG_ARCHIVE_EXT="tar.xz"

USE_EXT_BUILD="yes"

_build() {
    if test ! -r /usr/include/rpc/types.h; then
	mkdir -p /usr/include/rpc
	cp sunrpc/rpc/*.h /usr/include/rpc
    fi

    sed -i -e 's/static __m128i/inline &/' sysdeps/x86_64/multiarch/strstr.c

    cd $PKG_BUILD

    $PKG_SOURCES/configure				\
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

_install() {
    make install
}
