#!/bin/sh -

PKG_NAME="inetutils"
PKG_VERSION="1.9.1"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
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

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/usr/bin/hostname	${DESTDIR}/bin
    mv -v ${DESTDIR}/usr/bin/ping	${DESTDIR}/bin
    mv -v ${DESTDIR}/usr/bin/ping6	${DESTDIR}/bin
    mv -v ${DESTDIR}/usr/bin/traceroute	${DESTDIR}/bin
}
