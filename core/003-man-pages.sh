#!/bin/sh -

PKG_NAME="man-pages"
PKG_VERSION="3.53"
PKG_ARCHIVE_EXT="tar.xz"

NO_BUILD="yes"

_install() {
    make install DESTDIR=$DESTDIR
}
