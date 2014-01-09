#!/bin/sh -

PKG_NAME="iana-etc"
PKG_VERSION="2.30"
EXT="tar.bz2"

build() {
    make
}

install_() {
    make install
}
