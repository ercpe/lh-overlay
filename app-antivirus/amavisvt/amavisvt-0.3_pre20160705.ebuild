# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 ) # fuzzywuzzy doesnt support pypy

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Virustotal integration for amavisd-new"
HOMEPAGE="https://code.not-your-server.de/amavisvt.git/"
SRC_URI="https://github.com/ercpe/amavisvt/archive/2e0ad0577909ca14d49e94530f62bb9c5e5128ca.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

PYTHON_REQ_USE="sqlite"

CDEPEND="dev-python/requests[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
		dev-python/filemagic[${PYTHON_USEDEP}]
		dev-python/fuzzywuzzy[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? (
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		)
		${CDEPEND}"
RDEPEND="${CDEPEND}"

src_install() {
	distutils-r1_src_install
	python_foreach_impl python_newscript "${S}"/amavisvt/__main__.py "amavisvt"

	dodoc "${S}"/amavisvt_example.cfg

	insinto /etc
	newins ${PN}_example.cfg ${PN}.cfg
}

python_test() {
	emake test_default_python
}