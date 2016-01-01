# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="A wrapper for The Movie Database API v3"
HOMEPAGE="https://pypi.python.org/pypi/tmdbsimple https://github.com/celiao/tmdbsimple"
SRC_URI="https://github.com/celiao/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
