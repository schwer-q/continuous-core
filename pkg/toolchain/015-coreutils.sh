#!/bin/sh -

PKG_NAME="coreutils"
PKG_VERSION="8.21"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/tools		\
	--enable-install-program=hostname

    make
}

_install() {
    make install
}
