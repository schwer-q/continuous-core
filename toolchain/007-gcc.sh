#!/bin/sh -

NAME="gcc"
VERSION="4.8.1"
EXT="tar.bz2"

build() {
    cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	`dirname $(${LFS_TGT}-gcc -print-libgcc-file-name)`/include-fixed/limits.h

    cp gcc/Makefile.in gcc/Makefile.in.tmp
    sed 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp > \
	gcc/Makefile.in

    for file in \
	$(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
    do
	cp -u $file ${file}.orig
	sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
	    -e 's@/usr@/tools@g' ${file}.orig > $file
	echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""
' >> $file
	touch ${file}.orig
    done

    tar -Jxf ${LFS}/sources/gmp-5.1.2.tar.xz
    tar -Jxf ${LFS}/sources/mpfr-3.1.2.tar.xz
    tar -zxf ${LFS}/sources/mpc-1.0.1.tar.gz

    mv gmp-5.1.2 gmp
    mv mpc-1.0.1 mpc
    mv mpfr-3.1.2 mpfr

    mkdir ../${NAME}-build
    cd ../${NAME}-build

    ../${SOURCES}/configure					\
	--prefix=/tools						\
	--build=$LFS_TGT					\
	--host=$LFS_TGT						\
	--with-local-prefix=/tools				\
	--with-native-system-header-dir=/tools/include		\
	--enable-clocale=gnu					\
	--enable-shared						\
	--enable-threads=posix					\
	--enable-__cxa_atexit					\
	--enable-languages=c,c++				\
	--disable-libstdcxx-pch					\
	--disable-multilib					\
	--disable-bootstrap					\
	--disable-libgomp					\
	--with-mpfr-include=$(pwd)/../gcc-4.8.1/mpfr/src	\
	--with-mpfr-lib=$(pwd)/mpfr/src/.libs

    make
}

install() {
    make install

    ln -f -s gcc /tools/bin/cc
}

clean() {
    rm -rf $SOURCES
    rm -rf ${NAME}-build
}
