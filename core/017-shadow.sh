#!/bin/sh -

NAME="shadow"
VERSION="4.1.5.1"
EXT="tar.bz2"

build() {
    sed -i 's/groups$(EXEEXT) //' src/Makefile.in
    find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

    sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
	-e 's@/var/spool/mail@/var/mail@' etc/login.defs

    ./configure \
	--sysconfdir=/etc

    make
}

install_() {
    make install

    mv -v /usr/bin/passwd /bin

    pwconv
    grpconv
}
