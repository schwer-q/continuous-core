#!/bin/sh -

NAME="coreutils"
VERSION="8.21"
EXT="tar.xz"

build() {
    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/tools		\
	--enable-install-program=hostname
    
    make
}

install_() {
    make install
}
