# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT="0"
LICENSE="MestRec"
KEYWORDS="~x86"
DESCRIPTION="MestRe Nova: NMR processing, analysis and simulation at your fingertips"
SRC_URI="mestrenova_5.2.1-3586_i386.lenny.deb"
HOMEPAGE="http://www.mestrec.com/index.php"
IUSE=""
RESTRICT="fetch"

pkg_nofetch(){
	ewarn "go to ${HOMEPAGE}"
	ewarn "and download ${A} to ${DISTDIR}"
	die
}

src_unpack(){
	unpack ${A}
	unpack ./data.tar.gz
}

src_install(){
	insinto /
	doins -r usr
	fperms 775 /usr/local/bin/MestReNova
	fperms 775 /usr/local/share/MestReNova/lib/{MestReNova,*so}
}
