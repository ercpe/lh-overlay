# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs multilib

MY_P="${PN}-v${PV}-prod-src"
DESCRIPTION="Tools for extracting mmCIF data from structure determination applications"
HOMEPAGE="http://sw-tools.pdb.org/apps/PDB_EXTRACT/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/PDB_EXTRACT/${MY_P}.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	>=sci-libs/cifparse-obj-7.025"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	local libdir=$(get_libdir)
	unpack ${A}
	epatch "${FILESDIR}"/respect-cflags-and-fix-install.patch
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
	epatch "${FILESDIR}"/${P}-Makefile.patch

	sed -i "s:GENTOOLIBDIR:${libdir}:g" \
		pdb-extract-v3.0/Makefile || die "fix libdir"

	# Get rid of unneeded directories, to make sure we use system files
	ebegin "Deleting redundant directories"
	rm -rf cif-file-v1.0 cifobj-common-v4.1 cifparse-obj-v7.0 \
		misclib-v2.2 regex-v2.2 tables-v8.0
	eend

	sed -i \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-e "s:^\(CC=\).*:\1$(tc-getCC):g" \
		-e "s:^\(GINCLUDES=\).*:\1-I/usr/include/cifparse-obj:g" \
		-e "s:^\(LIBDIR=\).*:\1/usr/$(get_libdir):g" \
		"${S}"/etc/make.*
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin bin/* || die
	dolib.a lib/pdb-extract.a || die
	insinto /usr/include/rcsb
	doins include/* || die
	dodoc README-source README
	insinto /usr/lib/rcsb/pdb-extract-data
	doins pdb-extract-data/* || die
}
