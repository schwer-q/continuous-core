#!/bin/sh -

PKG_NAME="perl"
PKG_VERSION="5.18.1"
EXT="tar.bz2"

build() {
    echo "127.0.0.1 localhost" > /etc/hosts

    sed -i -e "s|BUILD_ZLIB\s*= True|BUILD_ZLIB = False|" \
	-e "s|INCLUDE\s*= ./zlib-src|INCLUDE    = /usr/include|" \
	-e "s|LIB\s*= ./zlib-src|LIB        = /usr/lib|" \
	cpan/Compress-Raw-Zlib/config.in

    sh Configure			\
	-des				\
	-Dprefix=/usr			\
	-Dvendorprefix=/usr		\
	-Dman1dir=/usr/share/man/man1	\
	-Dman3dir=/usr/share/man/man3	\
	-Dpager="/usr/bin/less -isR"	\
	-Duseshrplib

    make
}

install_() {
    make install
}
