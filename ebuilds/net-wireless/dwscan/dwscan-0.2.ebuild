# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Displays access point information in a useful manner"
HOMEPAGE="http://dag.wieers.com/home-made/dwscan/"
SRC_URI="http://dag.wieers.com/home-made/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="net-wireless/python-wifi"
DEPEND="${RDEPEND}"

src_install() {
	dobin ${PN} || die "Installation of ${PN} failed"
	dodoc WISHLIST TODO README LINKS AUTHORS ChangeLog || die
}
