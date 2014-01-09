#!/bin/sh -

NAME="iana-etc"
VERSION="2.30"
EXT="tar.bz2"

build() {
    make
}

install_() {
    make install
}
