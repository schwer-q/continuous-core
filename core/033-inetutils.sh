#!/bin/sh -

PKG_NAME="inetutils"
PKG_VERSION="1.9.1"
PKG_ARCHIVE_EXT="tar.gz"

build() {
    sed -i -e '/gets is a/d' lib/stdio.in.h

    ./configure \
	--prefix=/usr \
	--libexecdir=/usr/sbin \
	--localstatedir=/var \
	--disable-ifconfig \
	--disable-logger \
	--disable-syslogd \
	--disable-whois \
	--disable-servers

    make
}

install_() {
    make install

    mv -v /usr/bin/hostname	/bin
    mv -v /usr/bin/ping		/bin
    mv -v /usr/bin/ping6	/bin
    mv -v /usr/bin/traceroute	/bin
}
