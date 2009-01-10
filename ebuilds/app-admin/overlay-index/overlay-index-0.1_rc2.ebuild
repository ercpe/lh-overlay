# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
DESCRIPTION="Automatic Ebuild Index Script"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-admin/overlay-index/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net"
IUSE=""
RESTRICT="primaryuri"

src_install(){
	exeinto /usr/lib/overlay-index
	doexe mkindex.sh
	dosym /usr/lib/overlay-index/mkindex.sh /usr/bin/mkindex
}
