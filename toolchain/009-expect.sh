#!/bin/sh -

NAME="expect"
VERSION="5.45"
EXT="tar.gz"
SOURCES="${NAME}${VERSION}"

build() {
    cp configure configure.orig
    sed 's:/usr/local/bin:/bin:' configure.orig > configure

    ./configure			\
	--prefix=/tools		\
	--with-tcl=/tools/lib	\
	--with-tclinclude=/tools/include

    make
}

install() {
    make SCRIPTS="" install
}

clean() {
    rm -rf $SOURCES
}
