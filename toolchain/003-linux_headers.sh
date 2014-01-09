#!/bin/sh -

NAME="linux"
VERSION="3.10.10"
EXT="tar.xz"

build() {
    make mrproper

    make headers_check
}

install_() {
    make INSTALL_HDR_PATH=dest headers_install
    cp -r dest/include/* /tools/include
}
