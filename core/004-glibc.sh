#!/bin/sh -

PKG_NAME="glibc"
PKG_VERSION="2.18"
PKG_ARCHIVE_EXT="tar.xz"
BUILDDIR="${PKG_NAME}-build"

build() {
    sed -i -e 's/static __m128i/inline &/' sysdeps/x86_64/multiarch/strstr.c

    mkdir -v ../$BUILDDIR
    cd ../$BUILDDIR

    ../${PKG_SOURCES}/configure	\
	--prefix=/usr		\
	--disable-profile	\
	--enable-kernel=2.6.32	\
	--libexecdir=/usr/lib/glibc

    make
}

install_() {
    touch /etc/ld.so.conf

    make install

    cp -v ../${PKG_SOURCES}/sunrpc/rpc/*.h	${DESTDIR}/usr/include/rpc
    cp -v ../${PKG_SOURCES}/sunrpc/rpcsvc/*.h	${DESTDIR}/usr/include/rpcsvc
    cp -v ../${PKG_SOURCES}/nis/rpcsvc/*.h	${DESTDIR}/usr/include/rpcsvc

    tar -cvf - -C $PKG_FILES . | tar -xf - -C $DESTDIR

    mkdir -pv ${DESTDIR}/usr/lib/locale
    make localedata/install-locales

    tar -xf /sources/tzdata2013d.tar.gz
    ZONEINFO="${DESTDIR}/usr/share/zoneinfo"
    mkdir -pv			\
	${ZONEINFO}/posix	\
	${ZONEINFO}/right
    for tz in								\
	etcetera southamerica northamerica europe africa antarctica	\
	asia australasia backward pacificnew solar87 solar88 solar89	\
	systemv; do
	zic -L /dev/null	-d ${ZONEINFO}		-y "sh yearistype.sh" $tz
	zic -L /dev/null	-d ${ZONEINFO}/posix	-y "sh yearistype.sh" $tz
	zic -L leapseconds	-d ${ZONEINFO}/right	-y "sh yearistype.sh" $tz
    done

    cp -v zone.tab iso3166.tab $ZONEINFO
    zic -d $ZONEINFO -p Europe/Paris
}
