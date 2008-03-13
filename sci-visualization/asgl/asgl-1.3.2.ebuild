# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit fortran eutils

FORTRAN="g77 gfortran"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="ASGL is a program for preparing all sorts of PostScript plots from simple data files."
SRC_URI="ftp://salilab.org/asgl/asgl-1.3.2.tar.gz"
HOMEPAGE="http://salilab.org/asgl/"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	epatch "${FILESDIR}/exec_bits.patch"
	cd ${P}
}

src_compile(){
	export ASGL_EXECUTABLE_TYPE=$FORTRANC
	export ASGLINSTALL="${D}/usr/lib/libasgl"
	emake -j1 opt
#	emake -j1 man
}

src_install(){
	emake -j1 install
	dosym /usr/lib/libasgl/asgl /usr/bin/
	dosym /usr/lib/libasgl/asgl_gfortran /usr/bin/
	dosym /usr/lib/libasgl/setasgl /usr/bin/
#	emake -j1 installman

	insinto /usr/share/${PN}/examples/
	doins -r examples/{*dat,*top}
	dodoc {README,ChangeLog}
}
