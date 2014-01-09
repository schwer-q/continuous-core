#!/bin/sh -

NAME="vim"
VERSION="7.4"
EXT="tar.bz2"
PKG_SOURCES="${NAME}74"
ARCHIVE="${NAME}-${VERSION}.${EXT}"

build() {
    echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
    
    ./configure		\
	--prefix=/usr	\
	--enable-multibyte

    make
}

install_() {
    make install

    ln -sfv vim /usr/bin/vi
    
    for L in  /usr/share/man/man1/vim.1 \
	/usr/share/man/*/man1/vim.1; do
	ln -sfv vim.1 $(dirname $L)/vi.1
    done

    ln -sfv ../vim/vim74/doc /usr/share/doc/$PKG_SOURCES

    tar -cvf - -C $PKG_FILES | tar -xf - -C $DESTDIR
}
