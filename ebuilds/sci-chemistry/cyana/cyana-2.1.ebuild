# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs fortran flag-o-matic

DESCRIPTION="Combined assignment and dynamics algorithm for NMR applications"
HOMEPAGE="http://www.las.jp/english/products/s08_cyana/index.html"
SRC_URI="cyana-2.1.tar.gz"

SLOT="0"
LICENSE="CYANA2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"

## we need dev-libs/libg2c for gfortran
#FORTRAN="gfortran ifc"
FORTRAN="ifc"

src_compile() {
	touch etc/config


	case ${FORTRANC} in
		ifort)
			SYSTEM="intel"
#			append-fflags -fno-second-underscore
			FORK="g77fork.o"
			DEFS="-Dintel";;
	esac


	emake \
		SYSTEM="${SYSTEM}" \
		COMMENT="Gentoo build" \
		FC="${FORTRANC}" \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		LDFALGS="${LDFLAGS}" \
		FFLAGS="${FFLAGS}" \
		FORK="${FORK}" \
		DEFS="${DEFS}" \
		LIBS="-L/opt/intel/fce/10.1.018/lib/ -liomp5 -pthread -lguide.so"|| \
	die "damn"

}

src_install() {

	emake \
		SYSTEM="${SYSTEM}" \
		COMMENT="Gentoo build" \
		FC="${FORTRANC}" \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		LDFALGS="${LDFLAGS}" \
		FFLAGS="${FFLAGS}" \
		FORK="${FORK}" \
		DEFS="${DEFS}" \
		BINDIR="${D}/usr/bin/" \
		LIBDIR="${D}/usr/$(get_libdir)/" \
		install-files
die

	dobin cyana* || die "failed to install ${PN}"

	insinto /usr/lib/${PN}
	doins -r macro lib help || die
	find "${D}"/usr/$(get_libdir)/${PN} -name Makefile -exec rm '{}' \;

	exeinto /usr/$(get_libdir)/${PN}/etc/
	doexe  etc/identify || die

	exeinto /usr/$(get_libdir)/${PN}
#	doexe src/cyana/{cyana,cyanaexe.gnu} || die
	doexe src/cyana/cyanaexe.intel || die

	insinto /usr/share/${PN}
	doins -r demo || die
}
