# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/udept/udept-0.5.99.0.2.95-r1.ebuild,v 1.2 2008/02/03 07:13:03 dirtyepic Exp $

EAPI=5

inherit eutils

DESCRIPTION="A Portage analysis toolkit"
HOMEPAGE="http://catmur.co.uk/gentoo/udept"
SRC_URI="http://files.catmur.co.uk/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~mips ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/udept.default-use.patch
}
