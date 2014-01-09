#!/bin/sh -

NAME="linux"
VERSION="3.10.10"
EXT="tar.xz"

build() {
    make mrproper
    
    cp ${CURDIR}/kernel-config .config
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

    cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF
}