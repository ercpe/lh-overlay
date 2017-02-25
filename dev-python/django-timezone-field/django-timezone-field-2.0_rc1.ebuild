# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

MY_PV=${PV/_rc/rc}

DESCRIPTION="Django app providing database and form fields for pytz timezone objects"
HOMEPAGE="https://github.com/mfogel/django-timezone-field"
SRC_URI="https://github.com/mfogel/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
		<dev-python/django-1.10[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${MY_PV}"
