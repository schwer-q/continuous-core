#!/bin/sh -

PKG_NAME="man-pages"
PKG_VERSION="3.53"
PKG_ARCHIVE_EXT="tar.xz"

build() {
    make gz
}

install_() {
    make install
}
