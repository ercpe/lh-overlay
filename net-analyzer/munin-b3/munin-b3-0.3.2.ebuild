# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Template for Munin using Twitter Bootstrap 3"
HOMEPAGE="https://ercpe.de/projects/munin-b3"
SRC_URI="https://git.ercpe.de/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="net-analyzer/munin"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /usr/share/${PN}
	doins -r templates static
	dodoc README.md
}
