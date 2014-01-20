#!/bin/sh -

PKG_NAME="strip"
PKG_VERSION="1.0"

NO_BUILD="yes"
NO_CLEAN="yes"
NO_UNPACK="yes"

_install() {
    strip --strip-debug /tools/lib/*		|| true
    strip --strip-unneeded /tools/bin/*		|| true
    strip --strip-unneeded /tools/sbin/*	|| true

    rm -rf /tools/info /tools/man /tools/doc
    rm -rf /tools/share/info /tools/share/man /tools/share/doc
}
