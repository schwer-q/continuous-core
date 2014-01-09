#!/bin/sh -

PKG_NAME="man-pages"
VERSION="3.53"
EXT="tar.xz"

build() {
    make gz
}

install_() {
    make install
}
