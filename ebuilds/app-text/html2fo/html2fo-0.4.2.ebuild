# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="html2fo is a converter from html to xsl:fo which is in combination with xml a very flexible document description format."
HOMEPAGE="http://html2fo.sourceforge.net/"
SRC_URI="mirror://sourceforge/html2fo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	exeinto /usr/bin/
	doexe html2fo
}
