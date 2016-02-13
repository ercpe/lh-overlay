# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )

inherit distutils-r1 vcs-snapshot

GIT_COMMIT="3d11edf75ae9620a752f8804d4ea8d0e6bd539ed"

DESCRIPTION="python module that will be able to read/write perl storable"
HOMEPAGE="https://github.com/CowboyTim/python-storable"
SRC_URI="https://github.com/CowboyTim/${PN}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="libpng"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
