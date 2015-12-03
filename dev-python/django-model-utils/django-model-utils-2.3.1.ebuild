# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} pypy )

inherit distutils-r1

DESCRIPTION="Django model mixins and utilities"
HOMEPAGE="https://github.com/carljm/django-model-utils https://django-model-utils.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/django-1.4.10[${PYTHON_USEDEP}]"
DEPEND=""

python_test() {
	esetup.py test
}
