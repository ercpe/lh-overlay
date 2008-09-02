# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="JNMR (Pure Java NMR) is an NMR pulse sequence simulation tool"
HOMEPAGE="http://www.nanuc.ca/downloads/pjnmr.php"
SRC_URI="${PN}_v${PV}.tar"
LICENSE="pjnmr"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

pkg_nofetch() {
	einfo "Please download ${A}"
	einfo "from ${HOMEPAGE}"
	einfo "to ${DISTDIR}"
}

src_install() {
	local PJLIB

	PJLIB="/usr/lib/"${PN}

	insinto ${PJLIB}
	doins -r *jar pics

	dodoc README

	#Make Wrapper

	cat >> "${T}"/pjnmr <<- EOF
	#!/bin/csh
	setenv CLASSPATH .:${PJLIB}/colt.jar:${PJLIB}/extralibs.jar
	java -DLIB_PATH="${PJLIB}/" -jar ${PJLIB}/PJNMR.jar
	EOF

	dobin "${T}"/pynmr
}
