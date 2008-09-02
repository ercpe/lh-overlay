# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Init script which sets up the ethernet devices for wakeonlan"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-admin/wol-init/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net"
IUSE=""

RESTRICT="mirror"

RDEPEND="sys-apps/ethtool"

src_install(){
	newinitd wakeonlan.init wakeonlan
	newconfd wakeonlan.conf wakeonlan
}
