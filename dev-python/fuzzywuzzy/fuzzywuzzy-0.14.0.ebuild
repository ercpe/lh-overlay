# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Fuzzy String Matching in Python"
HOMEPAGE="https://github.com/seatgeek/fuzzywuzzy"
SRC_URI="https://github.com/seatgeek/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? (
			dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/pycodestyle[${PYTHON_USEDEP}]
			dev-python/hypothesis[${PYTHON_USEDEP}]
		)"
RDEPEND="dev-python/python-levenshtein[${PYTHON_USEDEP}]"

python_test() {
	# tests somewhat broken on python 3.x
	if [[ "${EPYTHON}" == "python2.7" ]]; then
		py.test || die
	fi
}
