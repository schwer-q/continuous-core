#!/bin/sh -

NAME="ncurses"
VERSION="5.9"
EXT="tar.gz"

build() {
    ./configure			\
	--prefix=/usr		\
	--mandir=/usr/share/man	\
	--with-shared		\
	--without-debug		\
	--enable-pc-files	\
	--enable-widec

    make
}

install_() {
    make install

    mv -v /usr/lib/libncursesw.so.5* /lib
    ln -sfv ../../lib/libncursesw.so.5 /usr/lib/libncursesw.so

    for lib in ncurses form panel menu ; do
	rm -fv				/usr/lib/${lib}.so
	echo "INPUT(-l${lib}w)" >	/usr/lib/lib${lib}.so
	ln -sfv lib${lib}w.a		/usr/lib/lib${lib}.a
	ln -sfv ${lib}w.pc		/usr/lib/pkgconfig/${lib}.pc
    done

    ln -sfv libncurses++w.a /usr/lib/libncurses++.a

    rm -fv			/usr/lib/libcursesw.so
    echo "INPUT(-lncursesw)" >	/usr/lib/libcursesw.so
    ln -sfv libncurses.so	/usr/lib/libcurses.so
    ln -sfv libncursesw.a	/usr/lib/libcursesw.a
    ln -sfv libncurses.a	/usr/lib/libcurses.a

    mkdir -pv		/usr/share/$SOURCES
    cp -v -R doc/*	/usr/share/$SOURCES
}
