#!/bin/sh -

NAME="perl"
VERSION="5.18.1"
EXT="tar.bz2"

build() {
    patch -Np1 -i ${LFS}/sources/perl-5.18.1-libc-1.patch
    
    sh Configure -des -Dprefix=/tools

    make
}

install_() {
    cp perl cpan/podlators/pod2man /tools/bin
    mkdir -p /tools/lib/perl5/5.18.1
    cp -R lib/* /tools/lib/perl5/5.18.1
}
