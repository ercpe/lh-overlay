# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Full featured Python package for parsing and generating vCard and vCalendar files"
HOMEPAGE="http://vobject.skyhouseconsulting.com/ https://pypi.python.org/pypi/vobject"
SRC_URI="https://github.com/eventable/vobject/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

DOCS=( ACKNOWLEDGEMENTS.txt )

python_test() {
	"${PYTHON}" tests.py || die "Testing failed under ${EPYTHON}"
}
