#!/bin/sh -

PKG_NAME="kmod"
PKG_VERSION="14"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    ./configure			\
	--prefix=/usr		\
        --bindir=/bin		\
        --libdir=/lib		\
        --sysconfdir=/etc	\
        --disable-manpages	\
        --with-xz		\
        --with-zlib

    make
}

_install() {
    make pkgconfigdir=/usr/lib/pkgconfig install DESTDIR=$DESTDIR

    for target in depmod insmod modinfo modprobe rmmod ; do
	ln -sv ../bin/kmod ${DESTDIR}/sbin/$target
    done

    ln -sfv kmod ${DESTDIR}/bin/lsmod
}
