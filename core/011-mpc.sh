#!/bin/sh -

NAME="mpc"
VERSION="1.0.1"
EXT="tar.gz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install

    make html
    make install-html
}
