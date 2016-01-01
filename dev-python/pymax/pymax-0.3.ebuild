# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )

inherit distutils-r1

DESCRIPTION="Python implementation of the ELV MAX! Cube API"
HOMEPAGE="https://ercpe.de/projects/pymax"
SRC_URI="https://github.com/ercpe/pymax/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}]  )"
RDEPEND=""

src_install() {
	distutils-r1_src_install

	python_foreach_impl python_newscript "${S}"/src/pymax/__main__.py "maxc"
}

src_test() {
	make test || die
}