# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A multi-language port of Browserscope's user agent parser."
HOMEPAGE="https://github.com/tobie/ua-parser"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

src_install() {
	insinto /usr/share/${PN}
	doins regexes.yaml
	doins -r test_resources
}