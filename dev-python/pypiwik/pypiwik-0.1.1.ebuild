# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} pypy )

inherit distutils-r1

DESCRIPTION="Python implementation of the Piwik HTTP API"
HOMEPAGE="https://ercpe.de/projects/pypiwik"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND=""
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

x_python_compile_all() {
	if use doc; then
		cd "docs" || die
		emake html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

x_python_test() {
	coverage run --source=bootstrap3 manage.py test || die
}
