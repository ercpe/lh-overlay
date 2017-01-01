# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4} ) # ,5 pypy

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python library for interacting with JIRA via REST APIs."
HOMEPAGE="https://pypi.python.org/pypi/jira"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
			dev-python/requests-oauthlib[${PYTHON_USEDEP}]
			dev-python/filemagic[${PYTHON_USEDEP}]"
#			>=dev-python/tlslite-0.4.4[${PYTHON_USEDEP}]

src_prepare() {
	default
	sed -i -e 's/.*setup_requires.*//g' "${S}"/setup.py || die
}
