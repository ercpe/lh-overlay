# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="Wrapper for obnam"
HOMEPAGE="https://ercpe.de/projects/obwrap"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

src_install() {
	python_foreach_impl python_newscript "${S}"/src/${PN}/main.py ${PN}

	insinto /etc/${PN}
	newins "${S}"/doc/default.cfg ${PN}.cfg
}
