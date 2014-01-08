#!/bin/sh -

NAME="automake"
VERSION="1.14"
EXT="tar.xz"

build() {
    patch -Np1 -i /sources/automake-1.14-test-1.patch

    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$SOURCES

    make
}

install_() {
    make install
}
