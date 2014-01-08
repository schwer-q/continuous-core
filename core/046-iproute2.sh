#!/bin/sh -

NAME="iproute2"
VERSION="3.10.0"
EXT="tar.xz"

build() {
    sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
    sed -i /ARPD/d Makefile
    sed -i 's/arpd.8//' man/man8/Makefile

    make DESTDIR=
}

install_() {
    make DESTDIR=			\
	MANDIR=/usr/share/man		\
	DOCDIR=/usr/share/doc/$SOURCES	\
	install
}
