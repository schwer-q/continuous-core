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

    # mkdir -pv $LFS
    # mkdir -pv ${LFS}/tools
    # mkdir -pv ${LFS}/sources
    # rm -fv /tools
    # ln -sfv ${LFS}/tools /tools

    # wget -c -N -i ../misc/wget-list -P ${LFS}/sources || true
    # cd ${LFS}/sources
    # md5sum -c ${CURDIR}/../misc/md5sums
    # cd $CURDIR

    echo "===> Toolchain build started on `date`"
    for file in $files; do
	$0 $file
    done
    echo "===> Toolchain build completed on `date`"
    exit $?
fi

# set -x

unpack() {
    test -z "$NO_UNPACK" || return 0
    tar xf $1
    
    cd $SOURCES
}

. $1

: ${SOURCES="${NAME}-${VERSION}"}
: ${ARCHIVE="${SOURCES}.${EXT}"}

echo "===> Unpacking ${NAME}-${VERSION}..."
unpack ${LFS}/sources/$ARCHIVE

echo "===> Building ${NAME}-${VERSION}..."
build

echo "===> Installing ${NAME}-${VERSION}..."
install

cd $CURDIR
echo "===> Cleanning ${NAME}-${VERSION}..."
clean
exit 0
