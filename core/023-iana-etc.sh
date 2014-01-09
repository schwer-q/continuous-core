#!/bin/sh -

PKG_NAME="iana-etc"
PKG_VERSION="2.30"
PKG_ARCHIVE_EXT="tar.bz2"

build() {
    make
}

install_() {
    make install
}
