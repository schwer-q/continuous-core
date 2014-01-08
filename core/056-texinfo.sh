#!/bin/sh -

NAME="texinfo"
VERSION="5.1"
EXT="tar.xz"

build() {
    patch -Np1 -i /sources/texinfo-5.1-test-1.patch

    ./configure \
	--prefix=/usr

    make
}

install_() {
    make install
    
    make TEXMF=/usr/share/texmf install-tex

    cd /usr/share/info
    rm -v dir
    for f in *
    do install-info $f dir 2>/dev/null
    done
}
