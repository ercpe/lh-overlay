# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Init script which sets up the ethernet devices for wakeonlan"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/app-admin/wol-init/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="mirror"

RDEPEND="sys-apps/ethtool"
DEPEND=""

src_install(){
	newinitd wakeonlan.init wakeonlan || die
	newconfd wakeonlan.conf wakeonlan || die
}
