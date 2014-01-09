#!/bin/sh -

PKG_NAME="sysklogd"
PKG_VERSION="1.5"
EXT="tar.gz"

build() {
    make
}

install_() {
    make BINDIR=/sbin install

    tar -cvf - -C $PKG_FILES . | tar -xf - -C $DESTDIR
}
