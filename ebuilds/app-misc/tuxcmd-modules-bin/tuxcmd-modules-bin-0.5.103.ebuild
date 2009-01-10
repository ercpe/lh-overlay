# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# inspired by peazip-1.8.2.ebuild - http://bugs.gentoo.org/show_bug.cgi?id=178716

inherit eutils

DESCRIPTION="Tux Commander - Fast and Small filemanager - VFS modules"
HOMEPAGE="http://tuxcmd.sourceforge.net/"
SRC_URI="mirror://sourceforge/tuxcmd/tuxcmd-modules-${PV}-bin.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*" # binary distribution, won't work on other arches (possible amd64 but not tested yet)
RESTRICT="strip mirror"
IUSE=""
DEPEND=""
RDEPEND=">=app-misc/tuxcmd-bin-0.5.103
		 >=dev-libs/glib-2.4"

S="${WORKDIR}/${P}"

src_compile() {
	einfo "This is a binary package, no compilation needed"
}

src_install() {
	cd "${WORKDIR}"/tuxcmd-modules-${PV}-bin

	dodir /opt/tuxcmd/plugins

	insinto /opt/tuxcmd/plugins
	doins -r ./* || die "install failed"
}
