# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# inspired by peazip-1.8.2.ebuild - http://bugs.gentoo.org/show_bug.cgi?id=178716

inherit eutils

DESCRIPTION="Tux Commander - Fast and Small filemanager using GTK2"
HOMEPAGE="http://tuxcmd.sourceforge.net/"
SRC_URI="mirror://sourceforge/tuxcmd/tuxcmd-dev-${PV}-bin.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*" # binary distribution, won't work on other arches (possible amd64 but not tested yet)
RESTRICT="strip"

DEPEND=""
RDEPEND=">=x11-libs/gtk+-2.4.0
	 >=dev-libs/glib-2.4.0
	 >=x11-libs/pango-1.4.0"

S="${WORKDIR}/${P}"

src_compile() {
        einfo "This is a binary package, no compilation needed"
}

src_install() {
        cd "${WORKDIR}/tuxcmd-dev-${PV}-bin"

        insinto /opt/tuxcmd
        doins -r ./*

	exeinto /opt/tuxcmd
	doexe tuxcmd

	dosym /opt/tuxcmd/tuxcmd /usr/bin/tuxcmd || die "install failed"
}
