#!/bin/sh -

NAME="linux"
VERSION="3.10.10"
EXT="tar.xz"

build() {
    make mrproper
    
    tar -cvf - -C ${PKG_FILES}/build . | tar -xf - -C .
    make
}

install_() {
    make modules_install

    cp -v arch/x86/boot/bzImage /boot/vmlinuz-${VERSION}-lfs-7.4
    cp -v System.map /boot/System.map-$VERSION
    cp -v .config /boot/config-$VERSION

    /usr/bin/install -d /usr/share/doc/$PKG_SOURCES
    cp -r Documentation/* /usr/share/doc/$PKG_SOURCES

    /usr/bin/install -v -m 755 -d /etc/modprobe.d

    tar -cvf - -C ${PKG_FILES}/install . | tar -xf - -C $DESTDIR
}
