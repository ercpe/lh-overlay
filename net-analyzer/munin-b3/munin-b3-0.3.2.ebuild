# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Template for Munin using Twitter Bootstrap 3"
HOMEPAGE="https://ercpe.de/projects/munin-b3"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="net-analyzer/munin"

src_install() {
	insinto /usr/share/${PN}
	doins -r templates static
	dodoc README.md
}
