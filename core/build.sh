#!/bin/sh -

set -e
set +h
umask 022

CURDIR=$(pwd)
HOME="/root"
LC_ALL="POSIX"
LFS_TGT="`uname -m`-lfs-linux-gnu"
PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"
export HOME LC_ALL PATH

if test -z "$1"; then
    files=`find $CURDIR | egrep '[[:digit:]]{3}-[[:alnum:]_]+\.sh$' | sort -V`

    echo "===> Core build started on `date`"
    for file in $files; do
	sh $0 $file
    done
    echo "===> Core build completed on `date`"
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

test -e /logs/$SOURCES && rm -f /logs/$SOURCES

echo "$NAME $VERSION"
if test -z "$NO_CLEAN"; then
    cd $CURDIR
    echo -n "  Cleanning..."
    echo "===> Cleanning..." 2>&1 >> /logs/$SOURCES
    clean 2>&1 >> /logs/$SOURCES
    echo " done."
fi

if test -z "$NO_UNPACK"; then
    echo -n "  Unpacking..."
    echo "===> Unpacking..." 2>&1 >> /logs/$SOURCES
    unpack ${LFS}/sources/$ARCHIVE 2>&1 >> /logs/$SOURCES
    echo " done."
fi

if test -z "$NO_BUILD"; then
    echo -n "  Building..."
    echo "===> Building..." 2>&1 >> /logs/$SOURCES
    build 2>&1 >> /logs/$SOURCES
    echo " done."
fi

echo -n "  Installing..."
install_ 2>&1 >> /logs/$SOURCES
echo " done."

if test -z "$NO_CLEAN"; then
    cd $CURDIR
    echo -n "  Cleanning..."
    echo "===> Cleanning..." 2>&1 >> /logs/$SOURCES
    clean 2>&1 >> /logs/$SOURCES
    echo " done."
fi

exit 0
