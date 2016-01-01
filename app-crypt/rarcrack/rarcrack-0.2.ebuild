# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Bruteforce algorithm to find correct password of zip, rar and 7z archives"
HOMEPAGE="http://rarcrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${P}/%5BUnnamed%20release%5D/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	tc-export CC
}

src_install()  {
	emake PREFIX="${ED}/usr" install
}
