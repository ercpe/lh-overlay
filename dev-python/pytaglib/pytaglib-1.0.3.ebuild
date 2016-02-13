# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Python 2.x/3.x bindings for the Taglib audio metadata library"
HOMEPAGE="https://github.com/supermihi/pytaglib"
SRC_URI="https://github.com/supermihi/pytaglib/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="media-libs/taglib"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"

python_test() {
	PYTHONPATH="src:${PYTHONPATH}" esetup.py test
}
