#!/bin/sh -

NAME="bash"
VERSION="4.2"
EXT="tar.gz"

build() {
    patch -Np1 -i /sources/bash-4.2-fixes-12.patch
    
    ./configure					\
	--prefix=/usr				\
	--bindir=/bin				\
	--htmldir=/usr/share/doc/$SOURCES	\
	--without-bash-malloc			\
	--with-installed-readline

    make
}

install_() {
    make install
}
