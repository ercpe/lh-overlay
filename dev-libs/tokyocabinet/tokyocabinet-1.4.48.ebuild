# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A modern implementation of DBM"
HOMEPAGE="http://fallabs.com/tokyocabinet/"
SRC_URI="http://fallabs.com/tokyocabinet/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-*.patch
}
