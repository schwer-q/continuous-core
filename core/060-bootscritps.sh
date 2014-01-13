#!/bin/sh -

PKG_NAME="lfs-bootscripts"
PKG_VERSION="20130821"
PKG_ARCHIVE_EXT="tar.bz2"

NO_BUILD="yes"

_install() {
    make install DESTDIR=$DESTDIR
}
