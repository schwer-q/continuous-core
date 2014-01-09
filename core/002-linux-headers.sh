#!/bin/sh -

PKG_NAME="linux"
PKG_VERSION="3.10.10"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    make mrproper

    make headers_check
}

install_() {
    make INSTALL_HDR_PATH=dest headers_install
    find dest/include \( -name .install -o -name ..install.cmd \) -delete
    cp -rv dest/include/* /usr/include
}
