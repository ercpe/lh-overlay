# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 ) # python3_{4,5}

inherit distutils-r1

DESCRIPTION="Super easy ModelViews for knockout.js for your Django models"
HOMEPAGE="https://pypi.python.org/pypi/django-knockout-modeler/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/remove-fake-models.patch )