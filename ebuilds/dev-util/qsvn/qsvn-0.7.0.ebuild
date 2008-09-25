# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit cmake-utils

DESCRIPTION="GUI frontend to the Subversion revision system"
HOMEPAGE="http://ar.oszine.de/projects/qsvn/"
SRC_URI="http://ar.oszine.de/projects/qsvn/chrome/site/${P}-src.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

RDEPEND="x11-libs/qt:4
	dev-util/subversion"
DEPEND="${DEPEND}
	>=dev-util/cmake-2.4.0"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	cmake-utils_src_install
}
