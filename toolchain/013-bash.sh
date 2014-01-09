#!/bin/sh -

NAME="bash"
VERSION="4.2"
EXT="tar.gz"

build() {
    patch -Np1 -i ${LFS}/sources/bash-4.2-fixes-12.patch

    ./configure		\
	--prefix=/tools	\
	--without-bash-malloc

    make
}

install_() {
    make install

    ln -fs bash /tools/bin/sh
}
