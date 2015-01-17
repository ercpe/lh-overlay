# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils vcs-snapshot

DESCRIPTION="Template for Munin using Twitter Bootstrap 3"
HOMEPAGE="https://ercpe.de/projects/munin-b3"
SRC_URI="https://repos.j-schmitz.net/gitweb/?p=munin-b3.git;a=snapshot;h=bba4e52de950046a85c32525538f6a5bdd8767e7;sf=tgz -> ${P}.tar.gz"

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
