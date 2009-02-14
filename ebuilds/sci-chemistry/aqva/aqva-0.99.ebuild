# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4 eutils

DESCRIPTION="Mmolecular graphics program designed for the interactive visualization and analysis of Biomolecules"
HOMEPAGE="http://www-almost.ch.cam.ac.uk/site/aqva.html"
SRC_URI="http://www-almost.ch.cam.ac.uk/site/downloads/aqva.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="virtual/glut
	 sci-chemistry/almost
	 sci-biology/ncbi-tools
	 x11-libs/qt-gui:4
	 x11-libs/qt-opengl:4
	 x11-libs/qt-webkit:4"
#	 x11-libs/qt-network:4
# blast db

DEPEND="${RDEPEND}"

S="${WORKDIR}"/aqvahome

src_prepare() {
rm -rvf contrib/*
rm -rvf include/*
	epatch "${FILESDIR}"/Makefile.patch
	epatch "${FILESDIR}"/as-needed.patch
}

src_compile(){

	cd Aqva

#	LIBS="/mnt/tmpfs/aqvahome/contrib/almost-1.0.3/" eqmake4 Aqva4.4.pro
	eqmake4 Aqva4.4.pro

	emake -j1 || \
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

	insinto /usr/share/doc/${P}/example
	doins -r 1UZC
}
