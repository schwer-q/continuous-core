#!/bin/sh -

NAME="xz"
VERSION="5.0.5"
EXT="tar.xz"

build() {
    ./configure		\
	--prefix=/usr	\
	--libdir=/lib	\
	--docdir=/usr/share/doc/$SOURCES

    make
}

install_() {
    make pkgconfigdir=/usr/lib/pkgconfig install
}
