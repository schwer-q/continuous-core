#!/bin/sh -

PKG_NAME="coreutils"
VERSION="8.21"
EXT="tar.xz"

build() {
    patch -Np1 -i /sources/coreutils-8.21-i18n-1.patch

    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/usr		\
	--libexecdir=/usr/lib	\
	--enable-no-install-program=kill,uptime

    make
}

install_() {
    make install

    progs="[ cat chgrp chmod chown cp date dd df
echo false head ln ls mkdir mknod mv nice pwd rm
rmdir sleep stty sync test true uname "

    for p in $progs ; do
	mv -v /usr/bin/$p /bin
    done
    
    mv -v /usr/bin/chroot /usr/sbin
    mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
    sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

    
}
