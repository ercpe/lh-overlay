# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} pypy )

inherit distutils-r1 vcs-snapshot

GIT_COMMIT="6d13fb53851d5f083d1538685cf70bad0849c208"

DESCRIPTION="Python implementation of a reverse polish notation parser"
HOMEPAGE="https://ercpe.de/projects/pyrpn"
SRC_URI="https://github.com/ercpe/${PN}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}]  )"
RDEPEND=""

python_test() {
	make test_default_python || die
}