# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${PN}${PV}"
SLOT="0"
LICENSE="cns"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="ARIA is a software for automated NOE assignment and NMR structure calculation."
SRC_URI="http://aria.pasteur.fr/archives/${MY_P}.tar.gz"
HOMEPAGE="http://aria.pasteur.fr/"
IUSE=""
RESTRICT="fetch"
DEPEND="sci-chemistry/cns
		dev-lang/python
		|| ( dev-python/numeric dev-python/numpy )
		>=dev-python/scientificpython-2.7.3
		>=dev-lang/tk-8.3
		>=dev-tcltk/tix-8.1.4
		>=sci-chemistry/ccpnmr-1.0.15-r1
		dev-python/matplotlib"
RDEPEND="${DEPEND}"


S="${WORKDIR}/${MY_P}"
pkg_nofetch(){
	einfo "Go to ${HOMEPAGE}, download ${A}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack(){
	unpack "${A}"
	epatch "${FILESDIR}"/sa_ls_cool2.patch
}