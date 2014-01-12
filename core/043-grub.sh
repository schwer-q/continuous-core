#!/bin/sh -

PKG_NAME="grub"
PKG_VERSION="2.00"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

    ./configure			\
	--prefix=/usr		\
	--sysconfdir=/etc	\
	--disable-grub-emu-usb	\
	--disable-efiemu	\
	--disable-werror

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
