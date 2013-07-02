# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1

DESCRIPTION="Access point information in a useful manner"
HOMEPAGE="http://dag.wieers.com/home-made/dwscan/"
SRC_URI="http://dag.wieers.com/home-made/dwscan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=net-wireless/python-wifi-0.3"

src_install() {
	python_parallel_foreach_impl python_doscript ${PN}
	dodoc AUTHORS ChangeLog README TODO WISHLIST
}
