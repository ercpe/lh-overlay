# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit vcs-snapshot

GIT_COMMIT="5d73898fa8158b7616193973e64e920fee8668ef"

DESCRIPTION="JSON output from a shell"
HOMEPAGE="https://github.com/jpmens/jo"
SRC_URI="https://github.com/jpmens/jo/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	exeinto /usr/bin
	doexe ${PN}
	doman ${PN}.1
}
