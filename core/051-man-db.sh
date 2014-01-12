#!/bin/sh -

PKG_NAME="man-db"
PKG_VERSION="2.6.5"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
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

_install() {
    make install DESTDIR=$DESTDIR
}
