#!/bin/sh -

PKG_NAME="setup"
PKG_VERSION="1.0"
NO_UNPACK="yes"
NO_BUILD="yes"
NO_CLEAN="yes"

install_() {
    echo "HOSTPKG_NAME=lfs" > /etc/sysconfig/network

    tar -cvf - -C $PKG_FILES . | tar -xf - -C $DESTDIR
}
