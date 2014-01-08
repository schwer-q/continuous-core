#!/bin/sh -

NAME="e2fsprogs"
VERSION="1.42.8"
EXT="tar.gz"

build() {
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

install_() {
    make install
    make install-libs

    chmod -v u+w /usr/lib/libcom_err.a
    chmod -v u+w /usr/lib/libe2p.a
    chmod -v u+w /usr/lib/libext2fs.a
    chmod -v u+w /usr/lib/libss.a

    gunzip -v /usr/share/info/libext2fs.info.gz
    install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

    makeinfo -o				doc/com_err.info ../lib/et/com_err.texinfo
    /tools/bin/install -v -m 644	doc/com_err.info /usr/share/info
    install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
}
