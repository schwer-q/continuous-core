#!/bin/sh -

PKG_NAME="owner"
PKG_VERSION="1.0"

NO_BUILD="yes"
NO_CLEAN="yes"
NO_UNPACK="yes"

_install() {
    chown -R root:root ${LFS}/tools
}
