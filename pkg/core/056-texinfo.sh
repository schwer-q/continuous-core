#!/bin/sh -

PKG_NAME="texinfo"
PKG_VERSION="5.1"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    patch -Np1 -i /sources/texinfo-5.1-test-1.patch

    ./configure \
	--prefix=/usr

    make
}

_install() {
    make install DESTDIR=$DESTDIR
    make TEXMF=/usr/share/texmf install-tex DESTDIR=$DESTDIR

    cd ${DESTDIR}/usr/share/info
    rm -v dir
    for f in *
    do install-info $f dir 2>/dev/null
    done
}
