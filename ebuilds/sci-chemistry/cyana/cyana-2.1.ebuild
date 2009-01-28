# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs fortran

DESCRIPTION="Combined assignment and dynamics algorithm for NMR applications"
HOMEPAGE="http://www.las.jp/english/products/s08_cyana/index.html"
SRC_URI="cyana-2.1.tar"

LICENSE="CYANA2.1"

SLOT="0"
KEYWORDS="-* ~x86"

IUSE=""
RDEPEND="dev-libs/libg2c"
DEPEND="${RDEPEND}"

#FORTRAN="g77 gfortran ifc"
FORTRAN="ifc"

src_unpack() {
	unpack ${A}

	cd "${S}"

#	epatch "${FILESDIR}/${P}"-exec.patch
#	epatch "${FILESDIR}/${P}"-etime.patch
}

src_compile() {
	touch etc/config

	case ${FORTRANC} in
		ifort)	SYSTEM="intel"
			COMMENT="Intel Fortran compiler"
			FC="ifort"
			FFLAGS="${FFLAGS}"
			FFLAGS2=""
			CC=$(tc-getCC)
			FORK="g77fork.o"
			LDFLAGS="${LDFLAGS}"
			DEFS="-Dintel";;
	esac


	emake -j1 \
		SYSTEM="${SYSTEM}" \
		COMMENT="${COMMENT}" \
		FC="${FC}" \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		FFLAGS="${FFLAGS}" \
		FFLAGS2="" \
		LDFLAGS="${LDFLAGS}" \
		FORK="${FORK}" \
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
#	doexe src/cyana/{cyana,cyanaexe.gnu} || die
	doexe src/cyana/cyanaexe.gnu || die

	insinto /usr/share/${PN}
	doins -r demo || die
}
