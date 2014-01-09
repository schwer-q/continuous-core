#!/bin/sh -

NAME="gcc"
VERSION="4.8.1"
EXT="tar.bz2"
BUILDDIR="../${NAME}-build"

build() {
    tar -Jxf ${LFS}/sources/gmp-5.1.2.tar.xz
    tar -Jxf ${LFS}/sources/mpfr-3.1.2.tar.xz
    tar -zxf ${LFS}/sources/mpc-1.0.1.tar.gz

    mv gmp-5.1.2 gmp
    mv mpc-1.0.1 mpc
    mv mpfr-3.1.2 mpfr

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

    sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

    mkdir $BUILDDIR
    cd $BUILDDIR

    ../${SOURCES}/configure					\
	--target=$LFS_TGT					\
	--prefix=/tools						\
	--with-sysroot=$LFS					\
	--with-newlib						\
	--without-headers					\
	--with-local-prefix=/tools				\
	--with-native-system-header-dir=/tools/include		\
	--disable-nls						\
	--disable-shared					\
	--disable-multilib					\
	--disable-decimal-float					\
	--disable-threads					\
	--disable-libatomic					\
	--disable-libgomp					\
	--disable-libitm					\
	--disable-libmudflap					\
	--disable-libquadmath					\
	--disable-libsanitizer					\
	--disable-libssp					\
	--disable-libstdc++-v3					\
	--enable-languages=c,c++				\
	--with-mpfr-include=$(pwd)/../gcc-4.8.1/mpfr/src	\
	--with-mpfr-lib=$(pwd)/mpfr/src/.libs

    make
}

install_() {
    make install

    ln -f -s libgcc.a `${LFS_TGT}-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`
}
