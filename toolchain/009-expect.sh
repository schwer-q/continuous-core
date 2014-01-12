#!/bin/sh -

PKG_NAME="expect"
PKG_VERSION="5.45"
PKG_ARCHIVE_EXT="tar.gz"
PKG_SOURCES="${PKG_NAME}${PKG_VERSION}"

_build() {
    cp configure configure.orig
    sed 's:/usr/local/bin:/bin:' configure.orig > configure

    ./configure			\
	--prefix=/tools		\
	--with-tcl=/tools/lib	\
	--with-tclinclude=/tools/include

    make
}

_install() {
    make SCRIPTS="" install
}
