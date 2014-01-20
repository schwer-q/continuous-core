#!/bin/sh -

PKG_NAME="gettext"
PKG_VERSION="0.18.3"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    cd gettext-tools
    EMACS="no"		\
    ./configure		\
	--prefix=/tools	\
	--disable-shared

    make -C gnulib-lib
    make -C src msgfmt
}

_install() {
    cp src/msgfmt /tools/bin
}
