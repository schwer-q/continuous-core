#!/bin/sh -

PKG_NAME="findutils"
PKG_VERSION="4.4.2"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    ./configure				\
	--prefix=/usr			\
	--libexecdir=/usr/lib/$PKG_NAME	\
	--localstatedir=/var/lib/locate

    make
}

install_() {
    make install
    
    mv -v /usr/bin/find /bin

    sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb
}
