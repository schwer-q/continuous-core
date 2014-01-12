#!/bin/sh -

PKG_NAME="gcc"
PKG_VERSION="4.8.1"
PKG_ARCHIVE_EXT="tar.bz2"

USE_EXT_BUILD="yes"

_build() {
    case `uname -m` in
	i?86)
	    sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
    esac

    sed -i 's/install_to_$(INSTALL_DEST) //' libiberty/Makefile.in

    sed -i -e '/autogen/d' -e '/check.sh/d' fixincludes/Makefile.in
    mv -v libmudflap/testsuite/libmudflap.c++/pass41-frag.cxx \
	libmudflap/testsuite/libmudflap.c++/pass41-frag.cxx.disable

    cd $PKG_BUILD

    ${PKG_SOURCES}/configure		\
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

_install() {
    make install DESTDIR=$DESTDIR

    ln -sfv ../usr/bin/cpp	${DESTDIR}/lib
    ln -sfv gcc			${DESTDIR}/usr/bin/cc

    mkdir -pv ${DESTDIR}/usr/share/gdb/auto-load/usr/lib
    mv -v ${DESTDIR}/usr/lib/*gdb.py ${DESTDIR}/usr/share/gdb/auto-load/usr/lib
}
