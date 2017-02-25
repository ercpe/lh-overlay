# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Init script which sets up the ethernet devices for wakeonlan"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="https://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-apps/ethtool"
DEPEND=""

src_install(){
	newinitd wakeonlan.init wakeonlan
	newconfd wakeonlan.conf wakeonlan
}
