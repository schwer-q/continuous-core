#!/bin/sh -

NAME="bc"
VERSION="1.06.95"
EXT="tar.bz2"

build() {
    ./configure			\
	--prefix=/usr		\
	--mandir=/usr/share/man	\
	--with-readline

    make
}

install_() {
    make install
}
