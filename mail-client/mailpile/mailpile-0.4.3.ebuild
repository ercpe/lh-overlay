# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="An experimental indexing and search engine for e-mail"
HOMEPAGE="https://www.mailpile.is/"
SRC_URI="https://github.com/pagekite/Mailpile/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/jinja:0[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/pgpdump[${PYTHON_USEDEP}]
	dev-python/pydns:2[${PYTHON_USEDEP}]
	>=dev-python/selenium-2.40.0[${PYTHON_USEDEP}]
	mail-filter/spambayes[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"

python_prepare_all() {
	rm -rvf test* || die
	distutils-r1_python_prepare_all
}
