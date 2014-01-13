#!/bin/sh -

PKG_NAME="linux"
PKG_VERSION="3.10.10"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    make mrproper

    dump_files ${PKG_FILES}/build $PKG_SOURCES
    make
}

_install() {
    make modules_install DESTDIR=$DESTDIR

    cp -v arch/x86/boot/bzImage ${DESTDIR}/boot/vmlinuz-${PKG_VERSION}-lfs-7.4
    cp -v System.map ${DESTDIR}/boot/System.map-$PKG_VERSION
    cp -v .config ${DESTDIR}/boot/config-$PKG_VERSION

    install -d ${DESTDIR}/usr/share/doc/$PKG_SOURCES
    cp -r Documentation/* ${DESTDIR}/usr/share/doc/$PKG_SOURCES

    install -v -m 755 -d ${DESTDIR}/etc/modprobe.d

    dump_files ${PKG_FILES}/install $DESTDIR
}
