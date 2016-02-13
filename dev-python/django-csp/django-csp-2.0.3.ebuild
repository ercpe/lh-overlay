# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Content Security Policy for Django"
HOMEPAGE="https://github.com/mozilla/django-csp"
SRC_URI="https://github.com/mozilla/django-csp/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_test() {
	PYTHONPATH=".:${PYTHONPATH}" DJANGO_SETTINGS_MODULE="test_settings" django-admin.py test csp || die
}