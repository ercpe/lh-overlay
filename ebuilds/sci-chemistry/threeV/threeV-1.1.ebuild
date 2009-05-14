# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base toolchain-funcs

MY_PV="${PV//./_}"

DESCRIPTION="Using the Richards' Rolling Probe Method, You Can Derive Volume Information from Any PDB file"
HOMEPAGE="http://geometry.molmovdb.org/3v/"
SRC_URI="http://geometry.molmovdb.org/3v/3v-${MY_PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
PDEPEND="sci-chemistry/msms-bin
	 sci-chemistry/usf-rave"

S="${WORKDIR}/3v-${PV}"

PATCHES=( "${FILESDIR}"/{gcc-4.3,${PV}-Makefile}.patch )

src_compile() {

	cd "${S}"/src

	emake \
		CC="$(tc-getCXX)" \
		FLAGS="${CXXFLAGS}" || \
		die "failed makeing ${PN}"

}

src_install() {
	dobin bin/* || die
	dodoc AUTHORS ChangeLog NEWS QUICKSTART README TODO VERSION || die
}
