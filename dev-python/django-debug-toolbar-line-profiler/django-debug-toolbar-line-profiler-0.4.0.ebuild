# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="Profiling extension for django-debug-toolbar"
HOMEPAGE="https://github.com/dmclain/django-debug-toolbar-line-profiler"
SRC_URI="https://github.com/dmclain/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="dev-python/line_profiler[${PYTHON_USEDEP}]
		dev-python/django-debug-toolbar[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

IUSE=""
