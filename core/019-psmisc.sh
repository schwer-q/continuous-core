#!/bin/sh -

PKG_NAME="psmisc"
PKG_VERSION="22.20"
EXT="tar.gz"

build() {
    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install

    mv -v /usr/bin/fuser	/bin
    mv -v /usr/bin/killall	/bin
}
