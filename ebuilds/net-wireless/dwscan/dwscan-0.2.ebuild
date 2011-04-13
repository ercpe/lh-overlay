# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python

DESCRIPTION="Access point information in a useful manner"
HOMEPAGE="http://dag.wieers.com/home-made/dwscan/"
SRC_URI="http://dag.wieers.com/home-made/dwscan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=net-wireless/python-wifi-0.3"

src_configure() {
:
}

src_install() {
	python_src_install
	dodoc AUTHORS ChangeLog README TODO WISHLIST || die
}
