#!/bin/sh -

NAME="gmp"
VERSION="5.1.2"
EXT="tar.xz"

build() {
    ./configure		\
	--prefix=/usr	\
	--enable-cxx

    make
}

install_() {
    make install

    mkdir -pv /usr/share/doc/$SOURCES
    cp -v doc/isa_abi_headache doc/configuration doc/*.html \
	/usr/share/doc/$SOURCES
}
