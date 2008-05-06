# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs python eutils

MY_PV="${PV//./_}"
DESCRIPTION="Computational Crystallography Toolbox"
HOMEPAGE="http://cctbx.sourceforge.net/"
#SRC_URI="mirror://gentoo/cctbx_bundle-${PV}.tar.gz"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/${CATEGORY}/${PN}/${P}.tar.gz"
LICENSE="cctbx-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="dev-util/scons"
RESTRICT="mirror"

S="${WORKDIR}"
MY_S="${WORKDIR}"/cctbx_sources

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-config.py.patch
}

src_compile() {
	python_version
	# Get CXXFLAGS in format suitable for substitition into SConscript
	for i in ${CXXFLAGS}; do
		OPTS="${OPTS} \"${i}\","
	done

	# Strip off the last comma
	OPTS=${OPTS%,}

	# Fix CXXFLAGS
	sed -i \
		-e "s:\"-O3\", \"-ffast-math\":${OPTS}:g" \
		${MY_S}/libtbx/SConscript

	# Get compiler in the right way
	COMPILER=$(expr match "$(tc-getCC)" '.*\([a-z]cc\)')

	${python} "${MY_S}/libtbx/libtbx/command_line/py_compile_all.py"

	mkdir "${S}"/cctbx_build
	cd "${S}"/cctbx_build
	${python} "${MY_S}"/libtbx/configure.py \
		--compiler=$COMPILER \
		--current_working_directory="${S}"/cctbx_build \
		--build=release \
		mmtbx \
		|| die "configure failed"
	source setpaths_all.sh
	libtbx.scons ${MAKEOPTS} .|| die "make failed"
}

src_test(){
	libtbx.python $(libtbx.show_dist_paths boost_adaptbx)/tst_rational.py \
	|| die "test failed"
}

src_install() {
	insinto /usr/lib/cctbx
	doins -r lib setpath*
	insinto /usr/include
	doins -r include/*
	exeinto /usr/lib/cctbx/bin
	doexe bin/*
	
	sed "s:${D}:/usr/lib/cctbx:g" -i setpaths.sh
	sed "s:${D}:/usr/lib/cctbx:g" -i setpaths.csh
	
	insinto /etc/profile.d/
	newins setpaths.sh 30setpaths.sh
	newins setpaths.csh 30setpaths.csh
}
