#!/bin/sh -

set -e
set +h

CURDIR=$(pwd)
LC_ALL="POSIX"
LFS="/home/lfs"
export LC_ALL LFS

while getopts 'cds' ch ; do
    case "$ch" in
	'c')
	    NO_CLEAN="yes"
	    ;;
	'd')
	    NO_DOWNLOAD="yes"
	    ;;
	's')
	    KEEP_SOURCES="yes"
	    ;;
    esac
done

mounts=`mount | grep $LFS | cut -d' ' -f3 | sort -r`

for m in $mounts ; do
    umount $m
done

if test -z "$NO_CLEAN"; then
    echo "===> Cleanning..."
    if test -z "$KEEP_SOURCES"; then
	rm -rf $LFS
    else
	cd $LFS
	dirs=`ls | grep -v sources`
	for d in $dirs; do
	    rm -rf $d
	done
	cd $CURDIR
    fi
fi

rm -fv /tools

mkdir -pv ${LFS}
mkdir -pv ${LFS}/sources
mkdir -pv ${LFS}/tools
ln -sfv	  ${LFS}/tools /tools

if test -z "$NO_DOWNLOAD"; then
    wget -c -N -i misc/wget-list -P ${LFS}/sources || true
    cd ${LFS}/sources
    md5sum -c ${CURDIR}/misc/md5sums
    cd $CURDIR
fi

echo "===> Build started on `date`"
cd toolchain
./build.sh
cd $CURDIR


cp -r core ${LFS}

mkdir -pv ${LFS}/dev
mkdir -pv ${LFS}/proc
mkdir -pv ${LFS}/sys

mknod -m 600 ${LFS}/dev/console c 5 1
mknod -m 666 ${LFS}/dev/null	c 1 3

mount -v --bind		/dev	${LFS}/dev
mount -vt devpts	devpts	${LFS}/dev/pts -o gid=5,mode=620
mount -vt proc		proc	${LFS}/proc
mount -vt sysfs		sysfs	${LFS}/sys

if [ -h ${LFS}/dev/shm ]; then
    link=$(readlink ${LFS}/dev/shm)
    mkdir -p ${LFS}/$link
    mount -vt tmpfs shm ${LFS}/$link
    unset link
else
    mount -vt tmpfs shm ${LFS}/dev/shm
fi

chroot "$LFS" /tools/bin/env -i				\
    HOME="/root"					\
    TERM="$TERM"					\
    PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"	\
    /tools/bin/bash --login +h				\
    -c "cd core && /tools/bin/bash ./build.sh"

mounts=`mount | grep $LFS | cut -d' ' -f3 | sort -r`

for m in $mounts ; do
    umount $m
done

rm -rf ${LFS}/core

echo "===> Build completed on `date`"
exit 0