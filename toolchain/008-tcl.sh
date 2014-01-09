#!/bin/sh -

NAME="tcl"
VERSION="8.6.0"
EXT="tar.gz"
SOURCES="${NAME}${VERSION}"
ARCHIVE="${SOURCES}-src.${EXT}"

build() {
    sed -i 's/500/5000/' generic/regc_nfa.c

    cd unix

    ./configure \
	--prefix=/tools

    make
}

install_() {
    make install

    chmod -v u+w /tools/lib/libtcl8.6.so
    make install-private-headers
    ln -fs tclsh8.6 /tools/bin/tclsh
}
