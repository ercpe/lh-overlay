# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#inherit eutils

DESCRIPTION="CARA is the application for the analysis of NMR spectra and computer aided resonance assignment"
SRC_URI="http://www.cara.nmr-software.org/downloads/cara_1.8.4_linux.gz
		 ftp://ftp.mol.biol.ethz.ch/software/cara/Start1.2.cara"
HOMEPAGE="www.nmr.ch"
RESTRICT="mirror"
LICENSE="CARA"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""
RDEPEND="x11-libs/libXext
		 x11-libs/libX11
		 media-libs/fontconfig
		 x11-libs/libSM
		 x11-libs/libICE
		 media-libs/freetype
		 x11-libs/libXrender
		 x11-libs/libXrandr
		 x11-libs/libXcursor
		 x11-libs/libXi
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 sys-libs/zlib
		 dev-libs/expat
		 x11-libs/libXfixes"
DEPEND=""

src_unpack(){
	unpack cara_1.8.4_linux.gz
	cp "${DISTDIR}"/Start1.2.cara "${WORKDIR}"
}

src_install() {
	exeinto "/opt/cara"
	doexe cara_1.8.4_linux
	dodoc Start1.2.cara

	cat>>"${T}"/20cara<<-EOF
	PATH="/opt/cara/"
	EOF
	doenvd "${T}"/20cara
}

