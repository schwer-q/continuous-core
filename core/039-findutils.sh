#!/bin/sh -

NAME="findutils"
VERSION="4.4.2"
EXT="tar.gz"

build() {
    ./configure				\
	--prefix=/usr			\
	--libexecdir=/usr/lib/$NAME	\
	--localstatedir=/var/lib/locate

    make
}

install_() {
    make install
    
    mv -v /usr/bin/find /bin

    sed -i 's/find:=${BINDIR}/find:=\/bin/' /usr/bin/updatedb
}
