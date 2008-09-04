# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic libtool gnuconfig versionator

transform_known_flags() {
	declare setting

	# and on x86, we just need to filter the 3.4 specific amd64 -marchs
	replace-cpu-flags k8 athlon64 opteron x86-64

	# gcc 3.3 doesn't support -march=pentium-m
	replace-cpu-flags pentium-m pentium3m pentium3

	#GCC 3.3 does not understand G3, G4, G5 on ppc
	replace-cpu-flags G3 750
	replace-cpu-flags G4 7400
	replace-cpu-flags G5 7400
}

is_arch_allowed() {
	i386_processor_table="i386 i486 i586 pentium pentium-mmx winchip-c6 \
		winchip2 c3 i686 pentiumpro pentium2 pentium3 pentium4 prescott \
		nocona k6 k6-2 k6-3 athlon athlon-tbird x86-64 athlon-4 athlon-xp \
		athlon-mp"

	for proc in ${i386_processor_table} ; do
		[ "${proc}" == "${1}" ] && return 0
	done

	mips_processor_table="mips1 mips2 mips3 mips4 mips32 mips64 r3000 r2000 \
		r3900 r6000 r4000 vr4100 vr4111 vr4120 vr4300 r4400 r4600 orion \
		r4650 r8000 vr5000 vr5400 vr5500 4kc 4kp 5kc 20kc sr71000 sb1"

	for proc in ${mips_processor_table} ; do
		[ "${proc}" == "${1}" ] && return 0
	done

	rs6000_processor_table="common power power2 power3 power4 powerpc \
		powerpc64 rios rios1 rsc rsc1 rios2 rs64a 401 403 405 505 601 602 \
		603 603e ec603e 604 604e 620 630 740 750 7400 7450 8540 801 821 823 \
		860"

	for proc in ${rs6000_processor_table} ; do
		[ "${proc}" == "${1}" ] && return 0
	done

	return 1
}

do_filter_flags() {
	declare setting

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	# gcc 3.3 doesn't support -mtune on numerous archs, so xgcc will fail
	setting="`get-flag mtune`"
	[ ! -z "${setting}" ] && filter-flags -mtune="${setting}"

	# in gcc 3.3 there is a bug on ppc64 where if -mcpu is used
	# the compiler incorrectly assumes the code you are about to build
	# is 32 bit
	use ppc64 && setting="`get-flag mcpu`"
	[ ! -z "${setting}" ] && filter-flags -mcpu="${setting}"

	# only allow the flags that we -know- are supported
	# transform_known_flags
	setting="`get-flag march`"
	if [ ! -z "${setting}" ] ; then
		is_arch_allowed "${setting}" || filter-flags -march="${setting}"
	fi
	setting="`get-flag mcpu`"
	if [ ! -z "${setting}" ] ; then
		is_arch_allowed "${setting}" || filter-flags -mcpu="${setting}"
	fi

	# xgcc wont understand gcc 3.4 flags...
	filter-flags -fno-unit-at-a-time
	filter-flags -funit-at-a-time
	filter-flags -fweb
	filter-flags -fno-web
	filter-flags -mno-tls-direct-seg-refs

	# xgcc isnt patched with propolice
	filter-flags -fstack-protector-all
	filter-flags -fno-stack-protector-all
	filter-flags -fstack-protector
	filter-flags -fno-stack-protector

	# xgcc isnt patched with the gcc symbol visibility patch
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	# ...sure, why not?
	strip-unsupported-flags

	strip-flags
}

S="${WORKDIR}"/gcc-${PV}

# Theoretical cross compiler support
# [ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
#MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
#MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"
MY_PV="$(get_version_component_range 1-2)"
MY_PV_FULL="$(get_version_component_range 1-3)"

LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-${PV}.tar.bz2"

DESCRIPTION="Compatibility package for running binaries linked against a pre gcc 3.4 libstdc++"
HOMEPAGE="http://gcc.gnu.org/libstdc++/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="5"
KEYWORDS="amd64 ~mips ppc -ppc64 sparc x86 ~x86-fbsd"
IUSE="multilib nls nptl build"

# 3.2.3 -> 3.3.x install .so.5, so lets slot to 5
#if [ "${CHOST}" == "${CCHOST}" ]
#then
#	SLOT="5"
#else
#	SLOT="${CCHOST}-5"
#fi

DEPEND="virtual/libc
	!nptl? ( elibc_glibc? ( >=sys-libs/glibc-2.3.2-r3 ) )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	>=sys-devel/gcc-3.3.3_pre20040130
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/libc
	!nptl? ( elibc_glibc? ( >=sys-libs/glibc-2.3.2-r3 ) )
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="|| ( sys-devel/gcc-config app-admin/eselect-compiler )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	if (has_multilib_profile || use multilib) ; then
		sed -i \
			-e 's:\(MULTILIB_OSDIRNAMES = \).*:\1../lib64 ../lib32:' \
			"${S}"/gcc/config/i386/t-linux64 \
			|| die "sed failed!"
	fi

	# Misdesign in libstdc++ (Redhat)
	cp -pPR "${S}"/libstdc++-v3/config/cpu/i{4,3}86/atomicity.h

	cd "${S}"; ./contrib/gcc_update --touch &> /dev/null
	gnuconfig_update
}

src_compile() {

	local myconf=

	if ! use nls || use build
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	(has_multilib_profile || use multilib) || myconf="${myconf} --disable-multilib"

	do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""

	# Build in a separate build tree
	mkdir -p "${WORKDIR}"/build
	cd "${WORKDIR}"/build

	einfo "Configuring libstdc++..."
	addwrite "/dev/zero"
	"${S}"/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--includedir=${LIBPATH}/include \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
		--with-system-zlib \
		--enable-languages=c++ \
		--enable-threads=posix \
		--enable-long-long \
		--disable-checking \
		--enable-cstdio=stdio \
		--enable-__cxa_atexit \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	touch "${S}"/gcc/c-gperf.h

	einfo "Compiling libstdc++..."
	S="${WORKDIR}/build" \
	emake all-target-libstdc++-v3 \
		LIBPATH="${LIBPATH}" \
		BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
}

src_install() {
	local x=

	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in "${WORKDIR}"/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
			continue
		fi
	done
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in `find "${WORKDIR}"/build/gcc/include/ -name '*.h'`
	do
		if grep -q 'It has been auto-edited by fixincludes from' ${x}
		then
			rm -f ${x}
		fi
	done

	einfo "Installing libstdc++..."
	# Do the 'make install' from the build directory
	cd "${WORKDIR}"/build
	S="${WORKDIR}/build" \
	make prefix=${LOC} \
		bindir=${BINPATH} \
		includedir=${LIBPATH}/include \
		datadir=${DATAPATH} \
		mandir=${DATAPATH}/man \
		infodir=${DATAPATH}/info \
		DESTDIR="${D}" \
		LIBPATH="${LIBPATH}" \
		install-target-libstdc++-v3 || die

	# we'll move this into a directory we can put at the end of ld.so.conf
	# other than the normal versioned directory, so that it doesnt conflict
	# with gcc 3.3.3
	mkdir -p "${D}"/${LOC}/lib/libstdc++-v3/
	mv "${D}"/${LIBPATH}/lib* "${D}"/${LOC}/lib/libstdc++-v3/
	# we dont want the headers...
	rm -rf "${D}"/${LOC}/lib/gcc*
	# or locales...
	rm -rf "${D}"/${LOC}/share
	# or anything other than the .so files, really.
	find "${D}" | grep -e c++.la$ -e c++.a$ | xargs rm -f
	# we dont even want the un-versioned .so symlink, as it confuses some
	# apps and also causes others to link against the old libstdc++...
	rm "${D}"/${LOC}/lib/libstdc++-v3/libstdc++.so

	# and it's much easier to just move around the result than it is to
	# configure libstdc++-v3 to use CONF_LIDIR
	if [ "$(get_libdir)" != "lib" ] ; then
		mv "${D}"/${LOC}/lib "${D}"/${LOC}/$(get_libdir)
	fi

	mkdir -p "${D}"/etc/env.d/
	echo "LDPATH=\"${LOC}/$(get_libdir)/libstdc++-v3/\"" >> "${D}"/etc/env.d/99libstdc++
}
