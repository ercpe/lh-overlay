# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-info

DESCRIPTION="temerge script for emerge with tmpfs"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/sys-apps/temerge/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
RDEPEND=""
DEPEND=""

CONFIG_CHECK="~TMPFS"

src_install() {
	insinto /etc
	doins temerge.conf
	doexe temerge
}
