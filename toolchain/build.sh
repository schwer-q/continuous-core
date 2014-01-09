#!/bin/sh -

set -e
set +h
umask 022

CURDIR=$(pwd)
LC_ALL="POSIX"
LFS="/home/lfs"
LFS_TGT="`uname -m`-lfs-linux-gnu"
PATH="/tools/bin:/bin:/usr/bin"
export LC_ALL LFS LFS_TGT PATH

if test -z "$1"; then
    files=`find $CURDIR | egrep '[[:digit:]]{3}-[[:alnum:]_]+\.sh$' | sort -V`

    mkdir -pv ${LFS}/tools
    rm -fv /tools
    ln -sfv ${LFS}/tools /tools

    echo "===> Toolchain build started on `date`"
    for file in $files; do
	$0 $file
    done
    echo "===> Toolchain build completed on `date`"
    exit $?
fi

# set -x

unpack() {
    tar xf $1
    
    cd $SOURCES
}

clean() {
    rm -rf $SOURCES
    test -d "$BUILDDIR" && rm -rf $BUILDDIR
    return 0
}

. $1

: ${SOURCES="${NAME}-${VERSION}"}
: ${ARCHIVE="${SOURCES}.${EXT}"}
: ${BUILDDIR="${SOURCES}"}

if test -z "$NO_CLEAN"; then
    cd $CURDIR
    echo "===> Cleanning ${NAME}-${VERSION}..."
    clean
fi

if test -z "$NO_UNPACK"; then
    echo "===> Unpacking ${NAME}-${VERSION}..."
    unpack ${LFS}/sources/$ARCHIVE
fi

if test -z "$NO_BUILD"; then
    echo "===> Building ${NAME}-${VERSION}..."
    build
fi

echo "===> Installing ${NAME}-${VERSION}..."
install_

if test -z "$NO_CLEAN"; then
    cd $CURDIR
    echo "===> Cleanning ${NAME}-${VERSION}..."
    clean
fi

exit 0
