# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/validation/validation-6.2.ebuild,v 1.5 2007/03/15 22:01:27 kugelfang Exp $

inherit eutils toolchain-funcs multilib

# pdb-extract includes a newer 'validation' than 'validation' tarball does,
# and the filterlib from pdb-extract is incompatible with the validation tarball
MY_PN="pdb-extract"
MY_PV="1.700"
MY_P="${MY_PN}-v${MY_PV}-prod-src"
DESCRIPTION="Set of tools used by the Protein Data Base (PDB) for processing and checking structure data"
HOMEPAGE="http://sw-tools.pdb.org/apps/VAL/index.html"
#SRC_URI="http://sw-tools.pdb.org/apps/PDB_EXTRACT/${MY_P}.tar.gz"
SRC_URI="http://sw-tools.pdb.org/apps/VAL/validation-v8.061-prod-src.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="sci-libs/rcsb-data"
DEPEND="${RDEPEND}
	sci-chemistry/pdb-extract"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cp ${S}/etc/make.platform.gnu{3,4}

	epatch ${FILESDIR}/platform.sh.patch

	cd ${S}
die
	# Get rid of unneeded directories, to make sure we use system files
	ebegin "Deleting redundant directories"
	rm -rf 	ciflib-common* cifobj-common* cif-table-obj* \
	cifparse_obj* misclib* regex*
	eend

	sed -i \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-e "s:^\(GINCLUDE=\).*:\1-I/usr/include/rcsb:g" \
		-e "s:^\(LIBDIR=\).*:\1/usr/$(get_libdir):g" \
		${S}/etc/make.*
}

src_install() {
	exeinto /usr/bin
	doexe bin/*
	dolib.a lib/*
	insinto /usr/include/rcsb
	doins include/*
	dodoc ${FILESDIR}/README*
}
