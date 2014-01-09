#!/bin/sh -

NAME="bzip2"
VERSION="1.0.6"
EXT="tar.gz"

build() {
    make
}

install_() {
    make PREFIX=/tools install
}
