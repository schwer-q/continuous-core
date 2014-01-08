#!/bin/sh -

NAME="gettext"
VERSION="0.18.3"
EXT="tar.gz"

build() {
    cd gettext-tools
    EMACS="no"		\
    ./configure		\
	--prefix=/tools	\
	--disable-shared
    
    make -C gnulib-lib
    make -C src msgfmt
}

install() {
    cp src/msgfmt /tools/bin
}

clean() {
    rm -rf $SOURCES
}
