# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 ) # fuzzywuzzy doesnt support pypy

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Virustotal integration for amavisd-new"
HOMEPAGE="https://code.not-your-server.de/amavisvt.git/"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

PYTHON_REQ_USE="sqlite"

CDEPEND="dev-python/requests[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
		|| ( dev-python/python-magic[${PYTHON_USEDEP}] dev-python/filemagic[${PYTHON_USEDEP}] )
		dev-python/python-levenshtein[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? (
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
		)
		${CDEPEND}"
RDEPEND="${CDEPEND}"

src_install() {
	distutils-r1_src_install
	python_foreach_impl python_newscript "${S}"/${PN}/${PN}d.py "${PN}d"
	python_foreach_impl python_newscript "${S}"/${PN}/${PN}c.py "${PN}c"

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}

	dodoc "${S}"/amavisvt_example.cfg

	insinto /etc
	newins ${PN}_example.cfg ${PN}.cfg

	keepdir /var/lib/${PN}/
	grep -q amavis /etc/passwd && chown amavis:amavis "${D}"/var/lib/${PN}/
}

python_test() {
	emake test_default_python
}
