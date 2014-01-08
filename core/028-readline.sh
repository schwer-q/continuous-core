#!/bin/sh -

NAME="readline"
VERSION="6.2"
EXT="tar.gz"

build() {
    sed -i '/MV.*old/d' Makefile.in
    sed -i '/{OLDSUFF}/c:' support/shlib-install

    patch -Np1 -i /sources/readline-6.2-fixes-1.patch

    ./configure		\
	--prefix=/usr	\
	--libdir=/lib

    make SHLIB_LIBS=-lncurses
}

install_() {
    make install

    mv -v /lib/libreadline.a /usr/lib
    mv -v /lib/libhistory.a  /usr/lib

    rm -v /lib/libreadline.so
    rm -v /lib/libhistory.so

    ln -sfv ../../lib/libreadline.so.6 /usr/lib/libreadline.so
    ln -sfv ../../lib/libhistory.so.6 /usr/lib/libhistory.so

    mkdir -pv /usr/share/doc/$SOURCES
    /tools/bin/install -v -m 644 doc/*.ps doc/*.pdf doc/*.html doc/*.dvi \
	/usr/share/doc/$SOURCES
}
