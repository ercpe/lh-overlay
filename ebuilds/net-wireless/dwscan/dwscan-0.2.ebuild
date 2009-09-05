# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Dwscan displays access point information in a useful manner."
HOMEPAGE="http://dag.wieers.com/home-made/dwscan/"
SRC_URI="http://dag.wieers.com/home-made/dwscan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$DEPEND"
DEPEND=">=net-wireless/python-wifi-0.3"

RESTRICT_PYTHON_ABIS="3*"

DOCS="docs/AUTHORS docs/BUGS docs/DEVEL.txt docs/TODO"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples || die "no examples"
	fi
}
