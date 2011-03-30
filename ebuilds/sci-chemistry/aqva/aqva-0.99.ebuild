# Copyright 1999-2011 Gentoo Foundation
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

IUSE="povray"
RDEPEND="
	sci-chemistry/almost
	sci-biology/ncbi-tools
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-webkit:4
	povray? ( media-gfx/povray )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/aqvahome

src_prepare() {
	rm -rvf contrib/*
	rm -rvf include/*
	epatch "${FILESDIR}"/Makefile.patch
	epatch "${FILESDIR}"/as-needed.patch
}

src_configure(){
	cd Aqva

	# eqmake4 is broken
	qmake Aqva4.4.pro || die "qmake failed"
}

src_compile(){
	cd Aqva

	emake || die "compile error"
}

src_install() {
	dobin Aqva/Aqva4 || die "no {PN} installed"

	insinto /usr/share/doc/${P}/example
	doins -r 1UZC

	insinto /usr/share/doc/${P}/
	doins -r cheshire toppar || die "failed to install cheshire"

	dohtml -r help || die "no help"
}
