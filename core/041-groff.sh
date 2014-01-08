#!/bin/sh -

NAME="groff"
VERSION="1.22.2"
EXT="tar.gz"

build() {
    PAGE="A4"	\
    ./configure	\
	--prefix=/usr

    make
}

install_() {
    mkdir -pv /usr/share/doc/${SOURCES}/pdf

    make install

    ln -sfv eqn /usr/bin/geqn
    ln -sfv tbl /usr/bin/gtbl
}
