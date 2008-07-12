# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

DESCRIPTION="GEclipse is a ebuild-editor for Eclipse"
SRC_URI="mirror://sourceforge/geclipse/net.sf.geclipse_1.0.0_rc1.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/geclipse/"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-util/eclipse-sdk"
DEPEND="${RDEPEND}"

pkg_setup(){
	 ECLIPSE_SLOT=$(get_version_components $(best_version dev-util/eclipse-sdk)|\
	 awk '{print $7}')
}

src_install(){
	insinto /usr/lib/eclipse-3.${ECLIPSE_SLOT}/plugins/
	doins net.sf*
	insinto /usr/share/doc/${P}
	doins doc/userguide.pdf
}
