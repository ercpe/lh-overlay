# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python client library for accessing the disqus.com API"
HOMEPAGE="https://github.com/disqus/disqus-python"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? (
	dev-python/mock
)"

S="${WORKDIR}"/${P}

python_test() {
	${EPYTHON} "${S}/disqusapi/tests.py" || die
}
