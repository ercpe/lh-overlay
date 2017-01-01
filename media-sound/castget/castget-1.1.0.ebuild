# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Command-line based RSS downloader"
HOMEPAGE="http://www.nongnu.org/castget/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	media-libs/id3lib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/${P}
