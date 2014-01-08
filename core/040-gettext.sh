#!/bin/sh -

NAME="gettext"
VERSION="0.18.3"
EXT="tar.gz"

build() {
    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$SOURCES

    make
}

install_() {
    make install
}
