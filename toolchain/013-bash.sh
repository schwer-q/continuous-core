#!/bin/sh -

PKG_NAME="bash"
PKG_VERSION="4.2"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    patch -Np1 -i ${LFS}/sources/bash-4.2-fixes-12.patch

    ./configure		\
	--prefix=/tools	\
	--without-bash-malloc

    make
}

_install() {
    make install

    ln -fs bash /tools/bin/sh
}
