#!/bin/sh -

PKG_NAME="gcc"
VERSION="4.8.1"
EXT="tar.bz2"
BUILDDIR="${PKG_NAME}-build"

build() {
    case `uname -m` in
	i?86)
	    sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
    esac

    sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in

    sed -i -e '/autogen/d' -e '/check.sh/d' fixincludes/Makefile.in
    mv -v libmudflap/testsuite/libmudflap.c++/pass41-frag.cxx \
	libmudflap/testsuite/libmudflap.c++/pass41-frag.cxx.disable

    mkdir -pv ../$BUILDDIR
    cd ../$BUILDDIR

    ../${PKG_SOURCES}/configure		\
	--prefix=/usr			\
	--host=$LFS_TGT			\
	--libexecdir=/usr/lib		\
	--enable-shared			\
	--enable-thread=posix		\
	--enable-__cxa_atexit		\
	--enable-clocale=gnu		\
	--enable-languages=c,c++	\
	--disable-multilib		\
	--disable-bootstrap		\
	--disable-install-libiberty	\
	--with-system-zlib

    make
}

install_() {
    make install

    ln -sfv ../usr/bin/cpp	/lib
    ln -sfv gcc			/usr/bin/cc

    mkdir -pv /usr/share/gdb/auto-load/usr/lib
    mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
}
