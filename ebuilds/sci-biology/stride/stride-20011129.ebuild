# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/stride/stride-20011129.ebuild,v 1.6 2007/09/20 14:35:18 coldwind Exp $

inherit eutils toolchain-funcs private

DESCRIPTION="A program for protein secondary structure assignment from atomic coordinates."
LICENSE="as-is"
HOMEPAGE="http://www.embl-heidelberg.de/argos/stride/stride_info.html"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/${PN}/src/${PN}.tar.gz
		 mirror://gentoo/${PN}-20060723-update.patch.bz2
		 ${PKG_SERVER}stride2pdb-0.01.tar.bz2
		 ${PKG_SERVER}stridepdb-0.0.1.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""
RDEPEND="dev-lang/perl"
RESTRICT="primaryuri"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# this patch updates the source to the most recent
	# version which was kindly provided by the author
	epatch "${DISTDIR}/${PN}-20060723-update.patch.bz2"

	# fix makefile
	sed -e "/^CC/s:gcc -g:$(tc-getCC) ${CFLAGS}:" -i Makefile || \
		die "Failed to fix Makefile"
}

src_install() {
	dobin ${PN} stride2pdb stridepdb || die "Failed to install stride binary"
}
