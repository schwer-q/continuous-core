#!/bin/sh -

NAME="man-db"
VERSION="2.6.5"
EXT="tar.xz"

build() {
    ./configure					\
	--prefix=/usr				\
        --libexecdir=/usr/lib			\
        --docdir=/usr/share/doc/man-db-2.6.5	\
        --sysconfdir=/etc			\
        --disable-setuid			\
        --with-browser=/usr/bin/lynx		\
        --with-vgrind=/usr/bin/vgrind		\
        --with-grap=/usr/bin/grap

    make
}

install_() {
    make install
}
