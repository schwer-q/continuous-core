#!/bin/sh -

NAME="sed"
VERSION="4.2.2"
EXT="tar.bz2"

build() {
    ./configure		\
	--prefix=/usr	\
	--bindir=/bin	\
	--htmldir=/usr/share/doc/$SOURCES

    make
    
    make html
}

install_() {
    make install
    
    make -C doc install-html
}
