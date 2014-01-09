#!/bin/sh -

PKG_NAME="zlib"
VERSION="1.2.8"
EXT="tar.xz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
    
    mv -v /usr/lib/libz.so.* /lib
    ln -sfv ../../lib/libz.so.$VERSION /usr/lib/libz.so
}
