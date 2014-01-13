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
    files=`find $CURDIR | egrep '[[:digit:]]{3}-[[:alnum:]_-]+\.sh$' | sort -V`

    mkdir -pv ${LFS}/tools
    mkdir -pv ${LFS}/logs/toolchain
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

. ../lib/common.sh
. $1

: ${PKG_SOURCES="${PKG_NAME}-${PKG_VERSION}"}
: ${PKG_ARCHIVE="${PKG_SOURCES}.${PKG_ARCHIVE_EXT}"}

PKG_SCRIPT=`basename $(echo $1 | sed 's/\.sh$//')`
PKG_FILES="${CURDIR}/files/$PKG_SCRIPT"
PKG_LOGFILE="${LFS}/logs/toolchain/${PKG_SCRIPT}.log"
PKG_SOURCES="${CURDIR}/${PKG_SOURCES}"

NO_STATUS="yes"

log_start
do_clean
do_unpack
do_build
do_install
do_clean
log_stop

exit 0
