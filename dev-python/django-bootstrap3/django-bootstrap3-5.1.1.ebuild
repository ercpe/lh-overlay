# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} pypy )

inherit distutils-r1

DESCRIPTION="Bootstrap 3 integration with Django"
HOMEPAGE="https://github.com/dyve/django-bootstrap3"
SRC_URI="https://github.com/dyve/django-bootstrap3/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

python_compile_all() {
	if use doc; then
		cd "docs" || die
		emake html
		HTML_DOCS=( docs/_build/html/. )
	fi
}
