# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils fortran

MY_P="Tisean_3.0.1"
DESCRIPTION="Analysis of time series with methods based on the theory of nonliner deterministic dynamical systems"
HOMEPAGE="http://www.mpipks-dresden.mpg.de/%7Etisean/Tisean_3.0.1/index.html"
SRC_URI="http://www.mpipks-dresden.mpg.de/~tisean/TISEAN_3.0.1.tar.gz"
RESTRICT=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnuplot"
RDEPEND="gnuplot? ( sci-visualization/gnuplot )"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"
RESTRICT="mirror"

#src_unpack() {
#	unpack ${A}
#	epatch "${FILESDIR}/configure.patch"
#}

pkg_setup() {
	FORTRAN="g77 gfortran ifort"
	fortran_pkg_setup
	if  [[ ${FORTRANC} == if* ]]; then
		ewarn "Using Intel Fortran at your own risk"
	fi
}

src_compile() {
	export FC=$FORTRANC
	econf \
	--prefix=${D}"usr"
#		FC="ifort" \
#		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	emake install || die "install failed"
}
