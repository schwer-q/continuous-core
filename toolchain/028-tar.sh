#!/bin/sh -

NAME="tar"
VERSION="1.26"
EXT="tar.bz2"

build() {
    sed -i -e '/gets is a/d' gnu/stdio.in.h

    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/tools
    
    make
}

install_() {
    make install
}
