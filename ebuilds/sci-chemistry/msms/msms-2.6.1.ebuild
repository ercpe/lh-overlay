# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit toolchain-funcs flag-o-matic eutils

DL_URI="http://mgltools.scripps.edu/downloads/tars/releases/MSMSRELEASE/"

DESCRIPTION="msms is a wrapped version of the msms lib"
SRC_URI="x86? ( ${DL_URI}REL${PV}/msms_i86Linux2_${PV}.tar.gz )
	 amd64? ( ${DL_URI}REL${PV}/msms_i86_64Linux2_${PV}.tar.gz )
	 http://gentoo.j-schmitz.net/private-overlay/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
HOMEPAGE="http://mgltools.scripps.edu"

LICENSE="mgltools"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/atmtypenumbers-path.patch
	epatch "${FILESDIR}"/makefile.patch
}

src_compile() {
	append-flags -DTIMING -DVERBOSE
	use x86 && cd ${PN}/i86Linux2
	emake CC="$(tc-getCC)" \
	      CFLAGS="${CFLAGS}" \
	      LDFLAGS="${LDFLAGS}" \
	msms || die
}

src_install() {
	use x86 && newbin ${PN}/i86Linux2/msms..2.6.1 msms || die "failed installing msms"
	dobin pdb_to_xyzr{,n} || die "failed installing pdb_to_xyzr{,n}"
	insinto /usr/share/${PN}
	doins atmtypenumbers || die "failed installing atmtypenumbers"
	dodoc README ReleaseNotes
	doman msms.1
	dohtml msms.html
}
