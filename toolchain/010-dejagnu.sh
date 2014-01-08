#!/bin/sh -

NAME="dejagnu"
VERSION="1.5.1"
EXT="tar.gz"

build() {
    cp configure configure.orig
    sed 's:/usr/local/bin:/bin:' configure.orig > configure

    ./configure \
	--prefix=/tools
}

install() {
    make install
}

clean() {
    rm -rf $SOURCES
}
