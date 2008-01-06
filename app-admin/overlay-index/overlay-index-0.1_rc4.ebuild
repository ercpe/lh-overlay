# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Automatic Ebuild Index Script"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-admin/overlay-index/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
IUSE=""
RESTRICT="primaryuri"

src_install(){
	exeinto /usr/lib/overlay-index
	doexe overlay-index.sh
	
	insinto /etc/
	doins overlay-index.conf

	dosym /usr/lib/overlay-index/overlay-index.sh /usr/bin/overlay-index
}