#!/bin/sh -

PKG_NAME="systemd"
PKG_VERSION="206"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    tar -xvf /sources/udev-lfs-206-1.tar.bz2

    make -f udev-lfs-206-1/Makefile.lfs
}

_install() {
    make -f udev-lfs-206-1/Makefile.lfs install DESTDIR=$DESTDIR

    build/udevadm hwdb --update

    bash udev-lfs-206-1/init-net-rules.sh
}
