# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/apbs/apbs-1.0.0-r1.ebuild,v 1.1 2008/10/11 17:29:20 markusle Exp $

inherit eutils fortran autotools

MY_P="${P}-source"
S="${WORKDIR}"/"${MY_P}"

DESCRIPTION=" Software for evaluating the electrostatic properties of nanoscale biomolecular systems"
LICENSE="BSD"
HOMEPAGE="http://apbs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
IUSE="blas mpi python doc"
KEYWORDS="~ppc ~x86 ~amd64"

DEPEND="blas? ( virtual/blas )
		python? ( dev-lang/python )
		sys-libs/readline
		mpi? ( virtual/mpi )"

FORTRAN="g77 gfortran ifc"

pkg_setup() {
	# It is important that you use the same compiler to compile
	# APBS that you used when compiling MPI.
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-openmpi.patch
	epatch "${FILESDIR}"/${P}-install-fix.patch
	epatch "${FILESDIR}"/${P}-libmaloc-noinstall.patch
	epatch "${FILESDIR}"/${P}-LDFLAGS.patch
	sed "s:GENTOO_PKG_NAME:${P}:g" \
	-i Makefile.am || die "Cannot correct package name"
	eautoreconf
}

src_compile() {
	local myconf="--docdir=/usr/share/doc/${PF}"
	use blas && myconf="${myconf} --with-blas=-lblas"

	# check which mpi version is installed and tell configure
	if use mpi; then
		if has_version sys-cluster/mpich; then
	 		myconf="${myconf} --with-mpich=/usr"
		elif has_version sys-cluster/mpich2; then
			myconf="${myconf} --with-mpich2=/usr"
		elif has_version sys-cluster/lam-mpi; then
			myconf="${myconf} --with-lam=/usr"
		elif has_version sys-cluster/openmpi; then
			myconf="${myconf} --with-openmpi=/usr"
		fi
	fi || die "Failed to select proper mpi implementation"

	econf $(use_enable python) \
		${myconf} || die "configure failed"

	emake -j1 || die "make failed"
}

src_test() {
	cd examples && make test \
		|| die "Tests failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS INSTALL README NEWS ChangeLog \
		|| die "Failed to install docs"
}
