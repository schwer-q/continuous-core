#!/bin/sh -

PKG_NAME="perl"
PKG_VERSION="5.18.1"
PKG_ARCHIVE_EXT="tar.bz2"

_build() {
    patch -Np1 -i ${LFS}/sources/perl-5.18.1-libc-1.patch

    sh Configure -des -Dprefix=/tools

    make
}

_install() {
    cp perl cpan/podlators/pod2man /tools/bin
    mkdir -p /tools/lib/perl5/5.18.1
    cp -R lib/* /tools/lib/perl5/5.18.1
}
