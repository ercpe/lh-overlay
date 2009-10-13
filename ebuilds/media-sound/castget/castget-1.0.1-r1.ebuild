# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit base

DESCRIPTION="A simple, command-line based RSS enclosure downloader, primarily intended for automatic, unattended downloading of podcasts."
HOMEPAGE="http://www.nongnu.org/castget/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2
	dev-libs/libxml2
	media-libs/id3lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}"/${P}
