# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="The protein secondary structure standard"
HOMEPAGE="http://swift.cmbi.ru.nl/gv/dssp/"
# ftp://ftp.cmbi.ru.nl/pub/molbio/software/dsspcmbi.tar.gz
SRC_URI="${P}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"
DEPEND=""
RDEPEND="${DEPEND}"
S=${WORKDIR}/${PN}

pkg_nofetch() {
	elog "Download ftp://ftp.cmbi.ru.nl/pub/molbio/software/dsspcmbi.tar.gz --"
	elog "Rename it to ${SRC_URI} and place it in ${DISTDIR}"
}

src_compile() {
	$(tc-getCC) -lm ${CFLAGS} ${LDFLAGS} -o dsspcmbi \
		AccSurf.c Contacts.c p2clib.c CalcAccSurf.c Date.c DsspCMBI.c Vector.c \
		|| die
}

src_install() {
	dobin dsspcmbi || die
	dodoc README.TXT || die
	dohtml index.html || die
}

pkg_postinst() {
	elog "Go to ${HOMEPAGE} and return the license agreement."
	elog "One of its requirements is citing the article:"
	elog "Kabsch, W. & Sander, C. Biopolymers 22:2577-2637 (1983)."
}
