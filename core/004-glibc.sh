#!/bin/sh -

NAME="glibc"
VERSION="2.18"
EXT="tar.xz"
BUILDDIR="../${NAME}-build"

build() {
    sed -i -e 's/static __m128i/inline &/' sysdeps/x86_64/multiarch/strstr.c

    mkdir -v $BUILDDIR
    cd $BUILDDIR

    ../${SOURCES}/configure	\
	--prefix=/usr		\
	--disable-profile	\
	--enable-kernel=2.6.32	\
	--libexecdir=/usr/lib/glibc

    make
}

install_() {
    touch /etc/ld.so.conf

    make install

    cp -v ../${SOURCES}/sunrpc/rpc/*.h /usr/include/rpc
    cp -v ../${SOURCES}/sunrpc/rpcsvc/*.h /usr/include/rpcsvc
    cp -v ../${SOURCES}/nis/rpcsvc/*.h /usr/include/rpcsvc

    mkdir -pv /usr/lib/locale

    make localedata/install-locales

    cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

    tar -xf /sources/tzdata2013d.tar.gz

    ZONEINFO="/usr/share/zoneinfo"
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

    cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf

# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF

    mkdir -pv /etc/ld.so.conf.d
}

clean() {
    rm -rf $SOURCES
    rm -rf ${NAME}-build
}
