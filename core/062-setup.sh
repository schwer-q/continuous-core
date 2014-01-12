#!/bin/sh -

PKG_NAME="setup"
PKG_VERSION="1.0"

NO_BUILD="yes"
NO_CLEAN="yes"
NO_UNPACK="yes"

_install() {
    echo "HOSTPKG_NAME=lfs" > /etc/sysconfig/network

    dump_files $PKG_FILES $DESTDIR
}
