#!/bin/sh -

set -e
set +h

CURDIR=$(pwd)
LC_ALL="POSIX"
LFS="/home/lfs"
LFS_CORE="${LFS}/core"
LFS_LOG="${LFS}/logs"
LFS_SOURCES="${LFS}/sources"
LFS_TOOLCHAIN="${LFS}/tools"
export LC_ALL LFS

clean() {
    echo -n "Cleanning..."
    test -z "$KEEP_CORE" && rm -rf $LFS_CORE
    test -z "$KEEP_SOURCES" && rm -rf $LFS_SOURCES
    test -z "$KEEP_TOOLCHAIN" && rm -rf $LFS_TOOLCHAIN
    rm -f /tools
    echo " done"
    return 0
}

core_setup() {
    echo -n "Setting up core build..."

    mkdir -p ${LFS_CORE}/build
    cp -r core/* ${LFS_CORE}/build

    mkdir -p ${LFS_CORE}/sources
    mkdir -p ${LFS_CORE}/tools

    mkdir -p ${LFS_CORE}/dev
    mkdir -p ${LFS_CORE}/proc
    mkdir -p ${LFS_CORE}/sys

    mkdir -p ${LFS_LOG}/core
    mkdir -p ${LFS_CORE}/logs

    mknod -m 600 ${LFS_CORE}/dev/console	c 5 1
    mknod -m 666 ${LFS_CORE}/dev/null		c 1 3

    mount --bind	/dev		${LFS_CORE}/dev
    mount -t devpts	devpts		${LFS_CORE}/dev/pts -o gid=5,mode=620
    mount -t proc	proc		${LFS_CORE}/proc
    mount -t sysfs	sysfs		${LFS_CORE}/sys
    mount --bind	$LFS_SOURCES	${LFS_CORE}/sources
    mount --bind	$LFS_TOOLCHAIN	${LFS_CORE}/tools
    mount --bind	${LFS_LOG}/core	${LFS_CORE}/logs

    if [ -h ${LFS_CORE}/dev/shm ]; then
	link=`readlink ${LFS_CORE}/dev/shm`
	mkdir -p ${LFS_CORE}/$link
	mount -t tmpfs shm ${LFS_CORE}/$link
	unset link
    else
	mount -t tmpfs shm ${LFS_CORE}/dev/shm
    fi

    echo " done."
    return 0
}

core_unsetup() {
    echo -n "Cleanning up core..."

    mounts=`mount | grep $LFS | cut -d' ' -f3 | sort -r`

    for m in $mounts ; do
	umount $m
    done

    rm -rf ${LFS_CORE}/build
    rm -rf ${LFS_CORE}/logs
    rm -rf ${LFS_CORE}/sources
    rm -rf ${LFS_CORE}/tools

    echo " done."

    return 0
}

downlod() {
    test -n "$NO_DOWNLOAD" && return 0

    echo "Downloading..."
    mkdir -p $LFS_SOURCES
    wget -c -N -i misc/wget-list -P ${LFS}/sources || true

    echo "Validating..."
    cd $LFS_SOURCES
    md5sum -c ${CURDIR}/misc/md5sums
    cd $CURDIR
    return 0
}

show_time() {
    time=$(($end_time - $start_time))
    day=$(($time / 86400))
    time=$(($time % 86400))
    hour=$(($time / 3600))
    time=$(($time % 3600))
    min=$(($time / 60))
    sec=$(($time % 60))

    echo -n "Build completed in: "
    test $day -eq 0 || echo -n "$day days "
    test $hour -eq 0 || echo -n "$hour hours "
    test $min -eq 0 || echo -n "$min minutes "
    echo "$sec seconds"
}

while getopts 'cCdstT' ch ; do
    case "$ch" in
	'c')
	    KEEP_CORE="yes"
	    ;;
	'C')
	    SKIP_CORE="yes"
	    ;;
	'd')
	    NO_DOWNLOAD="yes"
	    ;;
	's')
	    KEEP_SOURCES="yes"
	    ;;
	't')
	    KEEP_TOOLCHAIN="yes"
	    ;;
	'T')
	    SKIP_TOOLCHAIN="yes"
	    ;;
    esac
done
shift $(($OPTIND - 1))

mounts=`mount | grep $LFS | cut -d' ' -f3 | sort -r`

for m in $mounts ; do
    umount $m
done

clean
downlod

echo "===> Build started on `date`"
start_time=`date '+s'`

cd toolchain
test -z "$SKIP_TOOLCHAIN" && ./build.sh
cd $CURDIR

if test -z "$SKIP_CORE"; then
    core_setup

    chroot "$LFS_CORE" /tools/bin/env -i		\
	HOME="/root"					\
	TERM="$TERM"					\
	PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"	\
	/tools/bin/bash --login +h			\
	-c "cd /build && /tools/bin/bash ./build.sh"

    core_unsetup
fi

end_time=`date '+s'`
show_time
echo "===> Build completed on `date`"
exit 0
