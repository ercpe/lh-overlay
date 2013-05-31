# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils toolchain-funcs

MY_P="Tisean_3.0.1"

DESCRIPTION="Analysis of time series with methods based on the theory of nonliner deterministic dynamical systems"
HOMEPAGE="http://www.mpipks-dresden.mpg.de/%7Etisean/Tisean_3.0.1/index.html"
SRC_URI="http://www.mpipks-dresden.mpg.de/~tisean/TISEAN_3.0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnuplot"

RDEPEND="gnuplot? ( sci-visualization/gnuplot )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	tc-export FC CC
	epatch "${FILESDIR}"/${PV}-gentoo.patch
}

src_configure() {
	econf \
		--prefix="${D}/usr"
}

src_install() {
	dodir /usr/bin
	emake install || die "install failed"
}
