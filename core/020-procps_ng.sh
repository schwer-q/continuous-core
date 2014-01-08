#!/bin/sh -

NAME="procps-ng"
VERSION="3.3.8"
EXT="tar.xz"

build() {
    ./configure					\
	--prefix=/usr				\
	--exec-prefix=				\
	--libdir=/usr/lib			\
	--docdir=/usr/share/doc/$SOURCES	\
	--disable-static			\
	--disable-skill				\
	--disable-kill

    make
}

install_() {
    make install
    
    mv -v /usr/lib/libprocps.so.* /lib
    ln -sfv ../../lib/libprocps.so.1.1.2 /usr/lib/libprocps.so
}
