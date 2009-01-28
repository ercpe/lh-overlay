# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="Combined assignment and dynamics algorithm for NMR applications"
HOMEPAGE="http://www.las.jp/english/products/s08_cyana/index.html"
SRC_URI="cyana-1.1-src.tar"

LICENSE="CYANA1.1"

SLOT="0"
KEYWORDS="-* ~x86"

IUSE="mpi"
RDEPEND="dev-libs/libg2c"
DEPEND="${RDEPEND}
	virtual/mpi"

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}/${P}"-exec.patch
}

src_compile() {
	touch etc/config

	DEFS="-Dgnu"
	FC="$(tc-getFC)"

	if use mpi; then
		DEFS="${DEFS} -Dmpi -Dgnu_mpi"
		FC_NOMPI="${FC}"
		FC="mpif77"
	fi

	emake -j1 \
		SYSTEM="gnu" \
		COMMENT="GNU Fortran 77 compiler" \
		FC="${FC}" \
		CC=$(tc-getCC) \
		CFLAGS="-I/usr/include -L/usr/lib ${CFLAGS}" \
		FFLAGS="-I/usr/include -L/usr/lib ${FFLAGS}" \
		FFLAGS2="" \
		LDFLAGS="${LDFLAGS} -lg2c" \
		FORK="g77fork.o" \
		DEFS="${DEFS}" || \
	die "damn"
}

src_install() {
	dobin cyana* || die "failed to install ${PN}"

	insinto /usr/lib/${PN}
	doins -r macro lib help || die
	find "${D}"/usr/lib/${PN} -name Makefile -exec rm '{}' \;

	exeinto /usr/lib/${PN}/etc/
	doexe  etc/identify || die

	exeinto /usr/lib/${PN}
	doexe src/cyana/{cyana,cyanaexe.gnu} || die

	insinto /usr/share/${PN}
	doins -r demo || die
}
