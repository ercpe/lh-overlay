# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="GEclipse is a ebuild-editor for Eclipse"
SRC_URI="mirror://sourceforge/geclipse/net.sf.geclipse_1.0.0_rc1.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/geclipse/"
RESTRICT="primaryuri mirror"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-util/eclipse-sdk"
DEPEND="${RDEPEND}"

src_install(){
	insinto /usr/lib/eclipse-3.2/plugins/
	doins net.sf*
	insinto /usr/share/doc/${P}
	doins doc/userguide.pdf
}
