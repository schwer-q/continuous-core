#!/bin/sh -

PKG_NAME="kmod"
PKG_VERSION="14"
PKG_ARCHIVE_EXT="tar.xz"

build() {
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

install_() {
    make pkgconfigdir=/usr/lib/pkgconfig install
    
    for target in depmod insmod modinfo modprobe rmmod ; do
	ln -sv ../bin/kmod /sbin/$target
    done

    ln -sfv kmod /bin/lsmod
}
