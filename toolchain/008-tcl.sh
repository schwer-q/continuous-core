#!/bin/sh -

PKG_NAME="tcl"
PKG_VERSION="8.6.0"
PKG_ARCHIVE_EXT="tar.gz"

PKG_SOURCES="${PKG_NAME}${PKG_VERSION}"
PKG_ARCHIVE="${PKG_SOURCES}-src.${PKG_ARCHIVE_EXT}"

_build() {
    sed -i 's/500/5000/' generic/regc_nfa.c

    cd unix

    ./configure \
	--prefix=/tools

    make
}

_install() {
    make install

    chmod -v u+w /tools/lib/libtcl8.6.so
    make install-private-headers
    ln -fs tclsh8.6 /tools/bin/tclsh
}
