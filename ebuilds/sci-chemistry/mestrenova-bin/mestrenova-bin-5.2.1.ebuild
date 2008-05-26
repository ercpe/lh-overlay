# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm

SLOT="0"
LICENSE="MestRec"
KEYWORDS="~x86"
DESCRIPTION="MestRe Nova: NMR processing, analysis and simulation at your fingertips"
SRC_URI="MestReNova-${PV}-3586.i386.fc6.rpm"
HOMEPAGE="http://www.mestrec.com/index.php"
IUSE=""
RESTRICT="fetch"

pkg_nofetch(){
	ewarn "go to ${HOMEPAGE}"
	ewarn "and download ${A} to ${DISTDIR}"
	die
}

src_install(){
	insinto /
	doins -r usr
	fperms 775 /usr/local/bin/MestReNova
	fperms 775 /usr/local/share/MestReNova/lib/{MestReNova,*so}
}