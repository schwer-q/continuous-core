#!/bin/sh -

PKG_NAME="sysklogd"
PKG_VERSION="1.5"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    make
}

_install() {
    make BINDIR=/sbin install DESTDIR=$DESTDIR

    dump_files $PKG_FILES $DESTDIR
}
