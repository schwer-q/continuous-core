#!/bin/sh -

PKG_NAME="bzip2"
PKG_VERSION="1.0.6"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    make
}

_install() {
    make PREFIX=/tools install
}
