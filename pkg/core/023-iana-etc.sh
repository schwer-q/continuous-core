#!/bin/sh -

PKG_NAME="iana-etc"
PKG_VERSION="2.30"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
