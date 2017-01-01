# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )

inherit distutils-r1

DESCRIPTION="Library for a filter DSL in python"
HOMEPAGE="https://ercpe.de/projects/phylter"
SRC_URI="https://code.not-your-server.de/phylter.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test django"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? (
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		)"
RDEPEND="django? (
	dev-python/django[${PYTHON_USEDEP}]
)"

src_test() {
	make test || die
}