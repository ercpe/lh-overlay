# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb-extract/pdb-extract-1.700.ebuild,v 1.6 2008/07/02 01:39:27 dberkholz Exp $

inherit eutils toolchain-funcs multilib

MY_P="${PN}-v${PV}-prod-src"
DESCRIPTION="Tools for extracting mmCIF data from structure determination applications"
HOMEPAGE="http://sw-tools.pdb.org/apps/PDB_EXTRACT/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/PDB_EXTRACT/${MY_P}.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	sci-libs/cifparse-obj"
PDEPEND="sci-libs/rcsb-data"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/respect-cflags-and-fix-install.patch
	cd "${S}"

	# Get rid of unneeded directories, to make sure we use system files
	ebegin "Deleting redundant directories"
	rm -rf btree-obj* ciflib-common* cifobj-common* cif-table-obj* maxit* \
		misclib* regex* validation*
	eend

	sed -i \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-e "s:^\(GINCLUDE=\).*:\1-I/usr/include/rcsb:g" \
		-e "s:^\(LIBDIR=\).*:\1/usr/$(get_libdir):g" \
		"${S}"/etc/make.*
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	exeinto /usr/bin
	doexe bin/* || die
	dolib.a lib/* || die
	insinto /usr/include/rcsb
	doins include/* || die
	dodoc README-source README
	insinto /usr/lib/rcsb/pdb-extract-data
	doins pdb-extract-data/* || die
}
