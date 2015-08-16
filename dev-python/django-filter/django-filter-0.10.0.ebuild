# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="A generic system for filtering Django QuerySets based on user selections"
HOMEPAGE="https://github.com/alex/django-filter"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

CDEPEND=">=dev-python/django-1.4.5[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="test? ( ${CDEPEND} )"

python_prepare() {
	sed \
		-e 's:execute_from_command_line(.*:sys.exit(execute_from_command_line(argv)):g' \
		-i runtests.py || die
}

python_test() {
	${EPYTHON} runtests.py || die
}
