#!/bin/sh -

PKG_NAME="util-linux"
PKG_VERSION="2.23.2"
EXT="tar.xz"

build() {
    sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
	$(grep -rl '/etc/adjtime' .)
    
    mkdir -pv /var/lib/hwclock

    ./configure			\
	--disable-su		\
	--disable-sulogin	\
	--disable-login

    make
}

install_() {
    make install
}
