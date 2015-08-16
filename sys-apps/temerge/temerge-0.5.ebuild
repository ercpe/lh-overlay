# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils linux-info

DESCRIPTION="emerge on tmpfs"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/sys-apps/temerge/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="~TMPFS"

src_install() {
	insinto /etc
	doins temerge.conf
	dobin temerge
}
