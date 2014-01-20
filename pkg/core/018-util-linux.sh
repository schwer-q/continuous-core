#!/bin/sh -

PKG_NAME="util-linux"
PKG_VERSION="2.23.2"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
	$(grep -rl '/etc/adjtime' .)

    mkdir -pv ${DESTDIR}/var/lib/hwclock

    ./configure			\
	--disable-su		\
	--disable-sulogin	\
	--disable-login

    make
}

_install() {
    make install DESTDIR=$DESTDIR
}
