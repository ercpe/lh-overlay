# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

inherit distutils-r1

DESCRIPTION="MAC address model and form fields for Django apps"
HOMEPAGE="https://github.com/tubaman/django-macaddress"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> booboo.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/django-nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

PATCHES=(
	"${FILESDIR}"/${PN}-1.3.1-python3.patch
	)

# Not included
RESTRICT=test

python_test() {
	${PYTHON} runtests.py || die
}
