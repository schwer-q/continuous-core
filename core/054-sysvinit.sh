#!/bin/sh -

PKG_NAME="sysvinit"
PKG_VERSION="2.88dsf"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    sed -i 's@Sending processes@& configured via /etc/inittab@g' src/init.c

    sed -i -e '/utmpdump/d' \
	-e '/mountpoint/d' src/Makefile

    make -C src
}

_install() {
    make -C src install DESTDIR=$DESTDIR

    dump_files $PKG_FILES $DESTDIR
}
