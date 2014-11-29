# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Django model mixins and utilities"
HOMEPAGE="https://github.com/carljm/django-model-utils"
SRC_URI="https://github.com/carljm/django-model-utils/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/django-1.4.10[${PYTHON_USEDEP}]"
DEPEND=""
