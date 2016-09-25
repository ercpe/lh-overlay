# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5}  )

inherit distutils-r1

DESCRIPTION="Subdomain helpers for the Django framework including subdomain-based URL routing"
HOMEPAGE="https://github.com/tkaemming/django-subdomains"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		${RDEPEND}
		test? (
			dev-python/mock[${PYTHON_USEDEP}]
		)"

python_test() {
	esetup.py test
}
