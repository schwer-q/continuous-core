#!/bin/sh -

PKG_NAME="shadow"
PKG_VERSION="4.1.5.1"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    sed -i 's/groups$(EXEEXT) //' src/Makefile.in
    find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

    sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
	-e 's@/var/spool/mail@/var/mail@' etc/login.defs

    ./configure \
	--sysconfdir=/etc

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    mv -v ${DESTDIR}/usr/bin/passwd ${DESTDIR}/bin

    pwconv
    grpconv
}
