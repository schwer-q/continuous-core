#!/bin/sh -

PKG_NAME="linux"
PKG_VERSION="3.10.10"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    make mrproper

    make headers_check
}

_install() {
    make INSTALL_HDR_PATH=dest headers_install
    cp -r dest/include/* /tools/include
}
