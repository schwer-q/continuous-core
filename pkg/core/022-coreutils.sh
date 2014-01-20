#!/bin/sh -

PKG_NAME="coreutils"
PKG_VERSION="8.21"
PKG_ARCHIVE_EXT="tar.xz"

_build() {
    patch -Np1 -i /sources/coreutils-8.21-i18n-1.patch

    FORCE_UNSAFE_CONFIGURE=1	\
    ./configure			\
	--prefix=/usr		\
	--libexecdir=/usr/lib	\
	--enable-no-install-program=kill,uptime

    make
}

_install() {
    make install DESTDIR=$DESTDIR

    progs="[ cat chgrp chmod chown cp date dd df
echo false head ln ls mkdir mknod mv nice pwd rm
rmdir sleep stty sync test true uname "

    for p in $progs ; do
	mv -v ${DESTDIR}/usr/bin/$p ${DESTDIR}/bin
    done

    mv -v ${DESTDIR}/usr/bin/chroot ${DESTDIR}/usr/sbin
    mv -v ${DESTDIR}/usr/share/man/man1/chroot.1 \
	${DESTDIR}/usr/share/man/man8/chroot.8
    sed -i s/\"1\"/\"8\"/1 ${DESTDIR}/usr/share/man/man8/chroot.8


}
