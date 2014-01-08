#!/bin/sh -

NAME="ncurses"
VERSION="5.9"
EXT="tar.gz"

build() {
    ./configure		\
	--prefix=/tools	\
	--with-shared	\
	--without-debug	\
	--without-ada	\
	--enable-overwrite

    make
}

install() {
    make install
}

clean() {
    rm -rf $SOURCES
}
