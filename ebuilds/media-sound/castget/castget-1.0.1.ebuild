# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="castget is a simple, command-line based RSS enclosure downloader. It is primarily intended for automatic, unattended downloading of podcasts."
HOMEPAGE="http://www.nongnu.org/castget/"
SRC_URI="http://savannah.nongnu.org/download/castget/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2 dev-libs/libxml2 media-libs/id3lib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}


src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
