# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )

inherit distutils-r1

DESCRIPTION="Bootstrap 3 integration with Django"
HOMEPAGE="https://github.com/dyve/django-bootstrap3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/coverage[${PYTHON_USEDEP}] )"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

python_compile_all() {
	if use doc; then
		cd "docs" || die
		emake html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	coverage run --source=bootstrap3 manage.py test || die
}
