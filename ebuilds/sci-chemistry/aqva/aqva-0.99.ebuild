# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4 eutils

DESCRIPTION="Aqva is a molecular graphics program designed for the interactive visualization and analysis of Biomolecules"
HOMEPAGE="http://www-almost.ch.cam.ac.uk/site/aqva.html"
SRC_URI="http://www-almost.ch.cam.ac.uk/site/downloads/aqva.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="virtual/glut
	 sci-chemistry/almost
	 sci-biology/ncbi-tools
	 =x11-libs/qt-4.4*"
#	x11-libs/qt-webkit
# blast db

DEPEND="${RDEPEND}"

S="${WORKDIR}"/aqvahome

src_unpack(){
	unpack ${A}

	cd "${S}"
rm -rvf contrib/*
rm -rvf include/*
	epatch "${FILESDIR}"/Makefile.patch
#	epatch "${FILESDIR}"/as-needed.patch
}

src_compile(){

	cd Aqva

	LIBS="/mnt/tmpfs/aqvahome/contrib/almost-1.0.3/" eqmake4 Aqva4.4.pro

	emake -j4 || \
	die
}
#
#src_test() {
#	emake check
#}
#

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	dodoc README NEWS ChangeLog AUTHORS

	insinto /usr/share/doc/${P}/exmaple
	doins -r 1UZC
}
