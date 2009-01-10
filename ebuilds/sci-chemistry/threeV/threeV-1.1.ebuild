# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

MY_PV="${PV//./_}"

DESCRIPTION="Using the Richards' Rolling Probe Method, You Can Derive Volume Information from Any PDB file"
HOMEPAGE="http://geometry.molmovdb.org/3v/"
SRC_URI="http://geometry.molmovdb.org/3v/3v-${MY_PV}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
PDEPEND="sci-chemistry/msms-bin
	 sci-chemistry/usf-rave-bin"

S="${WORKDIR}/3v-${PV}"


src_unpack() {

	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}/gcc-4.3.patch"
}

src_compile() {

	cd "${S}"/src

	emake CC="$(tc-getCXX)" FLAGS="${CXXFLAGS}" || die "failed makeing ${PN}"

}

src_install() {

	for EXE in bin/*; do
		newbin ${EXE} ${EXE%.*} || die
	done

	dodoc AUTHORS ChangeLog NEWS QUICKSTART README TODO VERSION
}
