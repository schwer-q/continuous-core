#!/bin/sh -

PKG_NAME="e2fsprogs"
PKG_VERSION="1.42.8"
PKG_ARCHIVE_EXT="tar.gz"

_build() {
    sed -i -e 's/mke2fs/$MKE2FS/' \
	-e 's/debugfs/$DEBUGFS/' tests/f_extent_oobounds/script

    mkdir -v build
    cd build

    ../configure		\
    	--prefix=/usr		\
    	--with-root-prefix=""	\
    	--enable-elf-shlibs	\
    	--disable-libblkid	\
    	--disable-libuuid	\
    	--disable-uuidd		\
    	--disable-fsck

    make
}

_install() {
    make install DESTDIR=$DESTDIR
    make install-libs DESTDIR=$DESTDIR

    chmod -v u+w ${DESTDIR}/usr/lib/libcom_err.a
    chmod -v u+w ${DESTDIR}/usr/lib/libe2p.a
    chmod -v u+w ${DESTDIR}/usr/lib/libext2fs.a
    chmod -v u+w ${DESTDIR}/usr/lib/libss.a

    gunzip -9 -v ${DESTDIR}/usr/share/info/libext2fs.info.gz
    install-info --dir-file=${DESTDIR}/usr/share/info/dir ${DESTDIR}/usr/share/info/libext2fs.info

    makeinfo -o		doc/com_err.info ../lib/et/com_err.texinfo
    install -v -m 644	doc/com_err.info ${DESTDIR}/usr/share/info
    install-info --dir-file=${DESTDIR}/usr/share/info/dir ${DESTDIR}/usr/share/info/com_err.info
}
