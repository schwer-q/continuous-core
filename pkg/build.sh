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

unset files

case "$1" in
    'core'|'toolchain')
	files=`find ${CURDIR}/pkg/$1 | sort -V`
	;;
    *.sh)
	;;
    *)
	echo "Unknown components"
	exit 2
	;;
esac

if test -n "$files"; then
    for f in $files; do
	(basename $f | egrep -q '^[[:digit:]]{3}-[[:alnum:]_-]+\.sh$') || continue
	sh $0 $file
    done
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
