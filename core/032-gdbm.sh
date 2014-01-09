#!/bin/sh -

PKG_NAME="gdbm"
VERSION="1.10"
EXT="tar.gz"

build() {
    ./configure		\
	--prefix=/usr	\
	--enable-libgdbm-compat

    make
}

install_() {
    make install
}
