#!/bin/sh -

PKG_NAME="sysvinit"
PKG_VERSION="2.88dsf"
PKG_ARCHIVE_EXT="tar.bz2"

build() {
    sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

    sed -i -e '/utmpdump/d' \
	-e '/mountpoint/d' src/Makefile

    make -C src
}

install_() {
    make -C src install

    tar -cvf - -C $PKG_FILES . | tar -xf - -C $DESTDIR
}
