#!/bin/sh -

PKG_NAME="groff"
PKG_VERSION="1.22.2"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    PAGE="A4"	\
    ./configure	\
	--prefix=/usr

    make
}

install_() {
    mkdir -pv /usr/share/doc/${PKG_SOURCES}/pdf

    make install

    ln -sfv eqn /usr/bin/geqn
    ln -sfv tbl /usr/bin/gtbl
}
