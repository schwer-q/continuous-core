#!/bin/sh -

set -e
set +h
umask 022

CURDIR=$(pwd)
HOME="/root"
LC_ALL="POSIX"
LFS="/"
PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"
export HOME LC_ALL LFS PATH

if test -z "$1"; then
    files=`find $CURDIR | egrep '[[:digit:]]{3}-[[:alnum:]_-]+\.sh$' | sort -V`

    echo "===> Core build started on `date`"
    for file in $files; do
	sh $0 $file
    done
    echo "===> Core build completed on `date`"
    exit $?
fi

# set -x

. lib/common.sh
. $1

: ${PKG_SOURCES="${PKG_NAME}-${PKG_VERSION}"}
: ${PKG_ARCHIVE="${PKG_SOURCES}.${PKG_ARCHIVE_EXT}"}

PKG_SCRIPT=`basename $(echo $1 | sed 's/\.sh$//')`
PKG_FILES="${CURDIR}/files/$PKG_SCRIPT"
PKG_LOGFILE="/logs/${PKG_SCRIPT}.log"
PKG_SOURCES="${CURDIR}/${PKG_SOURCES}"

log_start
do_clean
do_unpack
do_build
do_install
do_clean
log_stop

exit 0
