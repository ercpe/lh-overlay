# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Community Icons for gajim"
HOMEPAGE="http://trac.gajim.org/wiki/GajimCommunityArt"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="net-im/gajim"
RESTRICT="mirror"

src_install(){
	insinto /usr/share/gajim/data/iconsets
	doins -r *
}