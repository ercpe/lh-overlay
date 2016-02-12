# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} ) # ,5 pypy

inherit distutils-r1 vcs-snapshot

# see https://github.com/pycontribs/jira/issues/107#issuecomment-148405249
GIT_COMMIT="0ad3c352839060da9dc146df635a97119eccd114"

DESCRIPTION="Python library for interacting with JIRA via REST APIs."
HOMEPAGE="https://pypi.python.org/pypi/jira"
SRC_URI="https://github.com/pycontribs/jira/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
			dev-python/requests-oauthlib[${PYTHON_USEDEP}]
			dev-python/filemagic[${PYTHON_USEDEP}]"
#			>=dev-python/tlslite-0.4.4[${PYTHON_USEDEP}]

src_prepare() {
	sed -i -e 's/.*setup_requires.*//g' "${S}"/setup.py || die
}