# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
DESCRIPTION="Automatic Ebuild Index Script"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-admin/rsync-homedir/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net/wiki/wiki/Private_Portage_Overlay"
IUSE=""
RESTRICT="primaryuri"
src_install(){
	exeinto /usr/lib/rsync-homedir
	doexe rsync-homedir.sh
	dosym /usr/lib/rsync-homedir/rsync-homedir.sh /usr/bin/rsync-homedir
}