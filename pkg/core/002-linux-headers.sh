#!/bin/sh -

PKG_NAME="linux-headers"
PKG_VERSION="3.10.10"
PKG_SOURCES="linux-${PKG_VERSION}"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    make mrproper

    make headers_check
}

_install() {
    make INSTALL_HDR_PATH=dest headers_install
    find dest/include '(' -name .install -o -name ..install.cmd ')' -delete
    find dest/include '(' -name .check -o -name ..check.cmd ')' -delete
    mkdir -pv ${DESTDIR}/usr/include
    cp -rv dest/include/* ${DESTDIR}/usr/include
}
