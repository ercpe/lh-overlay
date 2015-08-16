# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit rpm

DESCRIPTION="The hackable editor"
HOMEPAGE="https://atom.io"
SRC_URI="https://github.com/atom/atom/releases/download/v${PV}/atom.x86_64.rpm -> ${P}.rpm"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

QA_PREBUILT="usr/.*"

S="${WORKDIR}"

src_install () {
	mv usr "${ED}" || die
}
