# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Crystallographic molecular replacement by evolutionary search"
HOMEPAGE="http://www.epmr.info/"
SRC_URI="http://homepage.mac.com/WebObjects/FileSharing.woa/wa/${P}-src.tar.gz.03-src.tar.gz?a=downloadFile&user=crkissinger&path=/Public/EPMR%20Distribution/Version%20${PV}/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="openmp"
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-gcc-4.3.patch

	use openmp && $(append-flags fopenmp)
}

src_compile() {
	einfo "Building ${PN} ..."
	$(tc-getCXX) \
		${CFLAGS} \
		${LDFLAGS} \
		-o ${PN} \
		*.cpp \
		|| die "failed to compile ${PN}"
}
src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc CHANGES || die "dodoc failed"
}

pkg_postinst() {
	elog "The user manual is available at ${HOMEPAGE}"
}
