# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="html to xsl:fo converter"
HOMEPAGE="http://html2fo.sourceforge.net/"
SRC_URI="mirror://sourceforge/html2fo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_install() {
	dobin html2fo
}
