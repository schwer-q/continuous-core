#!/bin/sh -

PKG_NAME="gawk"
VERSION="4.1.0"
EXT="tar.xz"

build() {
    ./configure		\
	--prefix=/usr	\
	--libexecdir=/usr/lib

    make
}

install_() {
    make install

    mkdir -pv /usr/share/doc/$PKG_SOURCES
    cp -v doc/awkforai.txt /usr/share/doc/$PKG_SOURCES
    cp -v doc/*.eps doc/*.pdf doc/*.jpg /usr/share/doc/$PKG_SOURCES
}
