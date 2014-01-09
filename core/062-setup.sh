#!/bin/sh -

NAME="setup"
VERSION="1.0"
NO_UNPACK="yes"
NO_BUILD="yes"
NO_CLEAN="yes"

install_() {
    echo "HOSTNAME=lfs" > /etc/sysconfig/network

    tar -cvf - -C $PKG_FILES | tar -xf - -C $DESTDIR
}
