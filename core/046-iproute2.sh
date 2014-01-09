#!/bin/sh -

PKG_NAME="iproute2"
PKG_VERSION="3.10.0"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
    sed -i /ARPD/d Makefile
    sed -i 's/arpd.8//' man/man8/Makefile

    make DESTDIR=
}

install_() {
    make DESTDIR=			\
	MANDIR=/usr/share/man		\
	DOCDIR=/usr/share/doc/$PKG_SOURCES	\
	install
}
