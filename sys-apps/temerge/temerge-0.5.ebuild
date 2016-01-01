# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils linux-info

DESCRIPTION="emerge on tmpfs"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="https://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

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
