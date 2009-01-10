# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN=ScientificPython
DV=1835 # hardcoded download version

inherit eutils distutils

DESCRIPTION="Scientific Module for Python"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${DV}/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://dirac.cnrs-orleans.fr/ScientificPython/"
SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
RESTRICT="mirror"
IUSE="mpi doc"

DEPEND=">=dev-python/numeric-23.8
	>=sci-libs/netcdf-3.0
	mpi? ( virtual/mpi )"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use mpi; then
		epatch "${FILESDIR}"/${PN}-mpi.patch
	fi
}

src_compile() {
	distutils_src_compile
	if use mpi; then
		cd Src/MPI
		"${python}" compile.py || die "compile mpi failed"
	fi
}

src_test() {
	cd "${S}"/build/lib*
	for t in "${S}"/Tests/*tests.py; do
		PYTHONPATH=. "${python}" ${t} || die "test $(basename ${t}) failed"
	done
}

src_install() {
	distutils_src_install
	# do not install bsp related stuff, since we don't compile the interface
	dodoc README README.MPI Doc/CHANGELOG || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins Examples/{demomodule.c,netcdf_demo.py} || die "doins examples failed"
	if use mpi; then
		dobin Src/MPI/mpipython || die "dobin failed"
		doins Examples/mpi.py || die "doins mpi example failed failed"
	fi
	if use doc; then
		dohtml Doc/Reference/* || die "dohtml failed"
	fi
}
