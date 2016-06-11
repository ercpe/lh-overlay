# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} ) # ,5 pypy

inherit distutils-r1 vcs-snapshot

MY_PV="1.0.7.dev20160607111203"

DESCRIPTION="Python library for interacting with JIRA via REST APIs."
HOMEPAGE="https://pypi.python.org/pypi/jira"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
			dev-python/requests-oauthlib[${PYTHON_USEDEP}]
			dev-python/filemagic[${PYTHON_USEDEP}]"
#			>=dev-python/tlslite-0.4.4[${PYTHON_USEDEP}]

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	sed -i -e 's/.*setup_requires.*//g' "${S}"/setup.py || die
}
