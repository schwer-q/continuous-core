#!/bin/sh -

set -e
set +h
test "$DEBUG" == "yes" && set -x

CURDIR=$(pwd)
LC_ALL="POSIX"
export CURDIR LC_ALL

: ${DESTDIR="/"}
: ${HOME="/root"}
: ${LFS="/home/lfs"}
: ${LFS_TGT="`uname -m`-lfs-linux-gnu"}
: ${PATH="/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin"}
export DESTDIR HOME LFS LFS_TGT PATH

check_status() {
    mkdir -p ${CURDIR}/status
    test -e "${CURDIR}/status/${PKG_SCRIPT}-${PKG_VERSION}.done" && exit 0
    return 0
}

do_build() {
    test "$NO_BUILD" == "yes" && return 0
    echo -e -n "\tBuilding..."
    log_phase "build"
    if test "$USE_EXT_BUILD" == "yes"; then
	PKG_BUILD="${PKG_SOURCES}/../${PKG_NAME}-build"
	log_exec mkdir -pv $PKG_BUILD
    fi
    log_exec _build
    echo -e "\tdone."
    return 0
}

do_clean() {
    test "$NO_CLEAN" == "yes" && return 0
    echo -e -n "\tCleanning..."
    log_phase "clean"
    cd $CURDIR
    log_exec rm -rf $PKG_SOURCES
    test -d "$PKG_BUILD" && log_exec rm -rf $PKG_BUILD
    echo -e "\tdone."
    return 0
}

do_install() {
    echo -e -n "\tInstalling..."
    log_phase "install"
    log_exec _install
    if test -d ${DESTDIR}/usr/share/man; then
	log_exec find ${DESTDIR}/usr/share/man -type f '( ! -name *.gz )' \
	    -exec gzip -f -9 '{}' ';'
    fi
    echo -e "\tdone."
    return 0
}

do_unpack() {
    test "$NO_UNPACK" == "yes" && return 0
    echo -e -n "\tUnpacking..."
    log_phase "unpack"
    log "$PKG_ARCHIVE"
    log_exec tar xf ${LFS}/sources/$PKG_ARCHIVE
    cd $PKG_SOURCES
    echo -e "\tdone."
    return 0
}

dump_files() {
    origin=$1
    dest=$2

    tar -cvf - -C $origin . | tar -xf - -C $dest
}

log() {
    echo "$*" >> $PKG_LOGFILE
}

log_exec() {
    cmd=$1
    shift
    args="$@"

    $cmd $args >> $PKG_LOGFILE 2>&1
}

log_phase() {
    touch $PKG_LOGFILE
    _tmp=`echo "$1" | tr '[[:print:]]' '='`
    log "===============================${_tmp}"
    log "==========< phase: $1 >=========="
    log "===============================${_tmp}"
    log ""
}

log_start() {
    test -e $PKG_LOGFILE && rm -f $PKG_LOGFILE
    echo ""
    echo "${PKG_NAME} ${PKG_VERSION}"
    log "Build started on `date -u`"
    start_time=`date '+%s'`
    log=""
}

log_stop() {
    touch "${CURDIR}/status/${PKG_SCRIPT}-${PKG_VERSION}.done"
    log "Build completed on `date -u`"
    end_time=`date '+%s'`
    _time=$(($end_time - $start_time))
    day=$(($_time / 86400))
    _time=$(($_time % 86400))
    hour=$(($_time / 3600))
    _time=$(($_time % 3600))
    min=$(($_time / 60))
    sec=$(($_time % 60))
    log "Build time:  ${day}:${hour}:${min}:${sec}"
}
